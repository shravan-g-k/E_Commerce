import 'package:bloc/bloc.dart';
import 'package:e_commerce/data/models/user_model.dart';
import 'package:e_commerce/data/repository/auth_repo.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _userRepository;
  UserModel? _userModel;

  UserModel get user => _userModel!;
  AuthBloc(this._userRepository) : super(UserLoading()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(UserLoading());
      await _userRepository.loginUser().then((value) async {
        if (value != null) {
          _userModel = value;
          emit(UserAuthenticated(userModel: value));
        } else {
          emit(UserNotAuthenticated());
        }
      }).catchError((error, s) {
        emit(AuthError(message: error.toString()));
      });
    });

    on<CheckAuthStatus>((event, emit) async {
      emit(UserLoading());
      await for (final user in _userRepository.userStateStream()) {
        if (user != null) {
          _userModel = user;
          emit(UserAuthenticated(userModel: user));
        } else {
          emit(UserNotAuthenticated());
        }
      }
    });

    on<LogoutButtonPressed>((event, emit) async {
      await _userRepository.logoutUser().whenComplete(
        () {
          _userModel = null;
          emit(UserNotAuthenticated());
        },
      );
    });

    on<UpdateUser>((event, emit) async {
      emit(UserLoading());
      await _userRepository.updateUser(event.user).whenComplete(
        () {
          _userModel = event.user;
          emit(UserAuthenticated(
            userModel: event.user,
          ));
        },
      );
    });
  }
}
