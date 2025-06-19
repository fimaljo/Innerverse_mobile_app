import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

enum QueueOperationType {
  uploadHiveBox,
  uploadImage,
  downloadHiveBox,
  downloadImage,
  deleteFile,
  syncMetadata,
}

class QueueOperation {
  const QueueOperation({
    required this.id,
    required this.type,
    required this.data,
    required this.timestamp,
    this.retryCount = 0,
    this.maxRetries = 3,
  });

  final String id;
  final QueueOperationType type;
  final Map<String, dynamic> data;
  final DateTime timestamp;
  final int retryCount;
  final int maxRetries;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type.name,
      'data': data,
      'timestamp': timestamp.toIso8601String(),
      'retryCount': retryCount,
      'maxRetries': maxRetries,
    };
  }

  factory QueueOperation.fromJson(Map<String, dynamic> json) {
    return QueueOperation(
      id: json['id'] as String,
      type: QueueOperationType.values.firstWhere(
        (e) => e.name == json['type'],
      ),
      data: Map<String, dynamic>.from(json['data'] as Map),
      timestamp: DateTime.parse(json['timestamp'] as String),
      retryCount: json['retryCount'] as int? ?? 0,
      maxRetries: json['maxRetries'] as int? ?? 3,
    );
  }

  QueueOperation copyWith({
    String? id,
    QueueOperationType? type,
    Map<String, dynamic>? data,
    DateTime? timestamp,
    int? retryCount,
    int? maxRetries,
  }) {
    return QueueOperation(
      id: id ?? this.id,
      type: type ?? this.type,
      data: data ?? this.data,
      timestamp: timestamp ?? this.timestamp,
      retryCount: retryCount ?? this.retryCount,
      maxRetries: maxRetries ?? this.maxRetries,
    );
  }
}

class OfflineQueueManager {
  static const String _queueKey = 'offline_queue';
  static const String _failedQueueKey = 'failed_queue';

  static Future<void> addOperation(QueueOperation operation) async {
    final prefs = await SharedPreferences.getInstance();
    final queue = await _getQueue(prefs, _queueKey);
    queue.add(operation);
    await _saveQueue(prefs, _queueKey, queue);
  }

  static Future<void> addFailedOperation(QueueOperation operation) async {
    final prefs = await SharedPreferences.getInstance();
    final queue = await _getQueue(prefs, _failedQueueKey);
    queue.add(operation);
    await _saveQueue(prefs, _failedQueueKey, queue);
  }

  static Future<List<QueueOperation>> getPendingOperations() async {
    final prefs = await SharedPreferences.getInstance();
    return await _getQueue(prefs, _queueKey);
  }

  static Future<List<QueueOperation>> getFailedOperations() async {
    final prefs = await SharedPreferences.getInstance();
    return await _getQueue(prefs, _failedQueueKey);
  }

  static Future<void> removeOperation(String operationId) async {
    final prefs = await SharedPreferences.getInstance();
    final queue = await _getQueue(prefs, _queueKey);
    queue.removeWhere((op) => op.id == operationId);
    await _saveQueue(prefs, _queueKey, queue);
  }

  static Future<void> clearQueue() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_queueKey);
  }

  static Future<void> clearFailedQueue() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_failedQueueKey);
  }

  static Future<int> getQueueSize() async {
    final operations = await getPendingOperations();
    return operations.length;
  }

  static Future<int> getFailedQueueSize() async {
    final operations = await getFailedOperations();
    return operations.length;
  }

  static Future<List<QueueOperation>> getOperationsByType(
    QueueOperationType type,
  ) async {
    final operations = await getPendingOperations();
    return operations.where((op) => op.type == type).toList();
  }

  static Future<void> retryOperation(String operationId) async {
    final prefs = await SharedPreferences.getInstance();
    final failedQueue = await _getQueue(prefs, _failedQueueKey);
    final operation = failedQueue.firstWhere((op) => op.id == operationId);

    if (operation.retryCount < operation.maxRetries) {
      final updatedOperation = operation.copyWith(
        retryCount: operation.retryCount + 1,
      );

      // Move back to pending queue
      failedQueue.removeWhere((op) => op.id == operationId);
      await _saveQueue(prefs, _failedQueueKey, failedQueue);

      final pendingQueue = await _getQueue(prefs, _queueKey);
      pendingQueue.add(updatedOperation);
      await _saveQueue(prefs, _queueKey, pendingQueue);
    }
  }

  static Future<List<QueueOperation>> _getQueue(
    SharedPreferences prefs,
    String key,
  ) async {
    final queueJson = prefs.getStringList(key) ?? [];
    return queueJson
        .map((json) => QueueOperation.fromJson(
              Map<String, dynamic>.from(jsonDecode(json) as Map),
            ))
        .toList();
  }

  static Future<void> _saveQueue(
    SharedPreferences prefs,
    String key,
    List<QueueOperation> queue,
  ) async {
    final queueJson =
        queue.map((operation) => jsonEncode(operation.toJson())).toList();
    await prefs.setStringList(key, queueJson);
  }
}
