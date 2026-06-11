import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTabsSection extends StatefulWidget {
  const CustomTabsSection({
    super.key,
    required this.controller,
    required this.widget1,
    required this.widget2,
    required this.widget3,
    this.onTabChanged,
  });

  final TabController controller;
  final Widget widget1;
  final Widget widget2;
  final Widget widget3;
  final Function(int)? onTabChanged;

  @override
  State<CustomTabsSection> createState() => _CustomTabsSectionState();
}

class _CustomTabsSectionState extends State<CustomTabsSection> {
  @override
  void initState() {
    super.initState();

    widget.controller.addListener(() {
      if (!widget.controller.indexIsChanging) {
        widget.onTabChanged?.call(widget.controller.index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          /// Tabs
          ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Container(
              height: 40.h,
              width: 40.w,
              decoration: BoxDecoration(color: Colors.white),
              child: TabBar(
                controller: widget.controller,
                indicator: BoxDecoration(
                  color: Color(0xff9A87A4),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                labelColor: Colors.white,
                labelStyle: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),

                unselectedLabelColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.tab,
                // dividerColor: Colors.transparent,
                tabs: const [
                  Tab(text: "This Week"),
                  Tab(text: "This Month"),
                  Tab(text: "All"),
                ],
              ),
            ),
          ),

          SizedBox(height: 20.h),

          /// Tab Views
          Expanded(
            child: TabBarView(
              controller: widget.controller,
              children: [widget.widget1, widget.widget2, widget.widget3],
            ),
          ),
        ],
      ),
    );
  }
}
