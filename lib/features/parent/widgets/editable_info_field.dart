import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditableInfoField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final bool savePressed; // دي بنرسلها لما نضغط Save في الصفحة

  const EditableInfoField({
    super.key,
    required this.label,
    required this.controller,
    this.savePressed = false,
  });

  @override
  State<EditableInfoField> createState() => _EditableInfoFieldState();
}

class _EditableInfoFieldState extends State<EditableInfoField> {
  bool _isFocused = false;
  final FocusNode _focusNode = FocusNode();
  bool _saved = false;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void didUpdateWidget(covariant EditableInfoField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.savePressed && !_saved) {
      setState(() {
        _saved = true; // لما نضغط Save من الصفحة
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Color borderColor;
    Color textColor;
    if (_isFocused) {
      borderColor = Color(0xff984CFB);
      textColor = Color(0xff984CFB);
      // Focus color
    } else if (_saved) {
      borderColor = Color(0xff008917);
      textColor = Color(0xff008917);
      // Saved color
    } else {
      borderColor = Color(0xffD9D9D9);
      textColor = Color(0xff6B7280);
      // Default
    }

    return Container(
      height: 65.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xffFAF8FB),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: borderColor, width: 0.75),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            widget.label,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: textColor,
            ),
          ),

          TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}
