import "package:http/http.dart" as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:opinions/features/registration/repository/user_registration_repository.dart';

final signUpProvider = Provider<UserRegistrationRepository>((ref) {
  return UserRegistrationRepository(client: http.Client());
});
