import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/onboarding/widgets/popbutton.dart';
import 'package:rewarding_kids/features/parent/cubit/reward_cubit/reward_cubit.dart';
import 'package:rewarding_kids/features/parent/cubit/reward_cubit/reward_state.dart';
import 'package:rewarding_kids/features/parent/widgets/AddImagesCard.dart';
import 'package:rewarding_kids/features/parent/widgets/GiftSuccessDialog.dart';
import 'package:rewarding_kids/features/parent/widgets/addgift_textfomfiled.dart';
import 'package:rewarding_kids/features/parent/widgets/addgiftbuttuns.dart';

class AddGiftBody extends StatefulWidget {
  const AddGiftBody({super.key});

  @override
  State<AddGiftBody> createState() => _AddGiftBodyState();
}

class _AddGiftBodyState extends State<AddGiftBody> {
  late TextEditingController giftNameController;
  late TextEditingController targetController;
  late TextEditingController detailsController;

  List<XFile> selectedImages = [];

  @override
  void initState() {
    super.initState();
    giftNameController = TextEditingController();
    targetController = TextEditingController();
    detailsController = TextEditingController();
  }

  @override
  void dispose() {
    giftNameController.dispose();
    targetController.dispose();
    detailsController.dispose();
    super.dispose();
  }

  Future<List<MultipartFile>> prepareImages() async {
    List<MultipartFile> files = [];

    for (var img in selectedImages) {
      final bytes = await img.readAsBytes();
      files.add(MultipartFile.fromBytes(bytes, filename: img.name));
    }

    return files;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RewardCubit, RewardState>(
      listener: (context, state) {
        if (state is RewardSuccess) {
          showDialog(
            context: context,
            builder: (_) =>
                GiftSuccessDialog(text: 'Perfect! Gift Added Successfully'),
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        child: Column(
          children: [
            Row(
              children: [
                Popbutton(
                  onPressed: () {
                    context.pop();
                  },
                ),
              ],
            ),

            SizedBox(height: 20.h),

            CustomText(
              text: 'Add New Gift',
              iscenter: true,
              size: 20.sp,
              weight: FontWeight.w500,
              color: AppColors.titleColor,
            ),

            SizedBox(height: 30.h),

            AddgiftTextfomfiled(
              hint: 'New toy',
              controller: giftNameController,
              label: 'Gift Name',
              isPassword: false,
              wicon: SvgPicture.asset(
                fit: BoxFit.contain,
                'assets/icons/gifts.svg',
                color: Color(0xffB7B7B7),
              ),
            ),

            SizedBox(height: 10.h),

            AddgiftTextfomfiled(
              hint: '50',
              controller: targetController,
              label: 'Target',
              isPassword: false,
              wicon: SvgPicture.asset(
                'assets/icons/target.svg',
                fit: BoxFit.contain,
                color: Color(0xffB7B7B7),
              ),
            ),

            SizedBox(height: 10.h),

            AddgiftTextfomfiled(
              hint: 'Gift details',
              controller: detailsController,
              label: 'Description',
              isPassword: false,
              wicon: SvgPicture.asset(
                'assets/icons/gift_details.svg',
                fit: BoxFit.contain,
                color: Color(0xffB7B7B7),
              ),
            ),

            AddImagesCard(
              onImagesChanged: (imgs) {
                setState(() {
                  selectedImages = imgs;
                });
              },
            ),

            SizedBox(height: 20.h),

            Addgiftbuttuns(
              onApprove: () async {
                final formData = FormData();

                /// 📌 fields
                formData.fields.addAll([
                  MapEntry("NameEn", giftNameController.text),
                  MapEntry("NameAr", giftNameController.text),
                  MapEntry("DescriptionEn", detailsController.text),
                  MapEntry("DescriptionAr", detailsController.text),
                  MapEntry("TargetPoints", targetController.text),
                  MapEntry("ChildId", "043cc39f-9bf0-41a2-83b4-219443e3f834"),
                ]);

                if (selectedImages.isNotEmpty) {
                  final bytes = await selectedImages.first.readAsBytes();

                  formData.files.add(
                    MapEntry(
                      "Image",
                      MultipartFile.fromBytes(
                        bytes,
                        filename: selectedImages.first.name,
                      ),
                    ),
                  );
                }

                await context.read<RewardCubit>().createReward(formData);
              },
              onReject: () {
                if (context.canPop()) {
                  context.pop();
                } else {
                  context.push('/Layout');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
