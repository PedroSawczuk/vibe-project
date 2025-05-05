import 'package:vibe_project/services/auth/authServices.dart';

class EditProfileController {
  final AuthServices _authServices = AuthServices();

  Future<String> fetchUsername() async {
    return await _authServices.getUsername() ?? "Sem username";
  }

  Future<void> updateUsername(String username) async {
    await _authServices.updateUsername(username);
  }
}
