import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';

class UserTypeTabs extends StatefulWidget {
  const UserTypeTabs({super.key, required this.widget1, required this.widget2});

  final Widget widget1;
  final Widget widget2;

  @override
  State<UserTypeTabs> createState() => _UserTypeTabsState();
}

class _UserTypeTabsState extends State<UserTypeTabs>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
    controller.addListener(() {
      if (!controller.indexIsChanging) {
        setState(() => _currentIndex = controller.index);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // ------- TAB BAR -------
        Container(
          height: 47.h,
          decoration: BoxDecoration(
            color: Color(0xffF8F4FA),
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Parent Tab
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    controller.animateTo(0);
                    setState(() => _currentIndex = 0);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: _currentIndex == 0
                          ? AppColors.ActiveColor
                          : Color(0xffF8F4FA),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.r),
                        bottomLeft: Radius.circular(10.r),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Parent",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: _currentIndex == 0
                              ? Color(0xffFAF8FB)
                              : AppColors.titleColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Child Tab
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    controller.animateTo(1);
                    setState(() => _currentIndex = 1);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: _currentIndex == 1
                          ? AppColors.ActiveColor
                          : Color(0xffF8F4FA),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.r),
                        bottomRight: Radius.circular(10.r),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Child",
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: _currentIndex == 1
                              ? Color(0xffFAF8FB)
                              : AppColors.titleColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 10.h),

        // ------- TAB VIEW -------
        Expanded(
          child: TabBarView(
            controller: controller,
            children: [widget.widget1, widget.widget2],
          ),
        ),
      ],
    );
  }
}
