part of 'country_phone_number_list_bloc_manager_bloc.dart';

@immutable
sealed class CountryPhoneNumberListBlocManagerState {}

class CountryPhoneNumberListBlocManagerInitial
    extends CountryPhoneNumberListBlocManagerState {}

class CountryPhoneNumberListBlocManagerLoading
    extends CountryPhoneNumberListBlocManagerState {}

class CountryPhoneNumberListBlocManagerSuccess
    extends CountryPhoneNumberListBlocManagerState {
  final List<PhoneNumberModel> phoneNumbersList;

  CountryPhoneNumberListBlocManagerSuccess({required this.phoneNumbersList});
}

class CountryPhoneNumberListBlocManagerFailed
    extends CountryPhoneNumberListBlocManagerState {
  final String message;

  CountryPhoneNumberListBlocManagerFailed({required this.message});
}
