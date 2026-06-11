import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rewarding_kids/Shared/Custombutton.dart';
import 'package:rewarding_kids/features/parent/widgets/child_info_image.dart';
import 'package:rewarding_kids/features/parent/widgets/editable_info_field.dart';
import 'package:rewarding_kids/features/parent/widgets/settings_scaffold_appbar.dart';

class ChildInfoBody extends StatefulWidget {
  const ChildInfoBody({super.key});

  @override
  State<ChildInfoBody> createState() => _ChildInfoBodyState();
}

class _ChildInfoBodyState extends State<ChildInfoBody> {
  final nameController = TextEditingController(text: 'Nilly Omar');
  final nicknameController = TextEditingController(text: 'nallola');
  final ageController = TextEditingController(text: '6');
  final genderController = TextEditingController(text: 'Girl');

  bool savePressed = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsScaffoldAppbar(title: 'Child Information'),
        SizedBox(height: 40.h),
        ChildInfoImage(),

        SizedBox(height: 10.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: EditableInfoField(
            label: 'Full Name',
            controller: nameController,
            savePressed: savePressed,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: EditableInfoField(
            label: 'Nick name',
            controller: nicknameController,
            savePressed: savePressed,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: EditableInfoField(
            label: 'Age',
            controller: ageController,
            savePressed: savePressed,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: EditableInfoField(
            label: 'Gender',
            controller: genderController,
            savePressed: savePressed,
          ),
        ),

        Spacer(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Custombutton(
            onPressed: () {
              setState(() {
                savePressed = true; // كل الحقول هتعرف انها اتسيفت
              });
            },
            text: 'Save',
          ),
        ),
      ],
    );
  }
}
