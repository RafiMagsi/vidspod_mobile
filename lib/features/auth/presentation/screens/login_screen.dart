import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/app/creati_theme.dart';
import 'package:vidspod_mobile/core/utils/platform_utils.dart';
import 'package:vidspod_mobile/features/auth/application/auth_service.dart';

class LoginScreen extends ConsumerStatefulWidget {
  LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final authNotifier = ref.read(authStateProvider.notifier);

    return Scaffold(
      backgroundColor: CreatiTheme.black,
      body: GestureDetector(
        onTap: () => dismissKeyboard(context),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 48),
                Container(
                  width: 72,
                  height: 72,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: CreatiTheme.brandGradient,
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Welcome to VidsPod',
                  textAlign: TextAlign.center,
                  style: CreatiTheme.displayLarge(),
                ),
                const SizedBox(height: 6),
                Text(
                  'Sign in to continue creating',
                  textAlign: TextAlign.center,
                  style: CreatiTheme.bodyMedium(
                    color: Colors.white.withAlpha(120),
                  ),
                ),
                const SizedBox(height: 48),
                Container(
                  decoration: BoxDecoration(
                    color: CreatiTheme.surfaceDark,
                    borderRadius: BorderRadius.circular(CreatiTheme.radiusLg),
                    border: Border.all(
                      color: CreatiTheme.cardBorder.withAlpha(80),
                    ),
                  ),
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: CreatiTheme.bodyMedium(
                        color: Colors.white.withAlpha(60),
                      ),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.white.withAlpha(80),
                        size: 20,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    style: CreatiTheme.bodyMedium(),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                const SizedBox(height: 14),
                Container(
                  decoration: BoxDecoration(
                    color: CreatiTheme.surfaceDark,
                    borderRadius: BorderRadius.circular(CreatiTheme.radiusLg),
                    border: Border.all(
                      color: CreatiTheme.cardBorder.withAlpha(80),
                    ),
                  ),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: CreatiTheme.bodyMedium(
                        color: Colors.white.withAlpha(60),
                      ),
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: Colors.white.withAlpha(80),
                        size: 20,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.white.withAlpha(80),
                          size: 20,
                        ),
                        onPressed: () => setState(
                          () => _obscurePassword = !_obscurePassword,
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    style: CreatiTheme.bodyMedium(),
                  ),
                ),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: authState == AuthStatus.loading
                      ? null
                      : () => authNotifier.login(
                          _emailController.text,
                          _passwordController.text,
                        ),
                  child: Container(
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(27),
                      gradient: CreatiTheme.brandGradient,
                      boxShadow: CreatiTheme.buttonShadow(CreatiTheme.purple),
                    ),
                    child: Center(
                      child: authState == AuthStatus.loading
                          ? SizedBox(
                              width: 22,
                              height: 22,
                              child: platformLoader(size: 22),
                            )
                          : Text(
                              'Sign In',
                              style: CreatiTheme.bodyMedium(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: CreatiTheme.bodySmall(
                        color: Colors.white.withAlpha(100),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: CreatiTheme.bodySmall(
                        color: Colors.white.withAlpha(100),
                      ),
                    ),
                    const SizedBox(width: 4),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Sign Up',
                        style: CreatiTheme.bodySmall(
                          fontWeight: FontWeight.w600,
                          color: CreatiTheme.purple,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
