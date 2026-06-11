import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/core/network/api_service.dart';

import 'package:rewarding_kids/features/Parent_registar/data/childmodel.dart';
import 'package:rewarding_kids/features/Parent_registar/views/Account_done_view.dart';
import 'package:rewarding_kids/features/Parent_registar/views/Age_view.dart';
import 'package:rewarding_kids/features/Parent_registar/views/Avatar_view.dart';
import 'package:rewarding_kids/features/Parent_registar/views/Child_gender_view.dart';
import 'package:rewarding_kids/features/Parent_registar/views/Child_name_view.dart';
import 'package:rewarding_kids/features/Parent_registar/views/Relation_view.dart';
import 'package:rewarding_kids/features/adventures/cubits/adventure_cubit/adventure_cubit.dart';
import 'package:rewarding_kids/features/adventures/repos/adventure_repo.dart';
import 'package:rewarding_kids/features/adventures/views/adv_auto_task_view.dart';
import 'package:rewarding_kids/features/adventures/views/adv_image_task_view.dart';
import 'package:rewarding_kids/features/adventures/views/adv_voice_task_view.dart';
import 'package:rewarding_kids/features/adventures/views/adventure_details_view.dart';
import 'package:rewarding_kids/features/adventures/views/celepration_view.dart';
import 'package:rewarding_kids/features/adventures/views/intro_level_view.dart';
import 'package:rewarding_kids/features/adventures/views/levels_screen.dart';
import 'package:rewarding_kids/features/auth/views/Forgetpass_view.dart';
import 'package:rewarding_kids/features/auth/views/login_view.dart';
import 'package:rewarding_kids/features/auth/views/otp1_view.dart';
import 'package:rewarding_kids/features/auth/views/resetpass1_view.dart';
import 'package:rewarding_kids/features/auth/views/resetpass2_view.dart';
import 'package:rewarding_kids/features/auth/views/signup_view.dart';
import 'package:rewarding_kids/features/child/cubit/SubmitTaskCubit.dart';
import 'package:rewarding_kids/features/child/data/models/task_model.dart';
import 'package:rewarding_kids/features/child/data/repos/SubmitTaskRepo.dart';
import 'package:rewarding_kids/features/child/views/Home_child_view.dart';
import 'package:rewarding_kids/features/child/views/Pending_view.dart';
import 'package:rewarding_kids/features/child/views/TakeImage.dart';
import 'package:rewarding_kids/features/child/views/Task_compeleted_view.dart';
import 'package:rewarding_kids/features/child/views/Task_view.dart';
import 'package:rewarding_kids/features/child/views/child_profile.dart';
import 'package:rewarding_kids/features/child/views/do_task_view.dart';
import 'package:rewarding_kids/features/child/views/qrcode_view.dart';
import 'package:rewarding_kids/features/child/views/record_completed.dart';
import 'package:rewarding_kids/features/child/views/record_task_view.dart';
import 'package:rewarding_kids/features/child/views/ubload_image.dart';
import 'package:rewarding_kids/features/child/views/voice_result_view.dart';
import 'package:rewarding_kids/features/child/views/voice_task_view.dart';
import 'package:rewarding_kids/features/child/widgets/CustomBottomNav.dart';
import 'package:rewarding_kids/features/onboarding/views/getstart_view.dart';
import 'package:rewarding_kids/features/onboarding/views/onboarding_view.dart';

import 'package:rewarding_kids/features/parent/views/Help_view.dart';
import 'package:rewarding_kids/features/parent/views/Privacy_view.dart';
import 'package:rewarding_kids/features/parent/views/add_gift_view.dart';
import 'package:rewarding_kids/features/parent/views/add_task_screen.dart';
import 'package:rewarding_kids/features/parent/views/child_info_view.dart';
import 'package:rewarding_kids/features/parent/views/layout_view.dart';
import 'package:rewarding_kids/features/parent/views/notification_view.dart';
import 'package:rewarding_kids/features/parent/views/personal_info_view.dart';
import 'package:rewarding_kids/features/parent/views/task_review_view.dart';

import 'package:rewarding_kids/main.dart';
import 'package:rewarding_kids/splash_view.dart';
import 'package:rewarding_kids/features/parent/models/child_task_model.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    // on boarding
    initialLocation: '/SplashView',
    navigatorKey: rootNavKey,
    routes: [
      GoRoute(
        path: '/SplashView',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingView(),
      ),
      //auth
      GoRoute(
        path: '/getstarted',
        builder: (context, state) => const GetstartView(),
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginView()),

      GoRoute(path: '/signup', builder: (context, state) => const SignupView()),

      GoRoute(
        path: '/forgetpass',
        builder: (context, state) => const ForgetpassView(),
      ),
      GoRoute(
        path: '/otp1',
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;

          return Otp1View(
            email: data["email"],
            userId: data["userId"],
            flow: data["flow"],
          );
        },
      ),

      GoRoute(
        path: '/resetpass1',
        builder: (context, state) {
          final data = state.extra as Map<String, dynamic>;

          return Resetpass1View(
            email: data["email"],
            userId: data["userId"],
            otp: data["otp"],
          );
        },
      ),
      GoRoute(
        path: '/resetpass2',
        builder: (context, state) => const Resetpass2View(),
      ),

      //parent_registar
      GoRoute(
        path: '/child_flow',
        builder: (context, state) {
          return const ChildNameView();
        },
      ),

      GoRoute(
        path: '/child_gender',
        builder: (context, state) {
          return const ChildGenderView();
        },
      ),

      GoRoute(path: '/age', builder: (context, state) => const AgeView()),
      GoRoute(
        path: '/relation',
        builder: (context, state) => const RelationView(),
      ),
      GoRoute(path: '/avatar', builder: (context, state) => const AvatarView()),
      GoRoute(
        path: '/account_done',
        builder: (context, state) {
          final child = state.extra as ChildModel?;
          if (child == null) return Center(child: Text("No child data"));
          return AccountDoneView(extra: child);
        },
      ),

      GoRoute(
        path: '/home_child',
        builder: (context, state) => const HomeChildView(),
      ),

      GoRoute(
        path: '/task_view',
        builder: (context, state) {
          final task = state.extra as TaskModel?;
          if (task == null) {
            return Scaffold(body: Center(child: Text('No task data!')));
          }
          return TaskView(Taskdetails: task);
        },
      ),
      GoRoute(
        path: '/Custombottomnav',
        builder: (context, state) => CustomBottomNav(),
      ),
      GoRoute(
        path: '/do_task',
        builder: (context, state) {
          final task = state.extra as TaskModel?;
          if (task == null) {
            return Scaffold(body: Center(child: Text('No task data!')));
          }
          return BlocProvider(
            create: (context) => SubmitTaskCubit(SubmitTaskRepo()),
            child: DoTaskView(Taskdetails: task),
          );
        },
      ),

      GoRoute(
        path: '/task_completed',
        builder: (context, state) {
          final task = state.extra as TaskModel?; // ? مهم للتحقق
          if (task == null) {
            return Scaffold(
              body: Center(child: Text('No task data!')), // رسالة بديلة
            );
          }
          return TaskCompletedView(taskDetails: task);
        },
      ),
      GoRoute(
        path: '/voice_task',
        builder: (context, state) {
          final task = state.extra as TaskModel?; // ? مهم للتحقق
          if (task == null) {
            return Scaffold(
              body: Center(child: Text('No task data!')), // رسالة بديلة
            );
          }
          return VoiceTaskView(Taskdetails: task);
        },
      ),
      GoRoute(
        path: '/record_task',
        builder: (context, state) {
          final task = state.extra as TaskModel?;

          if (task == null) {
            return Scaffold(body: Center(child: Text('No task data!')));
          }

          return BlocProvider(
            create: (context) => SubmitTaskCubit(SubmitTaskRepo()),
            child: RecordTaskView(Taskdetails: task),
          );
        },
      ),
      GoRoute(
        path: '/voice_result',
        builder: (context, state) {
          final data = state.extra as Map;

          return VoiceResultView(
            task: data["task"],
            audioPath: data["audioPath"],
            response: data["response"],
          );
        },
      ),

      GoRoute(
        path: '/record_completed',
        builder: (context, state) {
          final data = state.extra as Map?;

          if (data == null) {
            return Scaffold(body: Center(child: Text('No task data!')));
          }

          final task = data["task"] as TaskModel;
          final audioPath = data["audio_path"] as String;

          return RecordCompletedView(Taskdetails: task, audioPath: audioPath);
        },
      ),

      GoRoute(
        path: '/take_image',
        builder: (context, state) {
          final task = state.extra as TaskModel?;

          if (task == null) {
            return Scaffold(body: Center(child: Text('No task data!')));
          }

          return Takeimage(Taskdetails: task);
        },
      ),

      GoRoute(
        path: '/pending',
        builder: (context, state) {
          final data = state.extra as Map?;

          if (data == null) {
            return Scaffold(body: Center(child: Text('No task data!')));
          }

          final task = data["task"] as TaskModel;
          final imagepath = data["image_path"] as String?;

          return BlocProvider(
            create: (context) => SubmitTaskCubit(SubmitTaskRepo()),
            child: PendingView(Taskdetails: task, imagePath: imagepath),
          );
        },
      ),
      GoRoute(
        path: '/uploadimage',
        builder: (context, state) {
          final data = state.extra as Map?;

          if (data == null) {
            return Scaffold(body: Center(child: Text('No data!')));
          }

          final task = data['task'] as TaskModel;
          final imagePath = data['image_path'] as String?;

          return UploadImageView(Taskdetails: task, imagePath: imagePath);
        },
      ),
      GoRoute(
        path: '/qrcode',
        builder: (context, state) => const QRScannerView(),
      ),
      GoRoute(path: '/Layout', builder: (context, state) => const LayoutView()),

      GoRoute(
        path: '/addtask',
        builder: (context, state) => const AddTaskScreen(),
      ),
      GoRoute(
        path: '/task_review',
        builder: (context, state) {
          final task = state.extra as ChildTask;
          return TaskReviewView(taskId: task.childTaskId);
        },
      ),
      GoRoute(
        path: '/add_gift',
        builder: (context, state) {
          return AddGiftView();
        },
      ),
      GoRoute(
        path: '/personal_info',
        builder: (context, state) {
          return PersonalInfoView();
        },
      ),
      GoRoute(
        path: '/child_info',
        builder: (context, state) {
          return ChildInfoView();
        },
      ),
      GoRoute(
        path: '/notification',
        builder: (context, state) {
          return NotificationView();
        },
      ),
      GoRoute(
        path: '/privacy',
        builder: (context, state) {
          return PrivacyView();
        },
      ),
      GoRoute(
        path: '/help',
        builder: (context, state) {
          return HelpView();
        },
      ),
      GoRoute(
        path: '/child_profile',
        builder: (context, state) => const ChildProfile(),
      ),
      GoRoute(
        path: '/adventure_details',
        builder: (context, state) {
          final id = state.extra as String;

          return BlocProvider(
            create: (context) =>
                AdventureCubit(AdventureRepo(ApiService()))..getDetails(id),
            child: const AdventureDetailsView(),
          );
        },
      ),
      GoRoute(
        path: '/adv_levels',
        builder: (context, state) {
          final id = state.extra as String?;

          return BlocProvider(
            create: (context) => AdventureCubit(AdventureRepo(ApiService())),
            child: LevelsScreen(id: id),
          );
        },
      ),
      GoRoute(
        path: '/intro_level',
        builder: (context, state) => IntroLevelView(),
      ),
      GoRoute(
        path: '/adv_voice_task',
        builder: (context, state) => AdvVoiceTaskView(),
      ),
      GoRoute(
        path: '/adv_image_task',
        builder: (context, state) => AdvImageTaskView(),
      ),
      GoRoute(
        path: '/adv_auto_task',
        builder: (context, state) => AdvAutoTaskView(),
      ),
      GoRoute(
        path: '/adv_celepration',
        builder: (context, state) => CeleprationView(),
      ),
    ],
  );
}
