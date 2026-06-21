import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rewarding_kids/Shared/Custombutton.dart';
import 'package:rewarding_kids/features/child/cubit/SubmitTaskCubit.dart';
import 'package:rewarding_kids/features/child/data/models/task_model.dart';

class Uploadimage extends StatefulWidget {
  const Uploadimage({
    super.key,
    required this.Taskdetails,
    required this.imagePath,
    required this.type,
    this.adventureTaskId,
    this.weeklyAdventureId,
  });
  final SubmitType type;
  final dynamic Taskdetails;
  final String? imagePath;

  final String? adventureTaskId;
  final String? weeklyAdventureId;

  @override
  State<Uploadimage> createState() => _UploadimageState();
}

class _UploadimageState extends State<Uploadimage> {
  final ImagePicker _picker = ImagePicker();
  File? _image;

  @override
  void initState() {
    super.initState();
    if (widget.imagePath != null) {
      _image = File(widget.imagePath!);
    }
  }

  /// إعادة التصوير
  Future<void> retakePicture() async {
    final XFile? pickedImage = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 70,
    );

    if (pickedImage == null) return;

    setState(() {
      _image = File(pickedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.65,

            decoration: BoxDecoration(color: const Color(0xff3E3E3E)),
            child: Stack(
              // alignment: Alignment.center,
              children: [
                if (_image != null)
                  Image.file(
                    _image!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.maxFinite,
                  )
                else
                  const Text(
                    'No image selected',
                    style: TextStyle(color: Colors.white),
                  ),

                /// زر إعادة التصوير
                Center(
                  child: GestureDetector(
                    onTap: retakePicture,
                    child: Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                      ),
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: Colors.white,
                        size: 30.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Spacer(),

        /// Upload
        Custombutton(
          onPressed: _image == null
              ? null
              : () {
                  context.push(
                    '/pending',
                    extra: {
                      'task': widget.Taskdetails,
                      'image_path': _image!.path,
                      'type': widget.type,
                      'adventureTaskId': widget.adventureTaskId,
                      'weeklyAdventureId': widget.weeklyAdventureId, // 🔥
                    },
                  );
                },
          text: "Upload a photo",
        ),
      ],
    );
  }
}
