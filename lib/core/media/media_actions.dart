import 'package:gal/gal.dart';
import 'package:share_plus/share_plus.dart';

/// Save-to-gallery + share per docs/MOBILE_APP_GUIDE.md §8.
///
/// Every finished video/image gets a Save action — the main reason a creator
/// installs the app.
abstract final class MediaActions {
  /// Saves a local file to the gallery. Returns an error message on failure,
  /// or null on success.
  static Future<String?> saveToGallery(String filePath) async {
    try {
      await Gal.putImage(filePath);
      return null;
    } on GalException catch (e) {
      return switch (e.type) {
        GalExceptionType.accessDenied => 'Photo library access denied',
        GalExceptionType.notEnoughSpace => 'Not enough storage space',
        GalExceptionType.notSupportedFormat => 'Unsupported file format',
        GalExceptionType.unexpected => 'Could not save to gallery',
      };
    } catch (_) {
      return 'Could not save to gallery';
    }
  }

  /// Shares a public URL via the system share sheet.
  static Future<void> shareUrl(String url, {String? title}) async {
    await SharePlus.instance.share(ShareParams(text: url, subject: title));
  }

  /// Shares a local file via the system share sheet.
  static Future<void> shareFile(String filePath, {String? text}) async {
    await SharePlus.instance.share(
      ShareParams(files: [XFile(filePath)], text: text),
    );
  }
}
