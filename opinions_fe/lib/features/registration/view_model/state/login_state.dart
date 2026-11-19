import 'package:opinions/features/registration/enums/login_status_enums.dart';
import 'package:opinions/features/registration/enums/user_creation_enums.dart';

class LoginState {
  const LoginState({
    required this.username,
    required this.password,
    required this.loginState,
    required this.signUpState
  });

  final String username;
  final String password;
  final LoginStatusEnums loginState;
  final UserCreationEnums signUpState;


  LoginState copyWith({
    String? username,
    String? password,
    LoginStatusEnums? loginState,
    UserCreationEnums? signUpState
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      loginState: loginState ?? this.loginState,
      signUpState: signUpState ?? this.signUpState
    );
  }
}
