import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/features/settings/settings_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: settings.when(
        data: (settings) => ListView(
          children: [
            _buildSectionHeader(context, "Account"),
            ListTile(
              leading: const Icon(Icons.account_circle_outlined),
              title: const Text('Account Settings'),
              subtitle: const Text('Manage your account details'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // TODO: Navigate to account settings
              },
            ),
            const Divider(),
            _buildSectionHeader(context, "Preferences"),
            SwitchListTile(
              secondary: const Icon(Icons.play_circle_outline),
              title: const Text('Autoplay videos'),
              value: settings.autoplay,
              onChanged: (value) {
                // TODO: Update settings
              },
            ),
            SwitchListTile(
              secondary: const Icon(Icons.network_cell_outlined),
              title: const Text('Use mobile data for downloads'),
              value: settings.useMobileData,
              onChanged: (value) {
                // TODO: Update settings
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications_outlined),
              title: const Text('Notification Preferences'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // TODO: Navigate to notification settings
              },
            ),
            const Divider(),
            _buildSectionHeader(context, "Appearance"),
             SwitchListTile(
              secondary: const Icon(Icons.brightness_6_outlined),
              title: const Text('Dark Mode'),
              value: Theme.of(context).brightness == Brightness.dark,
              onChanged: (value) {
                // TODO: Implement theme switching
              },
            ),
             ListTile(
              leading: const Icon(Icons.language_outlined),
              title: const Text('Language'),
              subtitle: const Text('English'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // TODO: Navigate to language settings
              },
            ),
            const Divider(),
            _buildSectionHeader(context, "About"),
            ListTile(
              leading: const Icon(Icons.privacy_tip_outlined),
              title: const Text('Privacy Policy'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // TODO: Open privacy policy URL
              },
            ),
            ListTile(
              leading: const Icon(Icons.gavel_outlined),
              title: const Text('Terms of Service'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // TODO: Open terms of service URL
              },
            ),
            const Divider(),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: Implement delete account flow
                },
                icon: const Icon(Icons.delete_forever_outlined),
                label: const Text('Delete Account'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.error,
                  foregroundColor: theme.colorScheme.onError,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context)
            .textTheme
            .bodySmall
            ?.copyWith(fontWeight: FontWeight.bold, letterSpacing: 1.5),
      ),
    );
  }
}
