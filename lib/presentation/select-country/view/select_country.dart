import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsms/manager/country-bloc/country_bloc_manager_bloc.dart';
import 'package:tsms/manager/country-phone-number-list-bloc/country_phone_number_list_bloc_manager_bloc.dart';
import 'package:tsms/presentation/country-number-list/view/country_number_list.dart';
import 'package:tsms/presentation/resources/assets.dart';
import 'package:tsms/presentation/resources/values_manager.dart';
import 'package:tsms/presentation/select-country/view/components/drawer_button.dart';
import 'package:tsms/presentation/select-country/view/components/single_country_card.dart';

class SelectCountryView extends StatelessWidget {
  const SelectCountryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 180.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppAssets.bannerHeader),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.65),
                        Colors.transparent
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppPadding.p12.spMin,
                      vertical: AppPadding.p20.spMin,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Image.asset(
                          AppAssets.appLogo,
                          width: 60.spMax,
                        ),
                        SizedBox(
                          width: AppMargin.m6.spMin,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'T-SMSS',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge!
                                  .copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            Text(
                              'Receive SMS for verification',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(AppMargin.m20.spMin),
                child: Column(
                  children: [
                    CustomDrawerButton(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      label: 'Home',
                      icon: Icons.home,
                    ),
                    CustomDrawerButton(
                      onTap: () {},
                      label: 'Share',
                      icon: Icons.share,
                    ),
                    CustomDrawerButton(
                      onTap: () {},
                      label: 'Rate us',
                      icon: Icons.rate_review,
                    ),
                    CustomDrawerButton(
                      onTap: () {},
                      label: 'Privacy policy',
                      icon: Icons.info,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        title: const Text('Select Country'),
        elevation: 5.0,
        shadowColor: Colors.black,
      ),
      body: const SelectCountryViewBody(),
    );
  }
}

class SelectCountryViewBody extends StatelessWidget {
  const SelectCountryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<CountryManagerBloc>(context).add(GetAllCountries());
    return BlocBuilder<CountryManagerBloc, CountryBlocManagerState>(
      builder: (context, state) {
        if (state is CountryBlocManagerSuccess) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppMargin.m12.spMin,
            ),
            child: ListView(
              children: List.generate(
                state.countryModel!.length,
                (index) => GestureDetector(
                  onTap: () {
                    BlocProvider.of<CountryPhoneNumberListBlocManagerBloc>(context)
                        .add(
                      ChooseCountryEvent(
                        countryCode: state.countryModel?[index].countryEndpoint,
                        pageNumber: '1',
                      ),
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CountryNumberList(
                          imgUrl: state.countryModel?[index].imageUrl ?? '',
                          selectedCountry:
                              state.countryModel?[index].name ?? '',
                          countryEndPoint:
                              state.countryModel?[index].countryEndpoint,
                        ),
                      ),
                    );
                  },
                  child: SingleCountryCard(
                    name: state.countryModel?[index].name ?? '',
                    imageUrl: state.countryModel?[index].imageUrl ?? '',
                  ),
                ),
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
