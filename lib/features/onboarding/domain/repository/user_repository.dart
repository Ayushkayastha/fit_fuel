import '../entity/user_entity.dart';

abstract class UserRepository {
  Future<void> saveUser(UserEntity user);
  UserEntity? getUser();
}
