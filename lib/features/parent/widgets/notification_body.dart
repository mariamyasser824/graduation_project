import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rewarding_kids/features/parent/widgets/SettingsSectionTitle.dart';
import 'package:rewarding_kids/features/parent/widgets/SwitchSettingsItem.dart';
import 'package:rewarding_kids/features/parent/widgets/settingCard.dart';
import 'package:rewarding_kids/features/parent/widgets/settings_scaffold_appbar.dart';

class NotificationBody extends StatefulWidget {
  const NotificationBody({super.key});

  @override
  State<NotificationBody> createState() => _NotificationBodyState();
}

class _NotificationBodyState extends State<NotificationBody> {
  bool generalNotification = true;
  bool sound = false;
  bool vibrate = true;

  bool appUpdates = false;
  bool billReminder = true;
  bool promotion = true;
  bool newTask = false;
  bool paymentRequest = false;

  bool newServiceAvailable = false;
  bool newTipsAvailable = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SettingsScaffoldAppbar(title: 'Notifications'),
        Expanded(
          child: ListView(
            padding: EdgeInsets.all(16.w),
            children: [
              /// 🔹 Common
              SettingsCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SettingsSectionTitle(title: 'Common'),

                    SwitchSettingsItem(
                      title: 'General Notification',
                      value: generalNotification,
                      onChanged: (val) =>
                          setState(() => generalNotification = val),
                    ),
                    SwitchSettingsItem(
                      title: 'Sound',
                      value: sound,
                      onChanged: (val) => setState(() => sound = val),
                    ),
                    SwitchSettingsItem(
                      title: 'Vibrate',
                      value: vibrate,
                      onChanged: (val) => setState(() => vibrate = val),
                    ),
                  ],
                ),
              ),

              /// 🔹 System & services update
              SettingsCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SettingsSectionTitle(
                      title: 'System & services update',
                    ),

                    SwitchSettingsItem(
                      title: 'App updates',
                      value: appUpdates,
                      onChanged: (val) => setState(() => appUpdates = val),
                    ),
                    SwitchSettingsItem(
                      title: 'Bill Reminder',
                      value: billReminder,
                      onChanged: (val) => setState(() => billReminder = val),
                    ),
                    SwitchSettingsItem(
                      title: 'Promotion',
                      value: promotion,
                      onChanged: (val) => setState(() => promotion = val),
                    ),
                    SwitchSettingsItem(
                      title: 'New Task',
                      value: newTask,
                      onChanged: (val) => setState(() => newTask = val),
                    ),
                    SwitchSettingsItem(
                      title: 'Payment Request',
                      value: paymentRequest,
                      onChanged: (val) => setState(() => paymentRequest = val),
                    ),
                  ],
                ),
              ),

              /// 🔹 Others
              SettingsCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SettingsSectionTitle(title: 'Others'),

                    SwitchSettingsItem(
                      title: 'New Service Available',
                      value: newServiceAvailable,
                      onChanged: (val) =>
                          setState(() => newServiceAvailable = val),
                    ),
                    SwitchSettingsItem(
                      title: 'New Tips Available',
                      value: newTipsAvailable,
                      onChanged: (val) =>
                          setState(() => newTipsAvailable = val),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
