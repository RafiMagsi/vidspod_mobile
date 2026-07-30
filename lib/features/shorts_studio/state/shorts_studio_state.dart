import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vidspod_mobile/app/config.dart';
import 'package:vidspod_mobile/core/media/media_providers.dart';
import 'package:vidspod_mobile/features/generations/generation_providers.dart';
import 'package:vidspod_mobile/core/media/media_repository.dart';
import 'package:vidspod_mobile/features/generations/data/generation_repository.dart';

enum UploadStatus { initial, picking, picked, uploading, uploaded, error }

class ShortsStudioState {
  final UploadStatus status;
  final File? image;
  final String? errorMessage;
  final bool isSelectingPhoto;

  ShortsStudioState({
    this.status = UploadStatus.initial,
    this.image,
    this.errorMessage,
    this.isSelectingPhoto = false,
  });

  ShortsStudioState copyWith({
    UploadStatus? status,
    File? image,
    String? errorMessage,
    bool? isSelectingPhoto,
  }) {
    return ShortsStudioState(
      status: status ?? this.status,
      image: image ?? this.image,
      errorMessage: errorMessage ?? this.errorMessage,
      isSelectingPhoto: isSelectingPhoto ?? this.isSelectingPhoto,
    );
  }
}

class ShortsStudioService extends StateNotifier<ShortsStudioState> {
  final MediaRepository _mediaRepository;
  final GenerationRepository _generationRepository;
  final _picker = ImagePicker();
  final _dio = Dio();

  ShortsStudioService(this._mediaRepository, this._generationRepository)
    : super(ShortsStudioState());

  Future<void> pickImage() async {
    state = state.copyWith(status: UploadStatus.picking);
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        state = state.copyWith(
          status: UploadStatus.picked,
          image: File(pickedFile.path),
        );
      } else {
        state = state.copyWith(status: UploadStatus.initial);
      }
    } catch (e) {
      state = state.copyWith(
        status: UploadStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> uploadImageAndCreateGeneration(String motionId) async {
    if (state.image == null) return;

    state = state.copyWith(status: UploadStatus.uploading);
    try {
      if (Config.previewMode) {
        await Future<void>.delayed(const Duration(milliseconds: 500));
        state = state.copyWith(status: UploadStatus.uploaded);
        return;
      }

      final fileName = state.image!.path.split('/').last;
      final presignedUrl = await _mediaRepository.getPresignedUrl(fileName);

      final file = state.image!;
      await _dio.put(
        presignedUrl,
        data: file.openRead(),
        options: Options(
          headers: {Headers.contentLengthHeader: await file.length()},
        ),
      );

      // This is a simplification. The backend should return an upload ID
      // that we can use to confirm the upload.
      final uploadId = fileName;
      await _mediaRepository.confirmUpload(uploadId);

      final generation = await _generationRepository.createGeneration(
        motionId: motionId,
        uploadId: uploadId,
      );

      state = state.copyWith(status: UploadStatus.uploaded);
    } catch (e) {
      state = state.copyWith(
        status: UploadStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  void toggleSelectPhoto() {
    state = state.copyWith(isSelectingPhoto: !state.isSelectingPhoto);
  }
}

final shortsStudioProvider =
    StateNotifierProvider<ShortsStudioService, ShortsStudioState>((ref) {
      final mediaRepository = ref.watch(mediaRepositoryProvider);
      final generationRepository = ref.watch(generationRepositoryProvider);
      return ShortsStudioService(mediaRepository, generationRepository);
    });
