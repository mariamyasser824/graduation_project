import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rewarding_kids/core/constants/routes.dart';
import 'package:rewarding_kids/core/network/api_service.dart';
import 'package:rewarding_kids/core/network/dio_client.dart';
import 'package:rewarding_kids/features/Parent_registar/cubit/child_cubit.dart';
import 'package:rewarding_kids/features/Parent_registar/data/childService.dart';
import 'package:rewarding_kids/features/Parent_registar/data/child_repository.dart';
import 'package:rewarding_kids/features/adventures/cubits/adventure_cubit/adventure_cubit.dart';
import 'package:rewarding_kids/features/adventures/repos/adventure_repo.dart';
import 'package:rewarding_kids/features/auth/cubit/forget_password_cubit.dart';
import 'package:rewarding_kids/features/auth/cubit/login_cubit.dart';
import 'package:rewarding_kids/features/auth/cubit/otpcubit.dart';
import 'package:rewarding_kids/features/auth/cubit/reset_password_cubit.dart';
import 'package:rewarding_kids/features/auth/cubit/signup_cubit.dart';
import 'package:rewarding_kids/features/child/cubit/SubmitTaskCubit.dart';
import 'package:rewarding_kids/features/child/cubit/tasks_cubit.dart';
import 'package:rewarding_kids/features/child/data/repos/SubmitTaskRepo.dart';
import 'package:rewarding_kids/features/child/data/repos/points_repo.dart';
import 'package:rewarding_kids/features/child/data/repos/tasks_repo.dart';
import 'package:rewarding_kids/features/parent/cubit/layout_cubit/layout_cubit.dart';
import 'package:rewarding_kids/features/parent/cubit/reward_cubit/reward_cubit.dart';
import 'package:rewarding_kids/features/parent/cubit/statistics_cubit/statistics_cubit.dart';
import 'package:rewarding_kids/features/parent/repos/Reward_repo.dart';
import 'package:rewarding_kids/features/parent/repos/statistics_repo.dart';
import 'features/child/cubit/progress_cubit.dart';

//32J79U
final GlobalKey<NavigatorState> rootNavKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => StatisticsCubit(StatisticsRepo(ApiService())),
        ),
        BlocProvider(create: (_) => LayoutCubit()),
        BlocProvider(create: (_) => SignupCubit()),
        BlocProvider(create: (_) => OtpCubit()),
        BlocProvider(create: (_) => LoginCubit()),
        // BlocProvider(create: (_) => ForgetPasswordCubit()),
        BlocProvider(create: (_) => ForgetPasswordCubit()),
        BlocProvider(create: (_) => ResetPasswordCubit()),

        BlocProvider(
          create: (_) => ChildRegistrationCubit(
            repository: ChildRepository(service: ChildService()),
          ),
        ),
        BlocProvider(
          create: (context) => ProgressCubit(PointsRepo())..fetchPoints(),
        ),
        BlocProvider(
          create: (_) => RewardCubit(RewardRepository(DioClient().dio)),
        ),
        BlocProvider(
          create: (context) =>
              AdventureCubit(AdventureRepo(ApiService()))..getAdventures(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Rewarding Kids System',
          routerConfig: AppRouter.router,
          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: TextScaler.noScaling),
              child: widget!,
            );
          },
        );
      },
    );
  }
}
