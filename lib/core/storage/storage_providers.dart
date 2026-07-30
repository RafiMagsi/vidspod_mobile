import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vidspod_mobile/core/storage/secure_storage_repository.dart';

final secureStorageRepositoryProvider = Provider<SecureStorageRepository>((
  ref,
) {
  return SecureStorageRepository();
});
