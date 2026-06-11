import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rewarding_kids/Shared/Custombutton.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/core/utils/pref_helper.dart';
import 'package:rewarding_kids/features/Parent_registar/cubit/child_cubit.dart';
import 'package:rewarding_kids/features/Parent_registar/cubit/child_state.dart';
import 'package:rewarding_kids/features/Parent_registar/widgets/progress_bar.dart';
import 'package:rewarding_kids/features/onboarding/widgets/popbutton.dart';
import 'package:rewarding_kids/features/Parent_registar/widgets/avatar_grid.dart';

class AvatarView extends StatefulWidget {
  const AvatarView({super.key});

  @override
  State<AvatarView> createState() => _AvatarViewState();
}

class _AvatarViewState extends State<AvatarView> {
  int? selectedAvatar;

  final List<String> avatars = [
    'assets/avatars/avatar1.svg',
    'assets/avatars/avatar2.svg',
    'assets/avatars/avatar3.svg',
    'assets/avatars/avatar4.svg',
    'assets/avatars/avatar5.svg',
    'assets/avatars/avatar6.svg',
    'assets/avatars/avatar7.svg',
    'assets/avatars/avatar8.svg',
    'assets/avatars/avatar9.svg',
    'assets/avatars/avatar10.svg',
    'assets/avatars/avatar11.svg',
    'ADD_IMAGE',
  ];

  bool _dialogShown = false;

  @override
  Widget build(BuildContext context) {
    final h = 1.sh;

    return BlocListener<ChildRegistrationCubit, ChildRegistrationState>(
      listener: (context, state) async {
        /// loading
        if (state.isLoading && !_dialogShown) {
          _dialogShown = true;

          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        }

        /// success
        if (!state.isLoading && state.child != null) {
          if (_dialogShown && Navigator.canPop(context)) {
            Navigator.pop(context);
            _dialogShown = false;
          }

          context.push('/account_done', extra: state.child);
        }

        /// error
        if (!state.isLoading && state.error != null) {
          if (_dialogShown && Navigator.canPop(context)) {
            Navigator.pop(context);
            _dialogShown = false;
          }

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error!)));
        }
      },

      child: Scaffold(
        backgroundColor: AppColors.Background,
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Back button
                Row(children: [Popbutton(onPressed: () => context.pop())]),

                SizedBox(height: h * 0.02),

                /// Progress
                BlocBuilder<ChildRegistrationCubit, ChildRegistrationState>(
                  builder: (context, state) {
                    return AnimatedGradientProgress(progress: state.progress);
                  },
                ),

                SizedBox(height: h * 0.03),

                /// Title
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Choose Child Avatar",
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: h * 0.01),
                      Text(
                        "Express avatar to enjoy kid character vibe",
                        style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: h * 0.03),

                /// Avatar Grid
                SizedBox(
                  height: h * 0.42,
                  child: AvatarGrid(
                    avatars: avatars,
                    selectedAvatar: selectedAvatar,

                    onAvatarSelected: (index) {
                      setState(() {
                        selectedAvatar = index;
                      });
                    },

                    onCustomImagePicked: (path) {
                      setState(() {
                        avatars[avatars.length - 1] = path;
                        selectedAvatar = avatars.length - 1;
                      });
                    },
                  ),
                ),

                SizedBox(height: h * 0.03),

                /// Continue Button
                Custombutton(
                  text: "Continue",
                  onPressed: () {
                    if (selectedAvatar == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select an avatar"),
                        ),
                      );
                      return;
                    }

                    final cubit = context.read<ChildRegistrationCubit>();

                    cubit.setAvatar(avatars[selectedAvatar!]);

                    cubit.submit();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
