import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/core_export.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../res/res_export.dart';
import '../../../../../services/services_export.dart';
import '../bloc/splash_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<SplashBloc>().add(const SplashNavigate());

    return BlocConsumer<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashToDashboard) {
          NavigationService.navigateReplaced(RoutePaths.todolist);
        } else if (state is SplashToLogin) {
          NavigationService.navigateReplaced(RoutePaths.loginScreen);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  height: 120,
                  width: 120,
                  color: context.resources.color.white,
                  child: Image.asset(context.resources.drawable.icon, height: 36, width: 36,),
                ),
              ),
              const Positioned(
                bottom: 60,
                left: 0,
                right: 0,
                child: Center(
                  child: CircularProgressIndicator(
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
