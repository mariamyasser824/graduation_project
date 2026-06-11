import 'dart:io';
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';

class AddImagesCard extends StatefulWidget {
  const AddImagesCard({super.key, required this.onImagesChanged});

  final Function(List<XFile>) onImagesChanged;

  @override
  State<AddImagesCard> createState() => _AddImagesCardState();
}

class _AddImagesCardState extends State<AddImagesCard> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile> images = [];

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 70,
    );

    if (image != null) {
      setState(() {
        images.add(image);
        widget.onImagesChanged(images);
      });
    }
  }

  void removeImage(int index) {
    setState(() {
      images.removeAt(index);
      widget.onImagesChanged(images);
    });
  }

  Widget buildImage(XFile file) {
    if (kIsWeb) {
      return FutureBuilder<Uint8List>(
        future: file.readAsBytes(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(color: Colors.grey.shade200);
          }
          return Image.memory(snapshot.data!, fit: BoxFit.cover);
        },
      );
    } else {
      return Image.file(File(file.path), fit: BoxFit.cover);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: 'Add image of picture',
            iscenter: false,
            size: 16.sp,
            weight: FontWeight.w500,
            color: AppColors.titleColor,
          ),
          SizedBox(height: 8.h),

          DottedBorder(
            options: RoundedRectDottedBorderOptions(
              radius: Radius.circular(12.r),
              color: const Color(0xffE5E5E5),
              strokeWidth: 2,
              dashPattern: const [6, 4],
            ),
            child: Container(
              height: 160.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: Colors.white,
              ),
              child: images.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: pickImage,
                            child: SvgPicture.asset(
                              'assets/icons/add image.svg',
                              width: 48.w,
                              height: 48.h,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          CustomText(
                            text: 'Click to upload',
                            iscenter: true,
                            size: 12.sp,
                            weight: FontWeight.w600,
                            color: const Color(0xffC783D4),
                          ),
                          CustomText(
                            text: 'JPG, JPEG, PNG less than 1MB',
                            iscenter: true,
                            size: 11.sp,
                            weight: FontWeight.w400,
                            color: const Color(0xffA3A3A3),
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: EdgeInsets.all(12.w),
                      child: Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: [
                          ...List.generate(images.length, (index) {
                            return Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8.r),
                                  child: Container(
                                    width: 90.w,
                                    height: 80.h,
                                    color: Colors.grey.shade200,
                                    child: buildImage(images[index]),
                                  ),
                                ),
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: GestureDetector(
                                    onTap: () => removeImage(index),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        color: Colors.black54,
                                        shape: BoxShape.circle,
                                      ),
                                      padding: const EdgeInsets.all(4),
                                      child: const Icon(
                                        Icons.close,
                                        size: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),

                          GestureDetector(
                            onTap: pickImage,
                            child: Container(
                              width: 90.w,
                              height: 80.h,
                              decoration: BoxDecoration(
                                color: const Color(0xffF5F5F5),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: const Icon(Icons.add, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
