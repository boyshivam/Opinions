import "package:flutter_secure_storage/flutter_secure_storage.dart";
import "package:opinions/features/registration/enums/login_status_enums.dart";
import "package:opinions/features/registration/enums/user_creation_enums.dart";
import "package:opinions/features/registration/repository/services/token_storge_service.dart";
import "package:opinions/features/registration/view_model/provider/auth_provider.dart";
import "package:opinions/features/registration/view_model/provider/sign_up_provider.dart";
import "package:opinions/features/registration/view_model/state/login_state.dart";
import "package:riverpod/riverpod.dart";

class LoginNotifier extends Notifier<LoginState> {
  @override
  LoginState build() {
    return LoginState(
      username: "",
      password: "",
      loginState: LoginStatusEnums.initial,
      signUpState: UserCreationEnums.initial
    );
  }

  Future<void> userLogin(String username, String password) async {
    state = state.copyWith(loginState: LoginStatusEnums.loading);

    try {
      final repository = ref.read(authProvider);

      final token = await repository.login(username, password);

      // safe token storage

      final tokenStorage = TokenStorgeService();

      // save token
      await tokenStorage.saveToken(token);

      state = state.copyWith(loginState: LoginStatusEnums.success);
    } catch (e) {
      if (e.toString().contains("Invalid credentials")) {
        state = state.copyWith(loginState: LoginStatusEnums.invalidCredentials);
      }
      if (e.toString().contains("User does not exist")) {
        state = state.copyWith(loginState: LoginStatusEnums.doesNotExist);
      } else {
        state = state.copyWith(loginState: LoginStatusEnums.error);
      }
    }
  }


  // submit user data
  Future<void> submitUserData(String username, String password) async {
    state = state.copyWith(
      signUpState: UserCreationEnums.loading
    );

    try {
      final signUpNotifier = ref.read(signUpProvider);

      final result = await signUpNotifier.submitUserData(username, password);

      state = state.copyWith(signUpState: result);
    }

    catch (e) {
      if (e == UserCreationEnums.failed){
        state = state.copyWith(
          signUpState: UserCreationEnums.failed
        );
      }
      if (e == UserCreationEnums.serverError){
        state = state.copyWith(
          signUpState: UserCreationEnums.serverError
        );
      }
    }
  }



}
