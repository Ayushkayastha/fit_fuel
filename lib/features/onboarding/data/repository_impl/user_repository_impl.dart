import 'package:hive/hive.dart';
import '../../domain/entity/user_entity.dart';
import '../../domain/repository/user_repository.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final Box<UserModel> userBox;

  UserRepositoryImpl(this.userBox);

  @override
  Future<void> saveUser(UserEntity user) async {
    final model = UserModel(
      name: user.name,
      age: user.age,
      gender: user.gender,
      height: user.height,
      weight: user.weight,
    );
    await userBox.put('user', model);
  }

  @override
  UserEntity? getUser() {
    final model = userBox.get('user');
    if (model == null) return null;
    return UserEntity(
      name: model.name,
      age: model.age,
      gender: model.gender,
      height: model.height,
      weight: model.weight,
    );
  }
}
