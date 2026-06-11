import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/features/parent/widgets/ArrowSettingsItem.dart';
import 'package:rewarding_kids/features/parent/widgets/SwitchSettingsItem.dart';
import 'package:rewarding_kids/features/parent/widgets/settingCard.dart';
import 'package:rewarding_kids/features/parent/widgets/settings_scaffold_appbar.dart';

class PrivacyBody extends StatefulWidget {
  const PrivacyBody({super.key});

  @override
  State<PrivacyBody> createState() => _PrivacyBodyState();
}

class _PrivacyBodyState extends State<PrivacyBody> {
  bool biometricEnabled = false;
  bool FaceidEnabled = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsScaffoldAppbar(title: 'Privacy & safety'),
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(16.w),
            children: [
              SettingsCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SwitchSettingsItem(
                      title: 'Biometric ID',
                      value: biometricEnabled,
                      onChanged: (val) =>
                          setState(() => biometricEnabled = val),
                    ),
                    SwitchSettingsItem(
                      title: 'Face ID',
                      value: FaceidEnabled,
                      onChanged: (val) => setState(() => FaceidEnabled = val),
                    ),
                  ],
                ),
              ),

              /// 🔑 Change Password
              SettingsCard(
                child: ArrowSettingsItem(
                  title: 'Deactivate Account',
                  subtitle:
                      'Temporarily deactivate your account. Easily\n reactivate when you\'re ready.',
                  onTap: () {},
                ),
              ),

              /// ⏸ Deactivate Account
              SettingsCard(
                child: ArrowSettingsItem(
                  title: 'Device Management',
                  subtitle:
                      'Manage your account on the various devices you\n own.',
                  onTap: () {},
                ),
              ),
              SettingsCard(
                child: ArrowSettingsItem(
                  title: 'Change Password',
                  subtitle:
                      'Update your password to keep your account \nsecure.',
                  onTap: () {},
                ),
              ),

              /// 🗑 Delete Account (Danger)
              SettingsCard(
                child: ArrowSettingsItem(
                  title: 'Delete Account',
                  subtitle:
                      'Permanently remove your account and data\n from Tripmate. Proceed with caution.',
                  titleColor: Colors.red,
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
