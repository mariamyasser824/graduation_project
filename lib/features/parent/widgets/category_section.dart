import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rewarding_kids/features/parent/cubit/tasks_cubit/add_task_cubit.dart';
import 'package:rewarding_kids/features/parent/cubit/tasks_cubit/add_task_state.dart';
import 'package:rewarding_kids/features/parent/models/category_model.dart';

class CategorySection extends StatelessWidget {
  const CategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTaskCubit, AddTaskState>(
      builder: (context, state) {
        // 🟢 Loading state
        if (state.isLoading) {
          return Center(
            child: SizedBox(
              height: 40.h,
              width: 40.w,
              child: CircularProgressIndicator(
                color: Color(0xff984CFB),
                strokeWidth: 3,
              ),
            ),
          );
        }
        final categories = state.categories;
        if (categories.isEmpty) return const SizedBox();
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: categories.map((cat) {
            final isSelected = state.form.category == cat.id;
            return ChoiceChip(
              label: Text(cat.name, textAlign: TextAlign.center),
              showCheckmark: false,
              selectedColor: Color(0xff984CFB),
              backgroundColor: Color(0xffE4E4E4),
              labelStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: isSelected ? Colors.white : Color(0xff60697B),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
                side: BorderSide(color: Colors.transparent),
              ),
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),

              selected: isSelected,
              onSelected: (_) {
                context.read<AddTaskCubit>().selectCategory(cat);
              },
            );
          }).toList(),
        );
      },
    );
  }
}
