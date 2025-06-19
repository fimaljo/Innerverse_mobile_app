import 'dart:async';
import 'package:innerverse/core/events/app_events.dart';

/// Global event bus service for cross-feature communication
/// Follows singleton pattern and provides type-safe event streaming
class EventBusService {
  static final EventBusService _instance = EventBusService._internal();
  factory EventBusService() => _instance;
  EventBusService._internal();

  final StreamController<AppEvent> _controller =
      StreamController<AppEvent>.broadcast();

  /// Stream of all application events
  Stream<AppEvent> get stream => _controller.stream;

  /// Emit an event to all listeners
  void emit(AppEvent event) {
    if (!_controller.isClosed) {
      _controller.add(event);
    }
  }

  /// Listen to specific event types
  Stream<T> on<T extends AppEvent>() {
    return stream.where((event) => event is T).cast<T>();
  }

  /// Dispose the event bus
  void dispose() {
    _controller.close();
  }
}
