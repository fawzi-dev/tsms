import 'package:flutter/material.dart';
import 'package:tsms/utils/app_constants.dart';
import 'package:tsms/utils/custom_button.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateView extends StatelessWidget {
  const UpdateView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              label: 'Update to newer version',
              onPressed: _launchURL,
            ),
          ],
        ),
      ),
    );
  }

  void _launchURL() async {
    const url = updateLink;
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print('Error launching URL: $e');
    }
  }
}
