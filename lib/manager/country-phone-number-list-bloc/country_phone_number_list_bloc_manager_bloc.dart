import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'country_phone_number_list_bloc_manager_event.dart';
part 'country_phone_number_list_bloc_manager_state.dart';

class CountryPhoneNumberListBlocManagerBloc extends Bloc<CountryPhoneNumberListBlocManagerEvent, CountryPhoneNumberListBlocManagerState> {
  CountryPhoneNumberListBlocManagerBloc() : super(CountryPhoneNumberListBlocManagerInitial()) {
    on<CountryPhoneNumberListBlocManagerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
