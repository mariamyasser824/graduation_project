import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rewarding_kids/features/parent/widgets/Performance%20Section.dart';
import 'package:rewarding_kids/features/parent/widgets/Tabs.dart';
import 'package:rewarding_kids/features/parent/widgets/Tasks%20Summary%20Cards.dart';
import 'package:rewarding_kids/features/parent/widgets/home_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  final bool isNewUser = true; // ✨ غيريها false لو عايزة الصفحة التانية

  @override
  Widget build(BuildContext context) {
    return HomeBody();
  }
}
