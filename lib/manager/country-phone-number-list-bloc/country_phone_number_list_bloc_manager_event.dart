part of 'country_phone_number_list_bloc_manager_bloc.dart';

@immutable
sealed class CountryPhoneNumberListBlocManagerEvent {}

class ChooseCountryEvent extends CountryPhoneNumberListBlocManagerEvent {
  final String? countryCode;
  final String pageNumber;

  ChooseCountryEvent({required this.countryCode, required this.pageNumber});
}
