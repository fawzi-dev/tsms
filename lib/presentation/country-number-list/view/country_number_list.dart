import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tsms/manager/country-bloc/country_bloc_manager_bloc.dart';
import 'package:tsms/manager/country-phone-number-list-bloc/country_phone_number_list_bloc_manager_bloc.dart';

class CountryNumberList extends StatelessWidget {
  const CountryNumberList({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CountryNumberListBody(),
    );
  }
}

class CountryNumberListBody extends StatelessWidget {
  const CountryNumberListBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountryPhoneNumberListBlocManagerBloc,
        CountryPhoneNumberListBlocManagerState>(
      builder: ((context, state) {
        if (state is CountryPhoneNumberListBlocManagerSuccess) {
          return ListView.builder(
              itemCount: state.phoneNumbersList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading:
                      Text(state.phoneNumbersList[index].isNew ? 'New' : ''),
                  title: Text(
                    state.phoneNumbersList[index].phoneNumber,
                  ),
                  subtitle: Text(
                    state.phoneNumbersList[index].addedOn.replaceAll(' ', ''),
                  ),
                );
              });
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }
}
