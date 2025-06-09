import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../data/models/user_model.dart';
import '../../data/repository_impl/user_repository_impl.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/repository/user_repository.dart';

final userBoxProvider = Provider<Box<UserModel>>((ref) {
  throw UnimplementedError(); // override in main.dart
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  final box = ref.watch(userBoxProvider);
  return UserRepositoryImpl(box);
});

final saveUserProvider = Provider<Future<void> Function(UserEntity)>((ref) {
  final repo = ref.watch(userRepositoryProvider);
  return (user) => repo.saveUser(user);
});

final userProvider = Provider<UserEntity?>((ref) {
  final repo = ref.watch(userRepositoryProvider);
  return repo.getUser();
});
