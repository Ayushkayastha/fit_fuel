import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../../domain/repository/auth_repository.dart';
import '../models/register_request_model.dart';
import '../models/register_response_model.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final Dio _dio = DioClient.client;

  @override
  Future<RegisterResponseModel> registerUser(RegisterRequestModel request) async {
    try {
      final response = await _dio.post('auth/register', data: request.toJson());
      return RegisterResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception("Registration failed: $e");
    }
  }

  @override
  Future<LoginResponseModel> loginUser(LoginRequestModel request) async {
    try {
      final response = await _dio.post('auth/login', data: request.toJson());
      return LoginResponseModel.fromJson(response.data);
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }
}
