import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';
import 'package:nutriai/core/theme/app_colors.dart';
import 'package:nutriai/core/theme/app_text_styles.dart';
import 'package:nutriai/core/widgets/glass_container.dart';
import 'package:nutriai/features/auth/domain/auth_service.dart';
import 'package:nutriai/l10n/app_localizations.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final authService = ref.read(authServiceProvider);
      await authService.signIn(_emailController.text, _passwordController.text);
      
      if (mounted) {
        // Navigation is handled by GoRouter auth guard
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topLeft,
            radius: 1.5,
            colors: [
              Color(0xFF1A2C42),
              AppColors.deepOcean,
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo/Title
                    Text(
                      l10n.appTitle,
                      style: AppTextStyles.h1.copyWith(
                        fontSize: 48,
                        foreground: Paint()
                          ..shader = const LinearGradient(
                            colors: [AppColors.neonMint, AppColors.electricBlue],
                          ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                      ),
                    ),
                    const Gap(8),
                    Text(
                      l10n.loginTagline,
                      style: AppTextStyles.caption.copyWith(fontSize: 14),
                    ),
                    const Gap(48),

                    // Email field
                    GlassContainer(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: AppTextStyles.body1,
                        decoration: InputDecoration(
                          hintText: l10n.loginEmailPlaceholder,
                          hintStyle: AppTextStyles.caption,
                          border: InputBorder.none,
                          prefixIcon: const Icon(Icons.email_outlined, color: AppColors.neonMint),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return l10n.loginEmailRequired;
                          }
                          if (!value.contains('@')) {
                            return l10n.loginEmailInvalid;
                          }
                          return null;
                        },
                      ),
                    ),
                    const Gap(16),

                    // Password field
                    GlassContainer(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        style: AppTextStyles.body1,
                        decoration: InputDecoration(
                          hintText: l10n.loginPasswordPlaceholder,
                          hintStyle: AppTextStyles.caption,
                          border: InputBorder.none,
                          prefixIcon: const Icon(Icons.lock_outline, color: AppColors.neonMint),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                              color: AppColors.textSecondary,
                            ),
                            onPressed: () {
                              setState(() => _obscurePassword = !_obscurePassword);
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return l10n.loginPasswordRequired;
                          }
                          if (value.length < 6) {
                            return l10n.loginPasswordLengthError;
                          }
                          return null;
                        },
                      ),
                    ),
                    const Gap(24),

                    // Login button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleLogin,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.neonMint,
                          foregroundColor: AppColors.deepOcean,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 8,
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(color: AppColors.deepOcean)
                            : Text(
                                l10n.loginButton,
                                style: AppTextStyles.h2.copyWith(
                                  color: AppColors.deepOcean,
                                  fontSize: 18,
                                ),
                              ),
                      ),
                    ),
                    const Gap(16),

                    // Sign up link
                    TextButton(
                      onPressed: () {
                        context.go('/signup');
                      },
                      child: Text(
                        l10n.loginSignupLink,
                        style: AppTextStyles.body1.copyWith(
                          color: AppColors.neonMint,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
