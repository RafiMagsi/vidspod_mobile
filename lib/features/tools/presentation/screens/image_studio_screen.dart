import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vidspod_mobile/core/theme/vr_theme.dart';
import 'package:vidspod_mobile/core/utils/platform_utils.dart';
import 'package:vidspod_mobile/features/billing/credit_gate.dart';
import 'package:vidspod_mobile/features/tools/tools_providers.dart';

/// Image Generator per docs/MOBILE_APP_GUIDE.md §5.4.
///
/// Modes are **Reference Edit** (`image_to_image`) and **Improve** (`improve`).
/// Cost = `cost_per_image × variation_count`; ≤10 MB source image.
class ImageStudioScreen extends ConsumerStatefulWidget {
  const ImageStudioScreen({super.key});

  @override
  ConsumerState<ImageStudioScreen> createState() => _ImageStudioScreenState();
}

class _ImageStudioScreenState extends ConsumerState<ImageStudioScreen> {
  static const _sizes = ['1024x1024', '1024x1536', '1536x1024'];

  final _picker = ImagePicker();
  File? _sourceImage;
  String _mode = 'image_to_image'; // Reference Edit
  String _size = '1024x1024';
  int _variations = 1;
  final _promptController = TextEditingController();
  bool _generating = false;
  List<String>? _results;

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  bool get _isImprove => _mode == 'improve';

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => _sourceImage = File(picked.path));
    }
  }

  Future<void> _generate() async {
    // Client validation (§5.4): source image required; prompt required unless
    // improve; ≤10 MB.
    if (_sourceImage == null) {
      _snack('Add a reference photo first');
      return;
    }
    if (!_isImprove && _promptController.text.trim().isEmpty) {
      _snack('Add a prompt for Reference Edit');
      return;
    }
    if (_sourceImage!.lengthSync() > 10 * 1024 * 1024) {
      _snack('Image must be under 10 MB');
      return;
    }

    setState(() {
      _generating = true;
      _results = null;
    });

    try {
      final repository = ref.read(imageGeneratorRepositoryProvider);
      final formData = _buildFormData();
      await repository.generate(mode: _mode, formData: formData);
      // Placeholder result until the backend returns real URLs (§5.4 🔴).
      setState(() => _results = ['Image generated — $_size']);
    } catch (e) {
      if (!mounted) return;
      if (!CreditGate.onApiError(context, e)) {
        _snack('Generation failed: $e');
      }
    } finally {
      if (mounted) setState(() => _generating = false);
    }
  }

  FormData _buildFormData() {
    return FormData.fromMap({
      'mode': _mode,
      if (!_isImprove) 'prompt': _promptController.text.trim(),
      'size': _size,
      'variation_count': _variations,
      if (_sourceImage != null)
        'source_image': MultipartFile.fromFileSync(
          _sourceImage!.path,
          filename: _sourceImage!.path.split('/').last,
        ),
    });
  }

  void _snack(String message) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VrTheme.black,
      appBar: AppBar(
        backgroundColor: VrTheme.black,
        title: Text('Image Generator', style: VrTheme.headingLarge()),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _photoSlot(),
            const SizedBox(height: 20),
            Text('Mode', style: VrTheme.headingMedium()),
            const SizedBox(height: 10),
            Row(
              children: [
                _modeChip(
                  'image_to_image',
                  'Reference Edit',
                  Icons.edit_outlined,
                ),
                const SizedBox(width: 10),
                _modeChip('improve', 'Improve', Icons.auto_fix_high),
              ],
            ),
            const SizedBox(height: 20),
            Text('Size', style: VrTheme.headingMedium()),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              children: [for (final size in _sizes) _sizeChip(size)],
            ),
            const SizedBox(height: 20),
            Text('Variations', style: VrTheme.headingMedium()),
            const SizedBox(height: 10),
            Row(
              children: [
                for (var n = 1; n <= 4; n++)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text('$n'),
                      selected: _variations == n,
                      onSelected: (_) => setState(() => _variations = n),
                      selectedColor: VrTheme.purple,
                      labelStyle: TextStyle(
                        color: _variations == n ? Colors.white : Colors.white70,
                      ),
                      backgroundColor: VrTheme.darkSurface,
                      side: BorderSide.none,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _promptController,
              enabled: !_isImprove,
              style: const TextStyle(color: Colors.white),
              maxLines: 4,
              decoration: InputDecoration(
                hintText: _isImprove
                    ? 'Improve will enhance automatically (no prompt)'
                    : 'Describe the edit you want…',
                hintStyle: TextStyle(color: Colors.white.withAlpha(80)),
                filled: true,
                fillColor: VrTheme.darkSurface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(VrTheme.radiusLg),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_generating)
              Center(child: platformLoader(size: 28))
            else
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: VrTheme.purple,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: _generate,
                  icon: const Icon(Icons.auto_awesome),
                  label: const Text('Generate'),
                ),
              ),
            if (_results != null) ...[
              const SizedBox(height: 24),
              Text('Results', style: VrTheme.headingMedium()),
              const SizedBox(height: 12),
              _resultsCarousel(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _photoSlot() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 220,
        width: double.infinity,
        decoration: BoxDecoration(
          color: VrTheme.darkSurface,
          borderRadius: BorderRadius.circular(VrTheme.radiusLg),
          border: Border.all(color: VrTheme.cardBorder.withAlpha(60)),
        ),
        clipBehavior: Clip.antiAlias,
        child: _sourceImage != null
            ? Stack(
                fit: StackFit.expand,
                children: [
                  Image.file(_sourceImage!, fit: BoxFit.cover),
                  Positioned(
                    right: 8,
                    bottom: 8,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.black.withAlpha(150),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.edit_outlined,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add_photo_alternate_outlined,
                    size: 40,
                    color: Colors.white.withAlpha(70),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Add a reference photo',
                    style: VrTheme.bodyMedium(
                      color: Colors.white.withAlpha(90),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Camera or gallery · ≤10 MB',
                    style: VrTheme.caption(color: Colors.white.withAlpha(60)),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _modeChip(String value, String label, IconData icon) {
    final selected = _mode == value;
    return GestureDetector(
      onTap: () => setState(() => _mode = value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? VrTheme.purple.withAlpha(30) : VrTheme.darkSurface,
          borderRadius: BorderRadius.circular(VrTheme.radiusLg),
          border: Border.all(
            color: selected
                ? VrTheme.purple.withAlpha(90)
                : VrTheme.cardBorder.withAlpha(60),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: selected ? VrTheme.purple : Colors.white.withAlpha(80),
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: selected ? VrTheme.purple : Colors.white.withAlpha(90),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sizeChip(String size) {
    final selected = _size == size;
    return GestureDetector(
      onTap: () => setState(() => _size = size),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? VrTheme.blue.withAlpha(30) : VrTheme.darkSurface,
          borderRadius: BorderRadius.circular(VrTheme.radiusFull),
          border: Border.all(
            color: selected
                ? VrTheme.blue.withAlpha(90)
                : VrTheme.cardBorder.withAlpha(60),
          ),
        ),
        child: Text(
          size,
          style: TextStyle(
            color: selected ? VrTheme.blue : Colors.white.withAlpha(90),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _resultsCarousel() {
    return SizedBox(
      height: 260,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _results!.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (_, i) => Container(
          width: 200,
          decoration: BoxDecoration(
            color: VrTheme.mediumSurface,
            borderRadius: BorderRadius.circular(VrTheme.radiusLg),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.image_outlined, size: 40, color: Colors.white60),
              const SizedBox(height: 8),
              Text(
                _results![i],
                style: VrTheme.caption(color: Colors.white.withAlpha(90)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
