import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/app/creati_theme.dart';
import 'package:vidspod_mobile/features/settings/settings_providers.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    return Scaffold(
      backgroundColor: CreatiTheme.black,
      appBar: AppBar(
        title: Text('Settings', style: CreatiTheme.headingLarge()),
      ),
      body: settings.when(
        data: (settings) => ListView(
          padding: const EdgeInsets.only(top: 8),
          physics: const BouncingScrollPhysics(),
          children: [
            _SectionHeader('Account'),
            _SettingTile(Icons.account_circle_outlined, 'Account Settings', 'Manage your account details'),
            const _Divider(),
            _SectionHeader('Preferences'),
            _SwitchTile(Icons.play_circle_outline, 'Autoplay videos', settings.autoplay, (_) {}),
            _SwitchTile(Icons.network_cell_outlined, 'Use mobile data for downloads', settings.useMobileData, (_) {}),
            _SettingTile(Icons.notifications_outlined, 'Notification Preferences', null),
            const _Divider(),
            _SectionHeader('Appearance'),
            _SwitchTile(Icons.brightness_6_outlined, 'Dark Mode', true, (_) {}),
            _SettingTile(Icons.language_outlined, 'Language', 'English'),
            const _Divider(),
            _SectionHeader('About'),
            _SettingTile(Icons.privacy_tip_outlined, 'Privacy Policy', null),
            _SettingTile(Icons.gavel_outlined, 'Terms of Service', null),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: Colors.red.withAlpha(80)),
                    color: Colors.red.withAlpha(15),
                  ),
                  child: Center(
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Icon(Icons.delete_forever_outlined, color: Colors.red.withAlpha(200), size: 18),
                      const SizedBox(width: 8),
                      Text('Delete Account', style: TextStyle(color: Colors.red.withAlpha(200), fontSize: 15, fontWeight: FontWeight.w600, letterSpacing: 0.3)),
                    ]),
                  ),
                ),
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator(color: CreatiTheme.purple)),
        error: (error, _) => Center(child: Text('Error: $error', style: const TextStyle(color: Colors.white38))),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 6),
      child: Text(title.toUpperCase(),
        style: TextStyle(
          color: CreatiTheme.purple.withAlpha(180),
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: CreatiTheme.letterSpacingLabel,
        ),
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  const _SettingTile(this.icon, this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
        child: Row(children: [
          Icon(icon, color: Colors.white.withAlpha(150), size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: CreatiTheme.bodyMedium(fontWeight: FontWeight.w500, fontSize: 15)),
              if (subtitle != null) ...[
                const SizedBox(height: 2),
                Text(subtitle!, style: CreatiTheme.caption(color: Colors.white.withAlpha(80))),
              ],
            ]),
          ),
          Icon(Icons.chevron_right, color: Colors.white.withAlpha(80), size: 20),
        ]),
      ),
    );
  }
}

class _SwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;
  const _SwitchTile(this.icon, this.title, this.value, this.onChanged);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        child: Row(children: [
          Icon(icon, color: Colors.white.withAlpha(150), size: 22),
          const SizedBox(width: 14),
          Expanded(child: Text(title, style: CreatiTheme.bodyMedium(fontWeight: FontWeight.w500, fontSize: 15))),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: CreatiTheme.purple,
            activeTrackColor: CreatiTheme.purple.withAlpha(80),
          ),
        ]),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Divider(color: CreatiTheme.cardBorder.withAlpha(40), height: 1),
    );
  }
}
