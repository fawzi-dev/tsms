import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsms/manager/country-bloc/country_bloc_manager_bloc.dart';
import 'package:tsms/presentation/resources/values_manager.dart';

class SelectCountryView extends StatelessWidget {
  const SelectCountryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              horizontal: AppMargin.m12.sp,
            ),
            child: ListView(
              children: List.generate(
                state.countryModel!.length,
                (index) => Container(
                  padding: EdgeInsets.all(AppMargin.m12.sp),
                  margin: EdgeInsets.symmetric(
                      horizontal: 0, vertical: AppMargin.m8.sp),
                  height: 130.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(AppSize.s12.r),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: const Offset(0, 2),
                          blurRadius: 1,
                          spreadRadius: 1)
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: AppMargin.m4),
                            child: Icon(
                              Icons.message_rounded,
                              size: AppSize.s20,
                              color: Colors.black38,
                            ),
                          ),
                          Text(
                            'Get free ${state.countryModel?[index].name.toLowerCase()} number',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                  color: Colors.black38,
                                ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: AppSize.s8.h,
                      ),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            height: AppSize.s60.h,
                            width: AppSize.s100.h - 10,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    state.countryModel![index].imageUrl,
                                  ),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          const SizedBox(
                            width: AppSize.s12,
                          ),
                          Text(
                            state.countryModel![index].name.toUpperCase(),
                            style: Theme.of(context).textTheme.titleMedium,
                          )
                        ],
                      )
                    ],
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
