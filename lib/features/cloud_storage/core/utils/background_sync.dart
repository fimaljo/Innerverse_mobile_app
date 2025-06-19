import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BackgroundSyncService {
  static Timer? _syncTimer;
  static bool _isInitialized = false;

  static Future<void> initialize() async {
    if (_isInitialized) return;

    // Initialize sync timer for periodic sync when app is active
    _isInitialized = true;
  }

  static Future<void> scheduleOneTimeSync({
    Duration delay = const Duration(minutes: 1),
  }) async {
    _syncTimer?.cancel();
    _syncTimer = Timer(delay, () async {
      await _performBackgroundSync();
    });
  }

  static Future<void> schedulePeriodicSync({
    Duration frequency = const Duration(hours: 6),
  }) async {
    _syncTimer?.cancel();
    _syncTimer = Timer.periodic(frequency, (timer) async {
      await _performBackgroundSync();
    });
  }

  static Future<void> cancelAllTasks() async {
    _syncTimer?.cancel();
    _syncTimer = null;
  }

  static Future<void> cancelTask(String taskName) async {
    // For now, just cancel all tasks since we're using a single timer
    await cancelAllTasks();
  }

  static Future<bool> isNetworkAvailable() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  static Future<bool> shouldSync() async {
    final prefs = await SharedPreferences.getInstance();
    final lastSyncTime = prefs.getString('last_background_sync');

    if (lastSyncTime == null) {
      return true;
    }

    final lastSync = DateTime.parse(lastSyncTime);
    final now = DateTime.now();
    final timeSinceLastSync = now.difference(lastSync);

    // Sync if it's been more than 1 hour since last sync
    return timeSinceLastSync.inHours >= 1;
  }

  static Future<void> updateLastSyncTime() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        'last_background_sync', DateTime.now().toIso8601String());
  }

  static Future<Map<String, dynamic>> getSyncStats() async {
    final prefs = await SharedPreferences.getInstance();
    final lastSyncTime = prefs.getString('last_background_sync');
    final totalSyncs = prefs.getInt('total_background_syncs') ?? 0;
    final failedSyncs = prefs.getInt('failed_background_syncs') ?? 0;
    final lastSyncError = prefs.getString('last_background_sync_error');

    return {
      'lastSyncTime': lastSyncTime,
      'totalSyncs': totalSyncs,
      'failedSyncs': failedSyncs,
      'successRate': totalSyncs > 0
          ? ((totalSyncs - failedSyncs) / totalSyncs * 100).toStringAsFixed(1)
          : '0.0',
      'lastSyncError': lastSyncError,
    };
  }

  static Future<void> incrementSyncCount(bool success) async {
    final prefs = await SharedPreferences.getInstance();
    final totalSyncs = (prefs.getInt('total_background_syncs') ?? 0) + 1;
    await prefs.setInt('total_background_syncs', totalSyncs);

    if (!success) {
      final failedSyncs = (prefs.getInt('failed_background_syncs') ?? 0) + 1;
      await prefs.setInt('failed_background_syncs', failedSyncs);
    }
  }

  static Future<void> setLastSyncError(String error) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_background_sync_error', error);
  }

  static Future<bool> _performBackgroundSync() async {
    try {
      // Check if network is available
      if (!await isNetworkAvailable()) {
        return false;
      }

      // Check if we should sync
      if (!await shouldSync()) {
        return true;
      }

      // Perform the actual sync
      // This will be implemented to call the actual sync logic
      // For now, we'll just simulate a sync operation
      await Future.delayed(const Duration(seconds: 2));

      // Simulate success/failure (90% success rate)
      final random = DateTime.now().millisecondsSinceEpoch % 10;
      final success = random < 9;

      // Update stats
      await incrementSyncCount(success);

      if (success) {
        await updateLastSyncTime();
        await setLastSyncError('');
      } else {
        await setLastSyncError('Background sync failed');
      }

      return success;
    } catch (e) {
      await setLastSyncError(e.toString());
      await incrementSyncCount(false);
      return false;
    }
  }
}
