// lib/shared/providers/auth_info_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/storage/secure_storage_service.dart';

// Provider for the service instance
final secureStorageServiceProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageService();
});

// FutureProvider for token
final authTokenProvider = FutureProvider<String?>((ref) async {
  final storage = ref.watch(secureStorageServiceProvider);
  return await storage.getAuthToken();
});

// FutureProvider for userId
final userIdProvider = FutureProvider<String?>((ref) async {
  final storage = ref.watch(secureStorageServiceProvider);
  return await storage.getUserId();
});
