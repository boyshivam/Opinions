import "dart:convert";

import "package:http/http.dart" as http;
import "package:opinions/features/registration/enums/user_creation_enums.dart";

class UserRegistrationRepository {
  const UserRegistrationRepository({required this.client});

  final http.Client client;

  // submit user details
  Future<UserCreationEnums> submitUserData(
    String username,
    String password,
  ) async {
    final url = Uri.parse("http://10.0.2.2:8000/user/");

    final http.Response response = await http.post(
      url,
      headers: {
        "Content-Type" : "application/json"
      },
      body: jsonEncode({"username": username, "password": password}),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return UserCreationEnums.success;
    }
    if (response.statusCode == 500) {
      return UserCreationEnums.serverError;
    }
    if (response.statusCode == 400 ||
        response.statusCode == 401 ||
        response.statusCode == 404) {
      return UserCreationEnums.failed;
    }
    return UserCreationEnums.loading;
  }
}
