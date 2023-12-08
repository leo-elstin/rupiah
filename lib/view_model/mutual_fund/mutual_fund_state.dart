part of 'mutual_fund_cubit.dart';

@immutable
abstract class MutualFundState {}

class MutualFundInitial extends MutualFundState {}

class MutualFundLoading extends MutualFundState {}

class MutualFundLoaded extends MutualFundState {}
