import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rewarding_kids/Shared/Custombutton.dart';
import 'package:rewarding_kids/features/parent/widgets/settings_scaffold_appbar.dart';
import 'editable_info_field.dart';

class PersonalInfoBody extends StatefulWidget {
  const PersonalInfoBody({super.key});

  @override
  State<PersonalInfoBody> createState() => _PersonalInfoBodyState();
}

class _PersonalInfoBodyState extends State<PersonalInfoBody> {
  final nameController = TextEditingController(text: 'Mariam Yasser');
  final emailController = TextEditingController(text: 'mariam@email.com');

  bool savePressed = false; // لما تدوس Save

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsScaffoldAppbar(title: 'Personal Information'),
        SizedBox(height: 20.h),
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
            label: 'Email',
            controller: emailController,
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
