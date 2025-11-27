import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nutriai/core/constants/avatar_constants.dart';
import 'package:nutriai/core/theme/app_colors.dart';
import 'package:nutriai/core/theme/app_text_styles.dart';
import 'package:nutriai/core/widgets/glass_container.dart';
import 'package:nutriai/l10n/app_localizations.dart';

class ProfilePhotoSelectorWidget extends StatefulWidget {
  final Function(Map<String, dynamic>) onConfirmed;
  final bool isMale;
  final Future<List<String>> Function()? onLoadHistory;
  final Future<void> Function(String avatarUrl)? onSaveToHistory;

  const ProfilePhotoSelectorWidget({
    super.key,
    required this.onConfirmed,
    required this.isMale,
    this.onLoadHistory,
    this.onSaveToHistory,
  });

  @override
  State<ProfilePhotoSelectorWidget> createState() =>
      _ProfilePhotoSelectorWidgetState();
}

class _ProfilePhotoSelectorWidgetState
    extends State<ProfilePhotoSelectorWidget> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String? _selectedAvatarId;
  String? _selectedAvatarUrl;
  XFile? _selectedPhoto;
  String? _photoPreviewUrl;
  bool _isLoading = false;

  // Estados para avatares dinâmicos e histórico
  List<Map<String, String>> _currentAvatars = [];
  List<String> _avatarHistory = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadInitialAvatars();
    _loadAvatarHistory();
  }

  void _loadInitialAvatars() {
    _currentAvatars = AvatarConstants.generateRandomAvatars();
  }

  Future<void> _loadAvatarHistory() async {
    if (widget.onLoadHistory != null) {
      final history = await widget.onLoadHistory!();
      if (mounted) {
        setState(() => _avatarHistory = history);
      }
    }
  }

  void _reloadAvatars() {
    setState(() {
      _currentAvatars = AvatarConstants.generateRandomAvatars();
    });
  }

  void _selectAvatarFromHistory(String url) {
    // Extrair seed da URL para criar um ID
    final seed = url.split('seed=').last;
    setState(() {
      _selectedAvatarId = 'history_$seed';
      _selectedAvatarUrl = url;
      _selectedPhoto = null;
      _photoPreviewUrl = null;
    });
  }

  void _showHistoryDialog(AppLocalizations l10n) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.glassDark,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          l10n.recentAvatars,
          style: AppTextStyles.h2.copyWith(color: Colors.white),
        ),
        content: SizedBox(
          width: 280,
          height: 200,
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: _avatarHistory.length,
            itemBuilder: (context, index) {
              final url = _avatarHistory[index];
              final isSelected = _selectedAvatarUrl == url;
              return GestureDetector(
                onTap: () {
                  _selectAvatarFromHistory(url);
                  Navigator.pop(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? AppColors.neonMint : AppColors.glassLight,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: ClipOval(
                    child: SvgPicture.network(
                      url,
                      fit: BoxFit.cover,
                      placeholderBuilder: (context) => const Center(
                        child: SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: AppColors.neonMint,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              l10n.closeButton,
              style: const TextStyle(color: AppColors.electricBlue),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    setState(() => _isLoading = true);

    try {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedPhoto = image;
          _photoPreviewUrl = image.path;
          _selectedAvatarId = null;
          _selectedAvatarUrl = null;
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _selectAvatar(String id, String url) {
    setState(() {
      _selectedAvatarId = id;
      _selectedAvatarUrl = url;
      _selectedPhoto = null;
      _photoPreviewUrl = null;
    });
  }

  void _confirm() {
    if (_selectedAvatarId != null) {
      // Salvar no histórico antes de confirmar
      if (_selectedAvatarUrl != null && widget.onSaveToHistory != null) {
        widget.onSaveToHistory!(_selectedAvatarUrl!);
      }

      widget.onConfirmed({
        'type': 'avatar',
        'avatarId': _selectedAvatarId,
        'avatarUrl': _selectedAvatarUrl,
      });
    } else if (_selectedPhoto != null) {
      widget.onConfirmed({
        'type': 'photo',
        'photoPath': _selectedPhoto!.path,
      });
    }
  }

  bool get _hasSelection =>
      _selectedAvatarId != null || _selectedPhoto != null;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              l10n.profilePhotoTitle,
              style: AppTextStyles.h2.copyWith(fontSize: 18),
            ),
            const Gap(12),

            // Preview circle - clicável para mostrar histórico
            Center(
              child: GestureDetector(
                onTap: _avatarHistory.isNotEmpty ? () => _showHistoryDialog(l10n) : null,
                child: Stack(
                  children: [
                    Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.glassMedium,
                        border: Border.all(
                          color: _hasSelection
                              ? AppColors.neonMint
                              : AppColors.glassLight,
                          width: 2,
                        ),
                        boxShadow: _hasSelection
                            ? [
                                BoxShadow(
                                  color: AppColors.neonMint.withOpacity(0.3),
                                  blurRadius: 12,
                                ),
                              ]
                            : null,
                      ),
                      child: ClipOval(
                        child: _buildPreview(),
                      ),
                    ),
                    // Indicador de histórico
                    if (_avatarHistory.isNotEmpty)
                      Positioned(
                        bottom: 4,
                        right: 4,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColors.electricBlue,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.darkBg, width: 2),
                          ),
                          child: const Icon(Icons.history, size: 16, color: Colors.white),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const Gap(16),

            // Tab bar
            Container(
              decoration: BoxDecoration(
                color: AppColors.glassDark,
                borderRadius: BorderRadius.circular(12),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: AppColors.neonMint.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.neonMint),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                labelColor: AppColors.neonMint,
                unselectedLabelColor: AppColors.textSecondary,
                labelStyle: AppTextStyles.button.copyWith(fontSize: 14),
                tabs: [
                  Tab(text: l10n.profilePhotoRealTab),
                  Tab(text: l10n.profilePhotoAvatarTab),
                ],
              ),
            ),
            const Gap(12),

            // Tab content
            SizedBox(
              height: 280,
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Real photo tab
                  _buildPhotoTab(l10n),
                  // Avatar tab with reload button
                  _buildAvatarTab(l10n),
                ],
              ),
            ),
            const Gap(16),

            // Confirm button
            ElevatedButton(
              onPressed: _hasSelection ? _confirm : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.neonMint,
                disabledBackgroundColor: AppColors.glassMedium,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                l10n.confirmButton,
                style: AppTextStyles.button.copyWith(
                  color: _hasSelection
                      ? AppColors.darkBg
                      : AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPreview() {
    if (_isLoading) {
      return const Center(
        child: SizedBox(
          width: 32,
          height: 32,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.neonMint,
          ),
        ),
      );
    }

    if (_selectedAvatarUrl != null) {
      return SvgPicture.network(
        _selectedAvatarUrl!,
        fit: BoxFit.cover,
        placeholderBuilder: (context) => const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.neonMint,
          ),
        ),
      );
    }

    if (_photoPreviewUrl != null) {
      if (kIsWeb) {
        return Image.network(
          _photoPreviewUrl!,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _buildPlaceholder(),
        );
      } else {
        return Image.file(
          File(_photoPreviewUrl!),
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _buildPlaceholder(),
        );
      }
    }

    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return const Center(
      child: Icon(
        Icons.person,
        size: 80,
        color: AppColors.textSecondary,
      ),
    );
  }

  Widget _buildPhotoTab(AppLocalizations l10n) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildPhotoOption(
              icon: Icons.camera_alt,
              label: l10n.profilePhotoCamera,
              onTap: () => _pickImage(ImageSource.camera),
            ),
            _buildPhotoOption(
              icon: Icons.photo_library,
              label: l10n.profilePhotoGallery,
              onTap: () => _pickImage(ImageSource.gallery),
            ),
          ],
        ),
        const Gap(16),
        Text(
          l10n.profilePhotoHint,
          style: AppTextStyles.caption.copyWith(
            color: AppColors.textSecondary,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPhotoOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        backgroundColor: AppColors.glassDark,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.electricBlue.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: AppColors.electricBlue,
                size: 32,
              ),
            ),
            const Gap(8),
            Text(
              label,
              style: AppTextStyles.caption.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarTab(AppLocalizations l10n) {
    return Column(
      children: [
        // Botão de reload
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: _reloadAvatars,
                icon: const Icon(Icons.refresh, size: 18),
                label: Text(l10n.reloadAvatars),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.electricBlue,
                ),
              ),
            ],
          ),
        ),
        // Grid de avatares
        Expanded(
          child: _buildAvatarGrid(_currentAvatars),
        ),
      ],
    );
  }

  Widget _buildAvatarGrid(List<Map<String, String>> avatars) {
    return GridView.builder(
      padding: const EdgeInsets.all(4),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: avatars.length,
      itemBuilder: (context, index) {
        final avatar = avatars[index];
        final isSelected = _selectedAvatarId == avatar['id'];

        return GestureDetector(
          onTap: () => _selectAvatar(avatar['id']!, avatar['url']!),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected
                  ? AppColors.neonMint.withOpacity(0.2)
                  : AppColors.glassDark,
              border: Border.all(
                color: isSelected ? AppColors.neonMint : AppColors.glassLight,
                width: isSelected ? 2 : 1,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppColors.neonMint.withOpacity(0.3),
                        blurRadius: 8,
                      ),
                    ]
                  : null,
            ),
            child: ClipOval(
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: SvgPicture.network(
                  avatar['url']!,
                  fit: BoxFit.cover,
                  placeholderBuilder: (context) => const Center(
                    child: SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: AppColors.neonMint,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
