import '../../data/models/login_request_model.dart';
import '../../data/models/login_response_model.dart';
import '../repository/auth_repository.dart';

class LoginUserUseCase {
  final AuthRepository repository;

  LoginUserUseCase(this.repository);

  Future<LoginResponseModel> call(LoginRequestModel request) {
    return repository.loginUser(request);
  }
}
