import 'package:bloc/bloc.dart';
import 'package:html/parser.dart';
import 'package:meta/meta.dart';
import 'package:tsms/models/country_model.dart';
import 'package:http/http.dart' as http;

part 'country_bloc_manager_event.dart';
part 'country_bloc_manager_state.dart';

class CountryBlocManagerBloc
    extends Bloc<CountryBlocManagerEvent, CountryBlocManagerState> {
  CountryBlocManagerBloc() : super(CountryBlocManagerInitial()) {
    on<CountryBlocManagerEvent>((event, emit) async {
      if (event is GetAllCountries) {
        emit(CountryBlocManagerLoading());

        if (true) {
          List<CountryModel> countriesList = [];

          // Making `GET` request
          final response = await http.get(Uri.parse("https://smstome.com"));

          var doc = parse(response.body);
          var elements = doc.querySelectorAll('.column.fields ul li a');

          for (var element in elements) {
            String countryName = element.text.trim();
            String imageUrl =
                element.querySelector('img')?.attributes['src'] ?? '';
            // Getting images using the base doman and image id.
            String fullImageUrl = 'https://smstome.com$imageUrl';

            var countryModel = CountryModel(countryName, fullImageUrl);
            countriesList.add(countryModel);
          }

          countriesList != null
              ? emit(CountryBlocManagerSuccess(countryModel: countriesList))
              : [];
        }
      }
    });
  }
}
