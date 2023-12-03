import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:expense_kit/model/service/login_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  bool _optSent = false;

  bool get otpSent => _optSent;
  String? _phone;

  String? get phone => _phone;

  set phone(String? phone) {
    _phone = phone;
    emit(AuthInitial());
  }

  String? _otp;

  String? get otp => _otp;

  Token? _token;
  User? _user;

  User? get user => _user;

  bool validNumber() => _phone != null && _phone!.length == 10;

  void validateLogin() async {
    emit(UserLoggedIn());
    _user = await LoginService.getUser();
    emit(UserNotLoggedIn());
  }

  void fetchOTP() async {
    emit(FetchingOTP());
    _token = await LoginService.createAccount('+91$_phone', ID.unique());
    _optSent = true;
    emit(FetchedOTP());
  }

  void validateOTP(String otp) async {
    emit(ValidatingOTP());
    _user = await LoginService.updateSession(_token!.userId, otp);
    emit(AuthSuccess());
  }
}
