part of 'mf_login_cubit.dart';

@immutable
abstract class MfLoginState {}

class MfLoginInitial extends MfLoginState {}

class MfLoginFailed extends MfLoginState {}

class MFLoginExpired extends MfLoginState {}

class MFNotLoggedIn extends MfLoginState {}
