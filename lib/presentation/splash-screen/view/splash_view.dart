import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:tsms/manager/get-version/get_version_bloc.dart';
import 'package:tsms/presentation/resources/assets.dart';
import 'package:tsms/presentation/resources/values_manager.dart';
import 'package:tsms/presentation/select-country/view/select_country.dart';
import 'package:tsms/presentation/update/update.dart';
import 'package:tsms/utils/app_constants.dart';

class SplashScreenBase extends StatelessWidget {
  const SplashScreenBase({super.key});

  @override
  Widget build(BuildContext context) {
    // CHECKING IF FIREBASE IS INITIALIZED
    BlocProvider.of<GetVersionBloc>(context).add(GetVersion());
    return BlocBuilder<GetVersionBloc, GetVersionState>(
      builder: (context, state) {
        return SplashScreenView(
          version:
              state is GetVersionSuccess ? state.version.toString() : '1.0',
        );
      },
    );
  }
}

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key, required this.version});

  final String version;

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _goToNextPage();
  }

  void _goToNextPage() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => double.tryParse(widget.version) == appVersion
              ? const SelectCountryView()
              : const UpdateView(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: AppPadding.p28 + 6),
              child: Lottie.asset(AppAssets.lottieAnimation),
            )
          ],
        ),
      ),
    );
  }
}
