import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:tsms/utils/firebase_constants.dart';
import 'package:tsms/utils/firebase_package_helper.dart';

part 'get_version_event.dart';
part 'get_version_state.dart';

class GetVersionBloc extends Bloc<GetVersionEvent, GetVersionState> {
  GetVersionBloc() : super(GetVersionInitial()) {
    on<GetVersionEvent>((event, emit) async {
      if (event is GetVersion) {
        final data =
            await firebaseFirestore.collection(collection).doc(document).get();

        emit(
          GetVersionSuccess(
              isFirebaseInit: data.exists,
              version: data.exists ? data.get('version') : 1.0),
        );
      }
    });
  }
}
