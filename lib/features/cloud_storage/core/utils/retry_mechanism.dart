import 'dart:async';
import 'dart:math';

class RetryConfig {
  const RetryConfig({
    this.maxAttempts = 3,
    this.initialDelay = const Duration(seconds: 1),
    this.maxDelay = const Duration(seconds: 30),
    this.backoffMultiplier = 2.0,
    this.retryableExceptions = const [],
  });

  final int maxAttempts;
  final Duration initialDelay;
  final Duration maxDelay;
  final double backoffMultiplier;
  final List<Type> retryableExceptions;

  static const RetryConfig defaultConfig = RetryConfig();
  static const RetryConfig aggressiveConfig = RetryConfig(
    maxAttempts: 5,
    initialDelay: Duration(milliseconds: 500),
    maxDelay: Duration(seconds: 60),
    backoffMultiplier: 1.5,
  );
}

class RetryMechanism {
  static Future<T> retry<T>(
    Future<T> Function() operation, {
    RetryConfig config = RetryConfig.defaultConfig,
    String? operationName,
    void Function(int attempt, Duration delay)? onRetry,
  }) async {
    int attempt = 0;
    Duration delay = config.initialDelay;

    while (true) {
      try {
        attempt++;
        return await operation();
      } catch (e) {
        if (attempt >= config.maxAttempts) {
          throw RetryException(
            'Operation failed after ${config.maxAttempts} attempts',
            e,
            attempt,
          );
        }

        if (!_shouldRetry(e, config.retryableExceptions)) {
          rethrow;
        }

        if (onRetry != null) {
          onRetry(attempt, delay);
        }

        await Future.delayed(delay);
        delay = _calculateNextDelay(delay, config);
      }
    }
  }

  static bool _shouldRetry(dynamic error, List<Type> retryableExceptions) {
    if (retryableExceptions.isEmpty) {
      // Default retryable exceptions
      return error is TimeoutException ||
          error.toString().contains('network') ||
          error.toString().contains('connection') ||
          error.toString().contains('timeout');
    }

    return retryableExceptions.any((type) => error.runtimeType == type);
  }

  static Duration _calculateNextDelay(
      Duration currentDelay, RetryConfig config) {
    final nextDelay = Duration(
      milliseconds:
          (currentDelay.inMilliseconds * config.backoffMultiplier).round(),
    );
    return nextDelay > config.maxDelay ? config.maxDelay : nextDelay;
  }
}

class RetryException implements Exception {
  const RetryException(this.message, this.originalError, this.attempts);

  final String message;
  final dynamic originalError;
  final int attempts;

  @override
  String toString() =>
      'RetryException: $message (attempts: $attempts, original: $originalError)';
}
