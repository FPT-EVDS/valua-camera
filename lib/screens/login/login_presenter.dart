import 'package:dio/dio.dart';
import 'package:valua_staff/di/injection.dart';
import 'package:valua_staff/models/auth_user.dart';
import 'package:valua_staff/models/errors/AuthUserException.dart';
import 'package:valua_staff/repository/auth_repository.dart';
import 'package:valua_staff/screens/login/login_view.dart';

class LoginPresenter {
  LoginView _loginView;
  late AuthRepository _authRepository;

  LoginPresenter(this._loginView) {
    _authRepository = new Injector().authRepository;
  }

  void login(String email, String password) async {
    try {
      if (email.isNotEmpty) {
        AuthUser user = await _authRepository.login(email, password);
        _loginView.loginSuccess(user);
      }
    } on DioError catch (e) {
      print(e);
      _loginView.loginFail("Email hoặc password không hợp lệ");
    } on AuthUserException catch (e) {
      print(e);
      _loginView.loginFail(e.message.toString());
    } catch (e) {
      print(e);
      _loginView.loginFail("Lỗi không xác định");
    }
  }
}
