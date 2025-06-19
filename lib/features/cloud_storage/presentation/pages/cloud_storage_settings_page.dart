import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:innerverse/features/cloud_storage/domain/entities/sync_status.dart';
import 'package:innerverse/features/cloud_storage/presentation/blocs/cloud_storage_bloc.dart';
import 'package:innerverse/features/cloud_storage/presentation/blocs/cloud_storage_event.dart';
import 'package:innerverse/features/cloud_storage/presentation/blocs/cloud_storage_state.dart';
import 'package:innerverse/shared/buttons/app_primary_button.dart';
import 'package:innerverse/features/cloud_storage/core/utils/background_sync.dart';
import 'package:innerverse/features/cloud_storage/core/utils/offline_queue.dart';
import 'package:innerverse/features/cloud_storage/core/utils/conflict_resolution.dart';
import 'package:innerverse/features/cloud_storage/domain/failures/cloud_storage_failure.dart';

class CloudStorageSettingsPage extends StatelessWidget {
  const CloudStorageSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cloud Storage Settings'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocConsumer<CloudStorageBloc, CloudStorageState>(
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return _buildLoadingView(context);
          }

          return _buildAuthenticatedView(context, state);
        },
      ),
    );
  }

  Widget _buildLoadingView(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading...'),
        ],
      ),
    );
  }

  Widget _buildAuthenticatedView(
      BuildContext context, CloudStorageState state) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildAuthenticationSection(context, state.isAuthenticated),
          const SizedBox(height: 24),
          _buildSyncSection(context, state),
          const SizedBox(height: 24),
          _buildAdvancedFeaturesSection(context),
          const SizedBox(height: 24),
          _buildOfflineQueueSection(context),
          const SizedBox(height: 24),
          _buildConflictResolutionSection(context),
          const SizedBox(height: 24),
          _buildBackgroundSyncSection(context),
        ],
      ),
    );
  }

  Widget _buildAuthenticationSection(
      BuildContext context, bool isAuthenticated) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  isAuthenticated ? Icons.cloud_done : Icons.cloud_off,
                  color: isAuthenticated ? Colors.green : Colors.grey,
                ),
                const SizedBox(width: 8),
                Text(
                  'Authentication',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              isAuthenticated
                  ? 'Connected to Google Drive'
                  : 'Not connected to Google Drive',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (isAuthenticated) {
                        context.read<CloudStorageBloc>().add(
                              const SignOutRequested(),
                            );
                      } else {
                        context.read<CloudStorageBloc>().add(
                              const AuthenticateRequested(),
                            );
                      }
                    },
                    child: Text(isAuthenticated ? 'Sign Out' : 'Sign In'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSyncSection(BuildContext context, CloudStorageState state) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.sync),
                const SizedBox(width: 8),
                Text(
                  'Sync',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (state.syncStatus != null) ...[
              _buildSyncStatusInfo(context, state.syncStatus!),
              const SizedBox(height: 16),
            ],
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: state.isLoading
                        ? null
                        : () {
                            context.read<CloudStorageBloc>().add(
                                  const PerformFullSyncRequested(),
                                );
                          },
                    child: state.isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Sync Now'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSyncStatusInfo(BuildContext context, dynamic syncStatus) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Last Sync: ${syncStatus.lastSyncTime?.toString() ?? 'Never'}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Text(
          'Status: ${syncStatus.isSyncing == true ? 'Syncing' : 'Idle'}',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        if (syncStatus.lastSyncError != null)
          Text(
            'Error: ${syncStatus.lastSyncError}',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.red,
                ),
          ),
      ],
    );
  }

  Widget _buildAdvancedFeaturesSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.settings),
                const SizedBox(width: 8),
                Text(
                  'Advanced Features',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildFeatureToggle(
              context,
              'Image Compression',
              'Compress images before upload to save bandwidth',
              true,
              (value) {
                // TODO: Implement image compression toggle
              },
            ),
            const SizedBox(height: 8),
            _buildFeatureToggle(
              context,
              'Retry Logic',
              'Automatically retry failed operations',
              true,
              (value) {
                // TODO: Implement retry logic toggle
              },
            ),
            const SizedBox(height: 8),
            _buildFeatureToggle(
              context,
              'Conflict Resolution',
              'Automatically resolve sync conflicts',
              false,
              (value) {
                // TODO: Implement conflict resolution toggle
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOfflineQueueSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.queue),
                const SizedBox(width: 8),
                Text(
                  'Offline Queue',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            FutureBuilder<int>(
              future: OfflineQueueManager.getQueueSize(),
              builder: (context, snapshot) {
                final queueSize = snapshot.data ?? 0;
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Pending operations: $queueSize'),
                        if (queueSize > 0)
                          TextButton(
                            onPressed: () => _showOfflineQueueDetails(context),
                            child: const Text('View Details'),
                          ),
                      ],
                    ),
                    if (queueSize > 0) ...[
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () => _processOfflineQueue(context),
                        child: const Text('Process Queue'),
                      ),
                    ],
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConflictResolutionSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.merge_type),
                const SizedBox(width: 8),
                Text(
                  'Conflict Resolution',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<ConflictResolutionStrategy>(
              decoration: const InputDecoration(
                labelText: 'Default Strategy',
                border: OutlineInputBorder(),
              ),
              value: ConflictResolutionStrategy.timestamp,
              items: ConflictResolutionStrategy.values.map((strategy) {
                return DropdownMenuItem(
                  value: strategy,
                  child: Text(_getStrategyName(strategy)),
                );
              }).toList(),
              onChanged: (value) {
                // TODO: Implement strategy selection
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _showConflictHistory(context),
              child: const Text('View Conflict History'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundSyncSection(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.schedule),
                const SizedBox(width: 8),
                Text(
                  'Background Sync',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildFeatureToggle(
              context,
              'Enable Background Sync',
              'Automatically sync data in the background',
              false,
              (value) async {
                if (value) {
                  await BackgroundSyncService.schedulePeriodicSync();
                } else {
                  await BackgroundSyncService.cancelAllTasks();
                }
              },
            ),
            const SizedBox(height: 16),
            FutureBuilder<Map<String, dynamic>>(
              future: BackgroundSyncService.getSyncStats(),
              builder: (context, snapshot) {
                final stats = snapshot.data ?? {};
                return Column(
                  children: [
                    _buildStatRow('Last Sync',
                        stats['lastSyncTime']?.toString() ?? 'Never'),
                    _buildStatRow(
                        'Total Syncs', (stats['totalSyncs'] ?? 0).toString()),
                    _buildStatRow('Success Rate',
                        (stats['successRate'] ?? '0.0').toString() + '%'),
                    if (stats['lastSyncError'] != null) ...[
                      Builder(
                        builder: (context) {
                          final error = stats['lastSyncError'] as String?;
                          if (error != null && error.isNotEmpty) {
                            return _buildStatRow('Last Error', error);
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureToggle(
    BuildContext context,
    String title,
    String description,
    bool initialValue,
    ValueChanged<bool> onChanged,
  ) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                description,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        Switch(
          value: initialValue,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value),
        ],
      ),
    );
  }

  String _getStrategyName(ConflictResolutionStrategy strategy) {
    switch (strategy) {
      case ConflictResolutionStrategy.localWins:
        return 'Local Wins';
      case ConflictResolutionStrategy.remoteWins:
        return 'Remote Wins';
      case ConflictResolutionStrategy.manual:
        return 'Manual';
      case ConflictResolutionStrategy.merge:
        return 'Merge';
      case ConflictResolutionStrategy.timestamp:
        return 'Timestamp';
    }
  }

  void _showOfflineQueueDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Offline Queue Details'),
        content: FutureBuilder<List<QueueOperation>>(
          future: OfflineQueueManager.getPendingOperations(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            final operations = snapshot.data ?? [];
            if (operations.isEmpty) {
              return const Text('No pending operations');
            }

            return SizedBox(
              width: double.maxFinite,
              height: 300,
              child: ListView.builder(
                itemCount: operations.length,
                itemBuilder: (context, index) {
                  final operation = operations[index];
                  return ListTile(
                    title: Text(operation.type.name),
                    subtitle: Text(operation.timestamp.toString()),
                    trailing: Text('Retry: ${operation.retryCount}'),
                  );
                },
              ),
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _processOfflineQueue(BuildContext context) {
    // TODO: Implement offline queue processing
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Processing offline queue...')),
    );
  }

  void _showConflictHistory(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Conflict History'),
        content: const Text('No conflicts detected'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
