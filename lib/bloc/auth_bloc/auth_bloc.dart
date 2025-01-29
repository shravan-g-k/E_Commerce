import 'package:bloc/bloc.dart';
import 'package:e_commerce/data/models/user_model.dart';
import 'package:e_commerce/data/repository/auth_repo.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _userRepository = UserRepository();
  AuthBloc() : super(UserLoading()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(UserLoading());
      await _userRepository.loginUser().then((value) {
        if (value != null) {
          emit(UserAuthenticated(userModel: value));
        }
      }).catchError((error) {
        emit(AuthError(message: error.toString()));
      });
    });

    on<CheckAuthStatus>((event, emit) async {
      emit(UserLoading());
       await for(final user in _userRepository.userStateStream()) {
         if (user != null) {
           emit(UserAuthenticated(userModel: user));
         }
         else {
           emit(UserNotAuthenticated());
         }
       }
    });

    on<LogoutButtonPressed>((event, emit) async {
      await _userRepository.logoutUser().whenComplete(
            () => emit(UserNotAuthenticated()),
          );
    });
  }
}
