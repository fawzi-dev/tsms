import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tsms/presentation/resources/values_manager.dart';

class CustomDrawerButton extends StatelessWidget {
  const CustomDrawerButton(
      {super.key, required this.label, this.onTap, required this.icon});

  final String label;
  final void Function()? onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(5),
      child: Padding(
        padding: EdgeInsets.all(AppMargin.m12.spMin),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.black.withAlpha(200),
            ),
            SizedBox(
              width: AppMargin.m12.w,
            ),
            Padding(
              padding: const EdgeInsets.only(top: AppMargin.m2),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}
