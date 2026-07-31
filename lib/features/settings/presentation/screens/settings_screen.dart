import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vidspod_mobile/app/config.dart';
import 'package:vidspod_mobile/core/theme/vr_theme.dart';
import 'package:vidspod_mobile/core/utils/platform_utils.dart';
import 'package:vidspod_mobile/features/settings/domain/settings.dart';
import 'package:vidspod_mobile/features/settings/settings_providers.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool? _autoplay;
  bool? _useMobileData;
  bool _saving = false;

  void _syncFrom(AppSettings settings) {
    _autoplay ??= settings.autoplay;
    _useMobileData ??= settings.useMobileData;
  }

  Future<void> _persist({bool? autoplay, bool? useMobileData}) async {
    final current = ref.read(settingsProvider).valueOrNull;
    if (current == null) return;
    final next = current.copyWith(
      autoplay: autoplay ?? _autoplay ?? current.autoplay,
      useMobileData: useMobileData ?? _useMobileData ?? current.useMobileData,
    );
    if (Config.previewMode) return;
    setState(() => _saving = true);
    try {
      await ref.read(settingsRepositoryProvider).updateSettings(next);
      ref.invalidate(settingsProvider);
    } catch (_) {
      if (mounted) _snack(context, 'Could not save settings');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    return Scaffold(
      backgroundColor: VrTheme.black,
      appBar: AppBar(title: Text('Settings', style: VrTheme.headingLarge())),
      body: settings.when(
        data: (data) {
          _syncFrom(data);
          return Scrollbar(
            child: ListView(
              padding: const EdgeInsets.only(top: 8),
              physics: const BouncingScrollPhysics(),
              children: [
                _SectionHeader('Account'),
                _SettingTile(
                  Icons.account_circle_outlined,
                  'Account Settings',
                  'Manage your account details',
                  () => _snack(context, 'Account settings'),
                ),
                _SettingTile(
                  Icons.link_outlined,
                  'Connected Accounts',
                  'YouTube, LinkedIn, Facebook, etc.',
                  () => context.push('/connections'),
                ),
                const _Divider(),
                _SectionHeader('Voice & AI'),
                _SettingTile(
                  Icons.record_voice_over_outlined,
                  'Voice Provider',
                  'ElevenLabs (default)',
                  () => _snack(context, 'Voice provider settings'),
                ),
                _SettingTile(
                  Icons.design_services_outlined,
                  'AI Model Preferences',
                  'GPT-4o, DALL-E 3',
                  () => _snack(context, 'AI model preferences'),
                ),
                const _Divider(),
                _SectionHeader('Preferences'),
                _SwitchTile(
                  Icons.play_circle_outline,
                  'Autoplay videos',
                  _autoplay ?? data.autoplay,
                  (v) {
                    setState(() => _autoplay = v);
                    _persist(autoplay: v);
                  },
                ),
                _SwitchTile(
                  Icons.network_cell_outlined,
                  'Use mobile data for downloads',
                  _useMobileData ?? data.useMobileData,
                  (v) {
                    setState(() => _useMobileData = v);
                    _persist(useMobileData: v);
                  },
                ),
                _SettingTile(
                  Icons.notifications_outlined,
                  'Notification Preferences',
                  'Push, email, and in-app',
                  () => _snack(context, 'Notification preferences'),
                ),
                _SettingTile(
                  Icons.storage_outlined,
                  'Storage Management',
                  'Cache: 245 MB used',
                  () => _snack(context, 'Storage management'),
                ),
                const _Divider(),
                _SectionHeader('Appearance'),
                _SettingTile(
                  Icons.brightness_6_outlined,
                  'Theme',
                  data.theme.isEmpty ? 'Dark' : data.theme,
                  () => _snack(context, 'Theme settings'),
                ),
                _SettingTile(
                  Icons.language_outlined,
                  'Language',
                  data.language.isEmpty ? 'English' : data.language,
                  () => _snack(context, 'Language settings'),
                ),
                const _Divider(),
                _SectionHeader('Privacy & Security'),
                _SettingTile(
                  Icons.lock_outlined,
                  'Change Password',
                  null,
                  () => _snack(context, 'Change password'),
                ),
                _SettingTile(
                  Icons.fingerprint_outlined,
                  'Biometric Auth',
                  'Enabled',
                  () => _snack(context, 'Biometric auth settings'),
                ),
                _SettingTile(
                  Icons.privacy_tip_outlined,
                  'Privacy Policy',
                  null,
                  () => _snack(context, 'Privacy Policy'),
                ),
                _SettingTile(
                  Icons.gavel_outlined,
                  'Terms of Service',
                  null,
                  () => _snack(context, 'Terms of Service'),
                ),
                const _Divider(),
                _SectionHeader('About'),
                _SettingTile(
                  Icons.info_outlined,
                  'App Version',
                  '1.0.0 (build 1)',
                  () {},
                ),
                _SettingTile(
                  Icons.code_outlined,
                  'Licenses',
                  'Open source notices',
                  () => showLicensePage(context: context),
                ),
                if (_saving)
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: VrTheme.purple,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          backgroundColor: VrTheme.surfaceDark,
                          title: const Text(
                            'Delete Account',
                            style: TextStyle(color: Colors.white),
                          ),
                          content: const Text(
                            'This action cannot be undone. All your data will be permanently removed.',
                            style: TextStyle(color: Colors.white70),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(ctx).pop(),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(ctx).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Account deletion requested'),
                                  ),
                                );
                              },
                              child: const Text(
                                'Delete',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(color: Colors.red.withAlpha(80)),
                        color: Colors.red.withAlpha(15),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete_forever_outlined,
                              color: Colors.red.withAlpha(200),
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Delete Account',
                              style: TextStyle(
                                color: Colors.red.withAlpha(200),
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => Center(child: platformLoader(size: 28)),
        error: (error, _) => Center(
          child: Text(
            'Error: $error',
            style: const TextStyle(color: Colors.white38),
          ),
        ),
      ),
    );
  }
}

void _snack(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
  );
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 6),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: VrTheme.purple.withAlpha(180),
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: VrTheme.letterSpacingLabel,
        ),
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  const _SettingTile(this.icon, this.title, this.subtitle, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 4),
          child: Row(
            children: [
              Icon(icon, color: Colors.white.withAlpha(150), size: 22),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: VrTheme.bodyMedium(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle!,
                        style: VrTheme.caption(
                          color: Colors.white.withAlpha(80),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.white.withAlpha(80),
                size: 20,
              ),
            ],
          ),
        ),
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
        child: Row(
          children: [
            Icon(icon, color: Colors.white.withAlpha(150), size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: VrTheme.bodyMedium(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                ),
              ),
            ),
            Switch(
              value: value,
              onChanged: onChanged,
              activeThumbColor: VrTheme.purple,
              activeTrackColor: VrTheme.purple.withAlpha(80),
            ),
          ],
        ),
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
      child: Divider(color: VrTheme.cardBorder.withAlpha(40), height: 1),
    );
  }
}
