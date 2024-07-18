import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:msa_money_tracker/core/animation/animation.dart';
import 'package:msa_money_tracker/core/constants/ui_colors.dart';
import 'package:msa_money_tracker/core/widgets/app_icon.dart';
import 'package:msa_money_tracker/presentation/home/pages/home_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  Future<void> gotoHomeScreen(BuildContext context) async {
    await Future.delayed(
      const Duration(seconds: 3),
      () => Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
        (route) => false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => gotoHomeScreen(context),
    );
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: UiColors.secondary,
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeOutQuad,
            child: AnimationBuildLogin(
              size: size,
              yOffset: size.height / 1.16.h,
              color: UiColors.primary,
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppIcon(size: 100.h),
                  Text(
                    "Expense Tracker",
                    style: TextStyle(
                      color: UiColors.ternary,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
