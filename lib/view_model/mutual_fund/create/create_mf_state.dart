part of 'create_mf_cubit.dart';

@immutable
abstract class CreateMfState {}

class CreateMfInitial extends CreateMfState {}

class FiledUpdated extends CreateMfState {}

class FundDetailsLoaded extends CreateMfState {}
