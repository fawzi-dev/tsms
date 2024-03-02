import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsms/manager/country-bloc/country_bloc_manager_bloc.dart';
import 'package:tsms/manager/country-phone-number-list-bloc/country_phone_number_list_bloc_manager_bloc.dart';
import 'package:tsms/presentation/resources/style.dart';

import '../../resources/values_manager.dart';

class CountryNumberList extends StatelessWidget {
  const CountryNumberList({super.key, required this.imgUrl});

  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CountryNumberListBody(
        imgUrl: imgUrl,
      ),
    );
  }
}

class CountryNumberListBody extends StatelessWidget {
  const CountryNumberListBody({super.key, required this.imgUrl});

  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountryPhoneNumberListBlocManagerBloc,
        CountryPhoneNumberListBlocManagerState>(
      builder: ((context, state) {
        if (state is CountryPhoneNumberListBlocManagerSuccess) {
          print(state.phoneNumbersList.length);
          return ListView.builder(
              itemCount: state.phoneNumbersList.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(AppMargin.m6.spMin),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppSize.s12.r),
                    boxShadow: AppStyles.shadows,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(AppMargin.m12.spMin),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              height: AppSize.s22,
                              width: AppSize.s24 + 12,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    imgUrl,
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: AppMargin.m4,
                            ),
                            Text(state.phoneNumbersList[index].origin)
                          ],
                        ),
                        SizedBox(
                          height: AppMargin.m8.spMin,
                        ),
                        Row(
                          children: [
                            Text(
                              state.phoneNumbersList[index].phoneNumber,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(
                                    fontSize: AppSize.s22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                            )
                          ],
                        )
                      ],
                    ),
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
