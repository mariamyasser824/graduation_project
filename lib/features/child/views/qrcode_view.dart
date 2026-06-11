import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:rewarding_kids/Shared/Custombutton.dart';
import 'package:rewarding_kids/features/auth/cubit/login_cubit.dart';
import 'package:rewarding_kids/features/auth/cubit/login_state.dart';

class QRScannerView extends StatefulWidget {
  const QRScannerView({super.key});

  @override
  State<QRScannerView> createState() => _QRScannerViewState();
}

class _QRScannerViewState extends State<QRScannerView> {
  bool _scanned = false;
  String? scannedCode;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        }

        if (state is LoginSuccess) {
          Navigator.of(context, rootNavigator: true).pop(); // اغلق الـ loader
          context.push('/Custombottomnav'); // واجهة الطفل
        }

        if (state is LoginError) {
          Navigator.of(context, rootNavigator: true).pop();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },

      child: Scaffold(
        body: Stack(
          children: [
            MobileScanner(
              onDetect: (capture) {
                if (_scanned) return;

                final barcode = capture.barcodes.first;
                final String? code = barcode.rawValue;

                if (code != null) {
                  setState(() {
                    scannedCode = code;
                    _scanned = true;
                  });
                }
              },
            ),

            /// إطار الاسكان
            const Center(child: _ScanFrame()),
            Align(
              alignment: AlignmentGeometry.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Custombutton(
                  onPressed: () {
                    // هنا نرسل الكود مباشرة للـ LoginCubit
                    context.read<LoginCubit>().login(
                      identifier: scannedCode!.trim(),
                      password: "",
                      loginAs: "Child",
                    );

                    // نروح على Home بعد النجاح
                  },
                  text: 'Link Child',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ScanFrame extends StatelessWidget {
  const _ScanFrame();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      height: 260,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white, width: 3),
      ),
    );
  }
}
