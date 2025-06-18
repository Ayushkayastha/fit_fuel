import '../../data/models/register_request_model.dart';
import '../../data/models/register_response_model.dart';
import '../repository/auth_repository.dart';

class RegisterUserUseCase {
  final AuthRepository repository;

  RegisterUserUseCase(this.repository);

  Future<RegisterResponseModel> call(RegisterRequestModel request) {
    return repository.registerUser(request);
  }
}
