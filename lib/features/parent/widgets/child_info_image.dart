import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class ChildInfoImage extends StatefulWidget {
  const ChildInfoImage({super.key});

  @override
  State<ChildInfoImage> createState() => _ChildInfoImageState();
}

class _ChildInfoImageState extends State<ChildInfoImage> {
  final ImagePicker _picker = ImagePicker();

  File? _mobileImage;
  Uint8List? _webImage;

  Future<void> _pickImage() async {
    final XFile? pickedImage = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (pickedImage == null) return;

    if (kIsWeb) {
      final bytes = await pickedImage.readAsBytes();
      setState(() {
        _webImage = bytes;
      });
    } else {
      setState(() {
        _mobileImage = File(pickedImage.path);
      });
    }
  }

  ImageProvider _getImageProvider() {
    if (kIsWeb && _webImage != null) {
      return MemoryImage(_webImage!);
    } else if (!kIsWeb && _mobileImage != null) {
      return FileImage(_mobileImage!);
    } else {
      return const AssetImage('assets/child/girlavatar.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            width: 92.w,
            height: 92.w,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xff3F52B4), Color(0xffB22459)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: EdgeInsets.all(2.w),
            child: Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: _getImageProvider(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          GestureDetector(
            onTap: _pickImage,
            child: Container(
              width: 34.w,
              height: 34.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Icon(
                Icons.add_a_photo_outlined,
                size: 18.sp,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
