import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gap/gap.dart';
import 'package:nutriai/core/theme/app_colors.dart';
import 'package:nutriai/core/theme/app_text_styles.dart';
import 'package:nutriai/core/widgets/glass_container.dart';
import 'package:nutriai/features/auth/domain/auth_service.dart';
import 'package:nutriai/core/services/firestore_user_service.dart';
import 'package:nutriai/l10n/app_localizations.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptedTerms = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    final l10n = AppLocalizations.of(context)!;

    if (!_formKey.currentState!.validate()) return;

    if (!_acceptedTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.signupTermsRequired)),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final authService = ref.read(authServiceProvider);
      final firestoreService = ref.read(firestoreUserServiceProvider);

      // Create Firebase Auth user
      final userCredential = await authService.signUp(_emailController.text, _passwordController.text);

      // Create Firestore user document
      await firestoreService.createUser(userCredential.user!.uid, _emailController.text);

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
                      l10n.signupTitle,
                      style: AppTextStyles.h1.copyWith(
                        fontSize: 40,
                        foreground: Paint()
                          ..shader = const LinearGradient(
                            colors: [AppColors.neonMint, AppColors.electricBlue],
                          ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                      ),
                    ),
                    const Gap(8),
                    Text(
                      l10n.signupSubtitle,
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
                    const Gap(16),

                    // Confirm Password field
                    GlassContainer(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: _obscureConfirmPassword,
                        style: AppTextStyles.body1,
                        decoration: InputDecoration(
                          hintText: l10n.signupConfirmPasswordPlaceholder,
                          hintStyle: AppTextStyles.caption,
                          border: InputBorder.none,
                          prefixIcon: const Icon(Icons.lock_outline, color: AppColors.neonMint),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                              color: AppColors.textSecondary,
                            ),
                            onPressed: () {
                              setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return l10n.signupConfirmPasswordRequired;
                          }
                          if (value != _passwordController.text) {
                            return l10n.signupPasswordsMismatch;
                          }
                          return null;
                        },
                      ),
                    ),
                    const Gap(24),

                    // Terms checkbox
                    GlassContainer(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Checkbox(
                            value: _acceptedTerms,
                            onChanged: (value) {
                              setState(() => _acceptedTerms = value ?? false);
                            },
                            fillColor: WidgetStateProperty.all(AppColors.neonMint),
                            checkColor: AppColors.deepOcean,
                          ),
                          Expanded(
                            child: Text(
                              l10n.signupTermsAcceptance,
                              style: AppTextStyles.caption.copyWith(fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(24),

                    // Signup button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleSignup,
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
                                l10n.signupButton,
                                style: AppTextStyles.h2.copyWith(
                                  color: AppColors.deepOcean,
                                  fontSize: 18,
                                ),
                              ),
                      ),
                    ),
                    const Gap(16),

                    // Login link
                    TextButton(
                      onPressed: () {
                        context.go('/login');
                      },
                      child: Text(
                        l10n.signupLoginLink,
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
