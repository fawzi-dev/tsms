part of 'country_bloc_manager_bloc.dart';

@immutable
sealed class CountryBlocManagerState {}

class CountryBlocManagerInitial extends CountryBlocManagerState {}

class CountryBlocManagerLoading extends CountryBlocManagerState {}

class CountryBlocManagerSuccess extends CountryBlocManagerState {
  List<CountryModel>? countryModel;

  CountryBlocManagerSuccess({this.countryModel});
}

class CountryBlocManagerFailed extends CountryBlocManagerState {
  final String? message;

  CountryBlocManagerFailed({this.message});
}
