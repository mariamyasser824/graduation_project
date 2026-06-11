import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rewarding_kids/features/parent/widgets/ArrowSettingsItem.dart';
import 'package:rewarding_kids/features/parent/widgets/ArrowdownSettingsItem.dart';
import 'package:rewarding_kids/features/parent/widgets/settingCard.dart';
import 'package:rewarding_kids/features/parent/widgets/settings_scaffold_appbar.dart';

class HelpBody extends StatelessWidget {
  const HelpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsScaffoldAppbar(title: 'Help & Support'),

        Expanded(
          child: ListView(
            padding: EdgeInsets.all(16.w),
            children: [
              SettingsCard(
                child: ArrowDownSettingsItem(
                  title: 'How it works',
                  subtitle:
                      'learn how tasks, points and rewards work\n together',
                  onTap: () {},
                ),
              ),

              SettingsCard(
                child: ArrowDownSettingsItem(
                  title: 'Tasks & Rewards Help',
                  subtitle: 'understand tasks ,points ,levels and gifts.',
                  onTap: () {},
                ),
              ),

              SettingsCard(
                child: ArrowDownSettingsItem(
                  title: 'Account & Settings',
                  subtitle:
                      'Manage your account, password, and\n preferences .',
                  onTap: () {},
                ),
              ),

              SettingsCard(
                child: ArrowDownSettingsItem(
                  title: 'Contact Support',
                  subtitle: 'Reach out to your team for personal assistance.',
                  onTap: () {},
                ),
              ),

              SettingsCard(
                child: ArrowDownSettingsItem(
                  title: 'Report a Problem',
                  subtitle: 'Let us know if something isn’t working properly.',
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
