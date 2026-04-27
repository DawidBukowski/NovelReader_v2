// lib/features/settings/presentation/screens/settings_screen.dart
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          _SectionHeader(title: 'About'),
          ListTile(
            leading: const Icon(Icons.info_outline_rounded),
            title: const Text('OpenReader'),
            subtitle: const Text('Version 1.0.0'),
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip_outlined),
            title: const Text('Privacy'),
            subtitle: const Text(
              'All processing is fully on-device. No data leaves your phone.',
            ),
          ),
          const Divider(),
          _SectionHeader(title: 'Voice Engine'),
          ListTile(
            leading: const Icon(Icons.memory_rounded),
            title: const Text('Powered by sherpa-onnx'),
            subtitle: const Text('Offline neural TTS — no internet required.'),
            trailing: const Icon(Icons.open_in_new_rounded, size: 18),
            onTap: () => launchUrl(
              Uri.parse('https://github.com/k2-fsa/sherpa-onnx'),
            ),
          ),
          const Divider(),
          _SectionHeader(title: 'Storage'),
          ListTile(
            leading: const Icon(Icons.folder_outlined),
            title: const Text('Voice models location'),
            subtitle: const Text(
              'ApplicationDocumentsDirectory/voices/',
            ),
          ),
          const Divider(),
          _SectionHeader(title: 'Danger zone'),
          ListTile(
            leading: Icon(Icons.delete_forever_outlined,
                color: theme.colorScheme.error),
            title: Text('Clear all data',
                style: TextStyle(color: theme.colorScheme.error)),
            subtitle: const Text(
                'Deletes library, downloaded voices, and all settings.'),
            onTap: () => _confirmClearAll(context),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmClearAll(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear all data?'),
        content: const Text(
          'This will permanently delete your library, all downloaded voices, '
              'and reset all settings. This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Delete everything'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      // TODO: wire to a ClearAllDataUseCase in Step 6
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Coming soon')),
      );
    }
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
      child: Text(
        title.toUpperCase(),
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}