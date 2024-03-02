import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tsms/models/phone_number.model.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
part 'country_phone_number_list_bloc_manager_event.dart';
part 'country_phone_number_list_bloc_manager_state.dart';

class CountryPhoneNumberListBlocManagerBloc extends Bloc<
    CountryPhoneNumberListBlocManagerEvent,
    CountryPhoneNumberListBlocManagerState> {
  CountryPhoneNumberListBlocManagerBloc()
      : super(CountryPhoneNumberListBlocManagerInitial()) {
    on<CountryPhoneNumberListBlocManagerEvent>(
      (event, emit) async {
        if (event is ChooseCountryEvent) {
          emit(CountryPhoneNumberListBlocManagerLoading());
          List<PhoneNumberModel> allNumbers = [];

          try {
            final response = await http.get(
                Uri.parse("https://smstome.com/country/${event.countryCode}"));

            if (response.statusCode == 200) {
              var doc = parser.parse(response.body);
              var elements = doc.querySelectorAll(".column .row .column");

              var pages = doc.querySelectorAll('.pagination a');

              if (pages.isNotEmpty) {
                for (int i = 1; i < pages.length; i++) {
                  print(
                    pages[i].attributes['href']?.replaceAll(
                          'https://smstome.com/country/${event.countryCode}?page=',
                          '',
                        ),
                  );
                }
              }

              print("AC SIZE: ${elements.length}"); // Example of logging

              for (var element in elements) {
                var rows = element.querySelectorAll(".row");

                String origin = rows[0].querySelector("small")!.text;
                var isNew = rows[1].querySelectorAll("strong");
                String addedOn = rows[1].querySelector("small")!.text;
                var urlElement = rows[2].querySelector("a")!;
                String url = urlElement.attributes['href']!;
                String phoneNumber = urlElement.text;

                var phoneNumberModel =
                    PhoneNumberModel(origin, addedOn, url, phoneNumber);
                if (isNew.isNotEmpty) {
                  phoneNumberModel.isNew = true;
                }
                allNumbers.add(phoneNumberModel);
              }
              allNumbers.isNotEmpty
                  ? emit(CountryPhoneNumberListBlocManagerSuccess(
                      phoneNumbersList: allNumbers))
                  : [];
            } else {
              emit(
                CountryPhoneNumberListBlocManagerFailed(
                  message: response.statusCode.toString(),
                ),
              );
            }
          } catch (e) {
            print("ERR: $e");
          }
        }
      },
    );
  }
}
