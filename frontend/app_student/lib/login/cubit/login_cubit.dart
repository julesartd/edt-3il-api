import 'package:app_student/api/users/repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final UserRepository userRepository;

  LoginCubit(this.userRepository) : super(LoginInitial()) {
    checkUserAuthentication();
  }

  Future<bool> areFieldsFilled(String name) async {
    if (name.isEmpty) {
      return false;
    }
    return true;
  }

  Future<void> saveLoginDetails(String name) async {
    if (!(await areFieldsFilled(name))) {
      emit(LoginFieldError());
      return;
    }
    await userRepository.saveUserDetails(name, '', ine: null, birthDate: null);
    emit(RedirectToClassSelection());
  }

  Future<bool> checkUserAuthentication() async {
    try {
      var user = await userRepository.getUser();
      // Si la classe est vide
      if (user.className == '') {
        emit(LoginInitial());
        return false;
      }
      emit(LoginAuthenticated());
      return true;
    } catch (e) {
      emit(LoginInitial());
      return false;
    }
  }
}
