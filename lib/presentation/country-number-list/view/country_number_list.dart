import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsms/manager/country-bloc/country_bloc_manager_bloc.dart';
import 'package:tsms/manager/country-phone-number-list-bloc/country_phone_number_list_bloc_manager_bloc.dart';
import 'package:tsms/presentation/resources/style.dart';

import '../../resources/values_manager.dart';

class CountryNumberList extends StatelessWidget {
  const CountryNumberList({
    super.key,
    required this.imgUrl,
    required this.selectedCountry,
    required this.countryEndPoint,
  });

  final String imgUrl;
  final String selectedCountry;
  final String countryEndPoint;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.spMin),
        child: AppBar(
          centerTitle: true,
          title: Column(
            children: [
              Text(
                'Select a Phone Number',
                style: Theme.of(context).textTheme.labelSmall,
              ),
              Text(
                selectedCountry,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ),
      body: CountryNumberListBody(
        imgUrl: imgUrl,
        contryEndpoint: countryEndPoint,
      ),
    );
  }
}

class CountryNumberListBody extends StatelessWidget {
  CountryNumberListBody(
      {super.key, required this.imgUrl, required this.contryEndpoint});

  final String imgUrl;
  final String contryEndpoint;

  // page
  int page = 1;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountryPhoneNumberListBlocManagerBloc,
        CountryPhoneNumberListBlocManagerState>(
      builder: ((context, state) {
        if (state is CountryPhoneNumberListBlocManagerSuccess) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
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
                  },
                ),
              ),
              state.pageNumber.isNotEmpty
                  ? SizedBox(
                      height: 60.sp,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            onPressed: () =>
                                _goToPrevious(context, state.pageNumber.first),
                            icon: const Icon(Icons.arrow_back),
                          ),
                          Text(
                            '$page page of  ${state.pageNumber.last}  page(s)',
                          ),
                          IconButton(
                            onPressed: () =>
                                _goToNextPage(context, state.pageNumber.last),
                            icon: const Icon(
                              Icons.arrow_forward,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }

  _goToPrevious(BuildContext context, int firstPageIndex) {
    print(page);
    if (page != firstPageIndex) {
      page--;
      BlocProvider.of<CountryPhoneNumberListBlocManagerBloc>(context).add(
        ChooseCountryEvent(
          countryCode: contryEndpoint,
          pageNumber: page.toString(),
        ),
      );
    }
  }

  _goToNextPage(BuildContext context, int lastPageIndex) {
    if (page != lastPageIndex) {
      page++;
      BlocProvider.of<CountryPhoneNumberListBlocManagerBloc>(context).add(
        ChooseCountryEvent(
          countryCode: contryEndpoint,
          pageNumber: page.toString(),
        ),
      );
    }
  }
}
