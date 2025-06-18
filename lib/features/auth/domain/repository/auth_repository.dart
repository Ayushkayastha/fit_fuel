import '../../data/models/login_request_model.dart';
import '../../data/models/login_response_model.dart';
import '../../data/models/register_request_model.dart';
import '../../data/models/register_response_model.dart';

abstract class AuthRepository {
  Future<RegisterResponseModel> registerUser(RegisterRequestModel request);
  Future<LoginResponseModel> loginUser(LoginRequestModel request);
}
