import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:innerverse/features/cloud_storage/domain/entities/sync_status.dart';
import 'package:innerverse/features/cloud_storage/presentation/blocs/cloud_storage_bloc.dart';
import 'package:innerverse/features/cloud_storage/presentation/blocs/cloud_storage_event.dart';
import 'package:innerverse/features/cloud_storage/presentation/blocs/cloud_storage_state.dart';
import 'package:innerverse/shared/buttons/app_primary_button.dart';

class CloudStorageSettingsPage extends StatelessWidget {
  const CloudStorageSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cloud Storage',
          style: textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => context.pop(),
        ),
      ),
      body: BlocConsumer<CloudStorageBloc, CloudStorageState>(
        listener: (context, state) {
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error!),
                backgroundColor: colorScheme.error,
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Google Drive Section
                _buildSectionHeader(
                  context,
                  'Google Drive Sync',
                  Icons.cloud_sync,
                  colorScheme.primary,
                ),
                const SizedBox(height: 16),

                // Authentication Status
                _buildAuthStatusCard(context, state),
                const SizedBox(height: 16),

                // Sync Options
                if (state.isAuthenticated) ...[
                  _buildSyncOptionsCard(context, state),
                  const SizedBox(height: 16),
                ],

                // Sync Status
                if (state.syncStatus != null) ...[
                  _buildSyncStatusCard(context, state.syncStatus!),
                  const SizedBox(height: 16),
                ],

                // Information Section
                _buildSectionHeader(
                  context,
                  'About Cloud Storage',
                  Icons.info_outline,
                  colorScheme.secondary,
                ),
                const SizedBox(height: 16),
                _buildInfoCard(context),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    IconData icon,
    Color color,
  ) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(width: 8),
        Text(
          title,
          style: textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildAuthStatusCard(BuildContext context, CloudStorageState state) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  state.isAuthenticated ? Icons.check_circle : Icons.cancel,
                  color: state.isAuthenticated ? Colors.green : Colors.red,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  state.isAuthenticated
                      ? 'Connected to Google Drive'
                      : 'Not connected to Google Drive',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (state.isAuthenticated) ...[
              Text(
                'Your data is securely synced with Google Drive.',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: AppPrimaryButton(
                  onTap: () {
                    context.read<CloudStorageBloc>().add(
                          const SignOutRequested(),
                        );
                  },
                  height: 48,
                  gradientColors: [Colors.red, Colors.red.shade700],
                  child: const Text(
                    'Disconnect',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ] else ...[
              Text(
                'Connect your Google Drive account to backup and sync your memories across devices.',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: AppPrimaryButton(
                  onTap: () {
                    context.read<CloudStorageBloc>().add(
                          const AuthenticateRequested(),
                        );
                  },
                  height: 48,
                  gradientColors: [colorScheme.primary, colorScheme.primary],
                  child: const Text(
                    'Connect to Google Drive',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSyncOptionsCard(BuildContext context, CloudStorageState state) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Sync Options',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: AppPrimaryButton(
                onTap: state.isLoading
                    ? () {}
                    : () {
                        context.read<CloudStorageBloc>().add(
                              const PerformFullSyncRequested(),
                            );
                      },
                height: 48,
                gradientColors: [colorScheme.primary, colorScheme.primary],
                child: state.isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        'Sync Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSyncStatusCard(BuildContext context, SyncStatus syncStatus) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Last Sync',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            if (syncStatus.lastSyncTime != null) ...[
              Text(
                '${syncStatus.lastSyncTime!.day}/${syncStatus.lastSyncTime!.month}/${syncStatus.lastSyncTime!.year} at ${syncStatus.lastSyncTime!.hour}:${syncStatus.lastSyncTime!.minute.toString().padLeft(2, '0')}',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${syncStatus.syncedItems} of ${syncStatus.totalItems} items synced',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ] else ...[
              Text(
                'No sync performed yet',
                style: textTheme.bodyMedium?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What gets synced?',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            _buildInfoItem(
              context,
              'Memories',
              'All your memories with titles, descriptions, and emotions',
              Icons.favorite,
            ),
            const SizedBox(height: 8),
            _buildInfoItem(
              context,
              'World Icons',
              'Your custom world symbols and categories',
              Icons.public,
            ),
            const SizedBox(height: 8),
            _buildInfoItem(
              context,
              'Images',
              'All images attached to your memories',
              Icons.image,
            ),
            const SizedBox(height: 16),
            Text(
              'Privacy & Security',
              style: textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Your data is encrypted and stored securely in your Google Drive account. Only you have access to your data.',
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(
    BuildContext context,
    String title,
    String description,
    IconData icon,
  ) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 20,
          color: colorScheme.primary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                description,
                style: textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
