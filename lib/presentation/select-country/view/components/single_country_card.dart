import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsms/presentation/resources/style.dart';
import 'package:tsms/presentation/resources/values_manager.dart';

class SingleCountryCard extends StatelessWidget {
  const SingleCountryCard(
      {super.key, required this.name, required this.imageUrl});

  final String name;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppMargin.m8),
      child: Container(
        padding: EdgeInsets.all(AppMargin.m12.spMin),
        margin:
            EdgeInsets.symmetric(horizontal: 0, vertical: AppMargin.m8.spMin),
        height: 130.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppSize.s12.r),
          boxShadow: AppStyles.shadows,
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
                  'Get free ${name.toLowerCase()} number',
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
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
                  height: AppSize.s50.h,
                  width: AppSize.s100.h - 10,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(
                          imageUrl,
                        ),
                        fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(
                  width: AppSize.s12,
                ),
                Text(
                  name.toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                TextButton(
                  style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.green),
                  ),
                  onPressed: () {},
                  child: Text(
                    'See all',
                    style: Theme.of(context)
                        .textTheme
                        .labelLarge!
                        .copyWith(color: Colors.white),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
