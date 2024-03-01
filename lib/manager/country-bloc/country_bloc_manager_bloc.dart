import 'package:bloc/bloc.dart';
import 'package:html/parser.dart';
import 'package:meta/meta.dart';
import 'package:tsms/models/country_model.dart';
import 'package:http/http.dart' as http;

part 'country_bloc_manager_event.dart';
part 'country_bloc_manager_state.dart';

class CountryManagerBloc
    extends Bloc<CountryBlocManagerEvent, CountryBlocManagerState> {
  CountryManagerBloc() : super(CountryBlocManagerInitial()) {
    on<CountryBlocManagerEvent>((event, emit) async {
      if (event is GetAllCountries) {
        emit(CountryBlocManagerLoading());

        // Making `GET` request
        final response = await http.get(Uri.parse("https://smstome.com"));

        // An empty list of country
        List<CountryModel> countriesList = [];

        // Checking if the request was successful
        if (response.statusCode == 200) {
          // Parsing the html document into a tree.
          var doc = parse(response.body);

          // Getting neccessry elements
          var elements = doc.querySelectorAll('.column.fields ul li a');

          for (var element in elements) {
            String countryName = element.text.trim();
            String imageUrl =
                element.querySelector('img')?.attributes['src'] ?? '';
            String links =
                element.attributes['href']?.replaceAll('/country/', '') ?? '';

            // Getting images using the base doman and image id.
            String fullImageUrl = 'https://smstome.com$imageUrl';

            var countryModel = CountryModel(countryName, fullImageUrl,links);
            countriesList.add(countryModel);
          }

          countriesList != null
              ? emit(CountryBlocManagerSuccess(countryModel: countriesList))
              : [];
        } else {
          emit(CountryBlocManagerFailed(
              message: 'Something went wrong, please try again later.'));
        }
      }
    });
  }
}
