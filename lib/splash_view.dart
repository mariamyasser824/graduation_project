import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/core/utils/pref_helper.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> with TickerProviderStateMixin {
  late AnimationController _phase1Controller;
  late AnimationController _phase2Controller;
  late AnimationController _phase3Controller;
  late AnimationController _phase4Controller;

  late Animation<double> _logoFade;
  late Animation<double> _textFadeIn;
  late Animation<double> _textSlideUp;
  late Animation<double> _textFadeOut;
  late Animation<double> _logoRotation;
  late Animation<double> _logoSize;
  late Animation<double> _logoMoveX;
  late Animation<double> _finalTextSlide;
  late Animation<double> _finalTextFade;

  @override
  void initState() {
    super.initState();

    // المرحلة 1: اللوجو والنص يظهروا - 900ms
    _phase1Controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _logoFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _phase1Controller, curve: Curves.easeOut),
    );
    _textFadeIn = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _phase1Controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOut),
      ),
    );

    // المرحلة 2: النص يطلع لفوق ويختفي - 650ms
    _phase2Controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );
    _textSlideUp = Tween<double>(
      begin: 0,
      end: -55,
    ).animate(CurvedAnimation(parent: _phase2Controller, curve: Curves.easeIn));
    _textFadeOut = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _phase2Controller,
        curve: const Interval(0.0, 0.75, curve: Curves.easeIn),
      ),
    );

    // المرحلة 3: اللوجو يلف ويصغر - 1000ms
    _phase3Controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _logoRotation = Tween<double>(begin: 0, end: 2 * 3.14159).animate(
      CurvedAnimation(parent: _phase3Controller, curve: Curves.easeInOut),
    );
    _logoSize = Tween<double>(begin: 144, end: 82).animate(
      CurvedAnimation(parent: _phase3Controller, curve: Curves.easeInOut),
    );

    // المرحلة 4: اللوجو يتحرك شمال والنص يظهر - 800ms
    _phase4Controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _logoMoveX = Tween<double>(begin: 0, end: -52).animate(
      CurvedAnimation(parent: _phase4Controller, curve: Curves.easeOut),
    );
    _finalTextSlide = Tween<double>(begin: 80, end: 0).animate(
      CurvedAnimation(parent: _phase4Controller, curve: Curves.easeOut),
    );
    _finalTextFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _phase4Controller,
        curve: const Interval(0.0, 0.8, curve: Curves.easeIn),
      ),
    );

    _runAnimations();
  }

  void _runAnimations() async {
    await _phase1Controller.forward();
    await Future.delayed(const Duration(milliseconds: 700));
    await _phase2Controller.forward();
    await Future.delayed(const Duration(milliseconds: 100));
    await _phase3Controller.forward();
    await Future.delayed(const Duration(milliseconds: 50));
    await _phase4Controller.forward();
    await Future.delayed(const Duration(milliseconds: 1000));
    _navigate();
  }

  void _navigate() async {
    if (!mounted) return;
    final seenOnboarding = await PrefHelper.getOnBoardingSeen();
    final token = await PrefHelper.getAccessToken();
    final userType = await PrefHelper.getUserType();

    if (!seenOnboarding) {
      context.push('/onboarding');
      return;
    }
    if (token != null && token.isNotEmpty) {
      if (userType == "Child") {
        context.go('/Custombottomnav');
        return;
      }
      final childId = await PrefHelper.getChildId();
      if (childId != null && childId.isNotEmpty) {
        context.go('/Layout');
      } else {
        context.push('/getstarted');
      }
    } else {
      context.push('/getstarted');
    }
  }

  @override
  void dispose() {
    _phase1Controller.dispose();
    _phase2Controller.dispose();
    _phase3Controller.dispose();
    _phase4Controller.dispose();
    super.dispose();
  }

  Widget _gradientText(double fontSize) {
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFA178F1), Color(0xFFA090BE)],
      ).createShader(bounds),
      child: Text(
        'GOKID',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: fontSize.sp,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          height: 1.5,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.Background,
      body: AnimatedBuilder(
        animation: Listenable.merge([
          _phase1Controller,
          _phase2Controller,
          _phase3Controller,
          _phase4Controller,
        ]),
        builder: (context, _) {
          final logoSize = _logoSize.value.w;
          final firstTextOpacity = (_textFadeIn.value * _textFadeOut.value)
              .clamp(0.0, 1.0);

          // حساب مكان اللوجو:
          // في الأول: في المنتص (screenWidth/2 - logoSize/2)
          // في الآخر: يتحرك شمال عشان يبقى جنب النص
          final logoLeft =
              (screenWidth / 2 - logoSize / 2) +
              (_logoMoveX.value * _phase4Controller.value).w;

          return Stack(
            children: [
              // ===== النص الأول تحت اللوجو =====
              Positioned(
                left: 0,
                right: 0,
                top:
                    MediaQuery.of(context).size.height / 2 +
                    72.w + // نص تحت اللوجو (144/2 + gap)
                    _textSlideUp.value.h,
                child: Opacity(
                  opacity: firstTextOpacity,
                  child: Center(child: _gradientText(32)),
                ),
              ),

              // ===== اللوجو =====
              Positioned(
                left: logoLeft,
                top: MediaQuery.of(context).size.height / 2 - logoSize / 2,
                child: Opacity(
                  opacity: _logoFade.value,
                  child: Transform.rotate(
                    angle: _logoRotation.value,
                    child: Image.asset(
                      'assets/icons/Gokid_logo.png',
                      width: logoSize,
                      height: logoSize,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              // ===== النص النهائي من اليمين =====
              Positioned(
                // يظهر على يمين اللوجو لما يصغر
                left: logoLeft + logoSize + _finalTextSlide.value.w,
                top: MediaQuery.of(context).size.height / 2 - 24.h,
                child: Opacity(
                  opacity: _finalTextFade.value,
                  child: _gradientText(32),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
