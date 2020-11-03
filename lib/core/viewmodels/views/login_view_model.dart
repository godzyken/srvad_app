import 'package:srvad_app/core/services/dialog_service.dart';

import 'package:srvad_app/core/viewmodels/views/base_model.dart';
import 'package:srvad_app/core/services/navigation_service.dart';

class LoginViewModel extends BaseModel {
  DialogService _dialogService;
  NavigationService _navigationService;

  String errorMessage;
  String _email;
  String _password;
  String _success;

  get email => _email;

  get password => _password;

  get success => _success;

  set success(String success) {
    _success = success;
    notifyListeners();
  }

  set email(String email) {
    _email = email;
    notifyListeners();
  }

  set password(String password) {
    _password = password;
    notifyListeners();
  }

  login({String email, String password}) async {
    setState(true);
    _success = await login(
      email: _email,
      password: _password,
    );

    if (_success is bool) {
      if (_success != null) {
        setState(true);
        _navigationService.navigateTo('home');
      } else {
        setState(false);
        await _dialogService.showDialog(
          title: 'Login Failure',
          description: 'General login failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Login Failure',
        description: _success,
      );
      setState(false);
    }
  }

  Future createUserWithCredential(String email, String password) async {
    setState(true);

    // Not null
    if (email == null) {
      errorMessage = 'Email field must be non empty!';
      setState(false);
      return false;
    }

    // TODO: Handle potential error here too.

    setState(false);
    return success;
  }

  ghostMode() async {
    setState(true);
    //TODO: set dev connection
  }

  Future signInWithGoogle() async {
    setState(true);

    var success = await signInWithGoogle();

    if (success is bool) {
      if (success != null) {
        setState(true);
        _navigationService.navigateTo('home');
      } else {
        setState(false);
        await _dialogService.showDialog(
          title: 'Login Failure',
          description: 'General login failure. Please try again later',
        );
      }
    } else {
      await _dialogService.showDialog(
        title: 'Login Failure',
        description: success,
      );
      setState(false);
    }
  }
}