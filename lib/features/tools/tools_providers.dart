import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/app/config.dart';
import 'package:vidspod_mobile/core/api/api_providers.dart';
import 'package:vidspod_mobile/features/tools/data/image_generator_repository.dart';
import 'package:vidspod_mobile/features/tools/data/script_writer_repository.dart';
import 'package:vidspod_mobile/features/tools/data/voice_studio_repository.dart';
import 'package:vidspod_mobile/features/tools/data/youtube_download_repository.dart';
import 'package:vidspod_mobile/features/tools/domain/voice.dart';

final imageGeneratorRepositoryProvider = Provider<ImageGeneratorRepository>((
  ref,
) {
  final apiClient = ref.watch(apiClientProvider);
  return ImageGeneratorRepository(apiClient);
});

final youtubeDownloadRepositoryProvider = Provider<YouTubeDownloadRepository>((
  ref,
) {
  final apiClient = ref.watch(apiClientProvider);
  return YouTubeDownloadRepository(apiClient);
});

final scriptWriterRepositoryProvider = Provider<ScriptWriterRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return ScriptWriterRepository(apiClient);
});

final voiceStudioRepositoryProvider = Provider<VoiceStudioRepository>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return VoiceStudioRepository(apiClient);
});

/// TTS catalog (§5.8, `GET /voices` ✅). Preview keeps the app usable offline.
final voicesProvider = FutureProvider<List<Voice>>((ref) async {
  if (Config.previewMode) {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return PreviewVoices.catalog;
  }
  final repository = ref.watch(voiceStudioRepositoryProvider);
  return repository.getVoices();
});

/// Fallback catalog so preview mode matches the shipped UI.
abstract final class PreviewVoices {
  static final List<Voice> catalog = [
    const Voice(
      id: 'daniel',
      name: 'Daniel',
      provider: 'elevenlabs',
      style: 'Professional',
      language: 'English',
      accent: 'American',
      gender: 'male',
      description: 'Deep authoritative male voice',
      bestFor: 'narration, podcasts',
    ),
    const Voice(
      id: 'emma',
      name: 'Emma',
      provider: 'elevenlabs',
      style: 'Warm & Friendly',
      language: 'English',
      accent: 'British',
      gender: 'female',
      description: 'Soft approachable female voice',
      bestFor: 'storytelling, tutorials',
    ),
    const Voice(
      id: 'liam',
      name: 'Liam',
      provider: 'openai',
      style: 'Narrative',
      language: 'English',
      accent: 'American',
      gender: 'male',
      description: 'Cinematic storytelling voice',
      bestFor: 'documentaries, ads',
    ),
    const Voice(
      id: 'sophia',
      name: 'Sophia',
      provider: 'azure',
      style: 'Energetic',
      language: 'English',
      accent: 'American',
      gender: 'female',
      description: 'Upbeat high-energy presenter',
      bestFor: 'commercials, promos',
    ),
    const Voice(
      id: 'oliver',
      name: 'Oliver',
      provider: 'elevenlabs',
      style: 'Calm & Soothing',
      language: 'English',
      accent: 'British',
      gender: 'male',
      description: 'Gentle relaxing meditation voice',
      bestFor: 'meditation, ASMR',
    ),
    const Voice(
      id: 'aria',
      name: 'Aria',
      provider: 'elevenlabs',
      style: 'Character',
      language: 'English',
      accent: 'American',
      gender: 'female',
      description: 'Fun cartoon-style voice acting',
      bestFor: 'animation, gaming',
    ),
  ];
}
