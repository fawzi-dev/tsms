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
  final Set<int> pageNumber;

  CountryPhoneNumberListBlocManagerSuccess({
    required this.phoneNumbersList,
    required this.pageNumber,
  });
}

class CountryPhoneNumberListBlocManagerFailed
    extends CountryPhoneNumberListBlocManagerState {
  final String message;

  CountryPhoneNumberListBlocManagerFailed({required this.message});
}
