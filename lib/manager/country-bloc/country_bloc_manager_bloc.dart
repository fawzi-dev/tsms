import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'country_bloc_manager_event.dart';
part 'country_bloc_manager_state.dart';

class CountryBlocManagerBloc extends Bloc<CountryBlocManagerEvent, CountryBlocManagerState> {
  CountryBlocManagerBloc() : super(CountryBlocManagerInitial()) {
    on<CountryBlocManagerEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
