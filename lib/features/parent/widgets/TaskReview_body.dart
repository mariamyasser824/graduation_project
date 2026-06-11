import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:rewarding_kids/Shared/CustomText.dart';
import 'package:rewarding_kids/core/constants/app_colors.dart';
import 'package:rewarding_kids/features/parent/cubit/tasks_cubit/task_review_cubit.dart';
import 'package:rewarding_kids/features/parent/models/child_task_model.dart';
import 'package:rewarding_kids/features/parent/widgets/TaskInfoCard.dart';
import 'package:rewarding_kids/features/parent/widgets/approvingbuttuns.dart';
import 'package:rewarding_kids/features/parent/widgets/notes_from_child.dart';
import 'package:rewarding_kids/features/parent/widgets/notes_to_child.dart';
import 'package:rewarding_kids/features/parent/widgets/rejectSection.dart';
import 'package:rewarding_kids/features/parent/widgets/rejection_buttuns.dart';
import 'package:rewarding_kids/features/parent/widgets/task_images_card.dart';
import 'package:rewarding_kids/features/parent/widgets/task_review_header.dart';
import 'review_state.dart';

class TaskreviewBody extends StatefulWidget {
  const TaskreviewBody({super.key, required this.taskId});
  final String taskId;

  @override
  State<TaskreviewBody> createState() => _TaskreviewBodyState();
}

class _TaskreviewBodyState extends State<TaskreviewBody> {
  ReviewState reviewState = ReviewState.initial;

  final TextEditingController noteController = TextEditingController();
  final TextEditingController rejectReasonController = TextEditingController();

  /// ❌ Reject
  Future<void> confirmRejection(ChildTask task) async {
    context.read<TaskReviewCubit>().reviewTask(
      childTaskId: task.childTaskId,
      isApproved: false,
      rejectionReason: rejectReasonController.text,
    );
  }

  void cancelRejection() {
    setState(() {
      reviewState = ReviewState.initial;
    });
  }

  /// ✅ Approve
  Future<void> onApprovePressed(ChildTask task) async {
    context.read<TaskReviewCubit>().reviewTask(
      childTaskId: task.childTaskId,
      isApproved: true,
      acceptanceMessage: noteController.text,
    );
  }

  void onRejectPressed() {
    setState(() {
      reviewState = ReviewState.rejecting;
    });
  }

  /// 🔥 Actions UI
  Widget buildActionSection(ChildTask task) {
    switch (reviewState) {
      case ReviewState.initial:
        return ApprovingButtons(
          onApprove: () => onApprovePressed(task),
          onReject: onRejectPressed,
        );

      case ReviewState.approving:
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Container(
            width: double.infinity,
            height: 50.h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xff00C953), Color(0xff00BC7A)],
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: CustomText(
                text: 'Approving...',
                size: 14.sp,
                color: const Color(0xffFAF8FB),
                weight: FontWeight.w500,
                iscenter: true,
              ),
            ),
          ),
        );

      case ReviewState.rejecting:
        return rejectSection(task);

      case ReviewState.rejected:
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Container(
            width: double.infinity,
            height: 50.h,
            decoration: BoxDecoration(
              color: Color(0xffEA514C),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: CustomText(
                text: 'Rejected',
                size: 14.sp,
                color: const Color(0xffFAF8FB),
                weight: FontWeight.w500,
                iscenter: true,
              ),
            ),
          ),
        );
    }
  }

  /// ❌ Reject Section FIXED
  Widget rejectSection(ChildTask task) {
    return Column(
      children: [
        Rejectsectioncard(rejectReasonController: rejectReasonController),
        SizedBox(height: 8.h),
        RejectionButtuns(
          cancel: cancelRejection,
          confirmRejection: () => confirmRejection(task),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<TaskReviewCubit>().getTaskDetails(widget.taskId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TaskReviewCubit, TaskReviewState>(
      listener: (context, state) async {
        /// ✅ Approved
        if (state is TaskApproved) {
          final currentState = context.read<TaskReviewCubit>().state;

          ChildTask? task;

          if (currentState is TaskReviewLoaded) {
            task = currentState.task;
          }

          await showDialog(
            context: context,
            builder: (_) => AlertDialog(
              actions: [
                SizedBox(
                  height: 200.h,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 64.w,
                          height: 64.h,
                          child: Image.asset('assets/child/coins.png'),
                        ),
                        SizedBox(height: 10.h),
                        CustomText(
                          text:
                              "Task Approved! ${task?.points ?? 0} points added 🎉",
                          iscenter: true,
                          size: 14.sp,
                          color: Color(0xff394A59),
                          weight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );

          Navigator.pop(context, true);
        }

        /// ❌ Rejected
        if (state is TaskRejected) {
          await showDialog(
            context: context,
            builder: (_) => AlertDialog(
              actions: [
                SizedBox(
                  height: 200.h,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 64.w,
                          height: 64.h,
                          child: SvgPicture.asset('assets/icons/regected.svg'),
                        ),
                        SizedBox(height: 8.h),
                        CustomText(
                          text: "Task Rejected!",
                          iscenter: true,
                          size: 14.sp,
                          color: Color(0xff394A59),
                          weight: FontWeight.w500,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );

          Navigator.pop(context, true);
        }

        /// ❗ Error
        if (state is TaskReviewError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },

      /// 🔥 UI
      child: BlocBuilder<TaskReviewCubit, TaskReviewState>(
        builder: (context, state) {
          if (state is TaskReviewLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TaskReviewError) {
            return Center(child: Text(state.message));
          }

          if (state is TaskReviewLoaded) {
            final task = state.task;

            return SingleChildScrollView(
              child: Column(
                children: [
                  const TaskReviewHeader(),
                  SizedBox(height: 10.h),

                  Taskinfocard(task: task),

                  TaskImagesCard(imageUrl: task.answerMediaUrl),

                  SizedBox(height: 10.h),

                  NotesFromChild(
                    note: task.childNote?.trim() ?? 'Mom, I finished it!',
                  ),

                  SizedBox(height: 10.h),

                  NotesToChild(controller: noteController),

                  SizedBox(height: 20.h),

                  buildActionSection(task),

                  SizedBox(height: 20.h),
                ],
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
/*
GET
/api/ParentTask
Gets all tasks assigned by the parent to their child(ren), with optional filters


Filter by status (Pending, InProgress(Child click on start), ReviewRequested, Completed, Rejected)
Search by task title
Pagination and sorting supported
If no childId provided, returns tasks for all linked children
Parameters
Cancel
Name	Description
Status
string
(query)
Optional: Filter by specific status (null = all statuses)


ReviewRequested
PageNumber
integer($int32)
(query)
PageNumber
PageSize
integer($int32)
(query)
PageSize
SortColumn
string
(query)

--
SortDirection
string
(query)

--
Execute
Clear
Responses
Curl

curl -X 'GET' \
  'https://go-kid.runasp.net/api/ParentTask?Status=ReviewRequested' \
  -H 'accept: 
  -H 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1laWQiOiI0NzFhZDQxYS04NzViLTRmOGItYjZhZS03YzAwNmY4ZWVmZDgiLCJlbWFpbCI6ImVubXJteTEyOTIwMDRAZ21haWwuY29tIiwiZ2l2ZW5fbmFtZSI6ImVubXJteTEyOTIwMDRAZ21haWwuY29tIiwicm9sZSI6IlBhcmVudCIsIm5iZiI6MTc3NjI4NjM4NywiZXhwIjoxNzc2ODkxMTg3LCJpYXQiOjE3NzYyODYzODcsImlzcyI6Imh0dHBzOi8vbG9jYWxob3N0OjcyMDQiLCJhdWQiOiJodHRwczovL2xvY2FsaG9zdDo3MjA0In0.7ZlkR1ku0yjaY8LPtXny5_z_9Mp9BJBGu3gjHh8g300'
Request URL
https://go-kid.runasp.net/api/ParentTask?Status=ReviewRequested
Server response
Code	Details
200	
Response body
Download
{
  "statusCode": "OK",
  "succeeded": true,
  "message": "Child tasks retrieved successfully",
  "errors": null,
  "data": {
    "items": [
      {
        "childTaskId": "25e640e3-c01e-4d79-8065-260a87c32456",
        "childId": "4dcd6d1e-287f-4216-a8c2-e8842b848488",
        "childName": "hamza",
        "taskTemplateId": "0cd99f64-b836-4ff8-9827-6d6cf54d427e",
        "titleAr": "اميره ",
        "titleEn": "amira",
        "categoryNameAr": "الإبداع والمهارات",
        "categoryNameEn": "Creativity & Skills",
        "subCategoryNameAr": "تلوين",
        "subCategoryNameEn": "Coloring",
        "difficulty": "Medium",
        "iconUrl": null,
        "points": 30,
        "status": "ReviewRequested",
        "assignedAt": "2026-03-14T00:00:00",
        "dueDate": null,
        "completedAt": null,
        "reviewRequestedAt": "2026-03-14T12:24:13.8471695",
        "rejectionReason": null,
        "evidenceUrl": "https://res.cloudinary.com/dhnlpsrf4/image/upload/v1773491053/ldxhnl7zyvy50z1b1z3s.jpg"
      },
      {
        "childTaskId": "2b7bef1f-af65-4f43-ab51-b5e964c6d170",
        "childId": "4dcd6d1e-287f-4216-a8c2-e8842b848488",
        "childName": "hamza",
        "taskTemplateId": "0cd99f64-b836-4ff8-9827-6d6cf54d427e",
        "titleAr": "اميره ",
        "titleEn": "amira",
        "categoryNameAr": "الإبداع والمهارات",
        "categoryNameEn": "Creativity & Skills",
        "subCategoryNameAr": "تلوين",
        "subCategoryNameEn": "Coloring",
        "difficulty": "Medium",
        "iconUrl": null,
        "points": 30,
        "status": "ReviewRequested",
        "assignedAt": "2026-03-13T00:00:00",
        "dueDate": null,
        "completedAt": null,
        "reviewRequestedAt": "2026-03-13T20:11:32.7526934",
        "rejectionReason": null,
        "evidenceUrl": "https://res.cloudinary.com/dhnlpsrf4/image/upload/v1773432692/vypio8mc8sgx8cwxpz1i.jpg"
      },
      {
        "childTaskId": "456588c3-7ffb-4b0c-8624-1877eb80e890",
        "childId": "4dcd6d1e-287f-4216-a8c2-e8842b848488",
        "childName": "hamza",
        "taskTemplateId": "8e86de45-2bed-4bcb-9f81-627f4d74d037",
        "titleAr": "نظف غرفتك ",
        "titleEn": "clean your room",
        "categoryNameAr": "المهام الدراسية",
        "categoryNameEn": "Academic Tasks",
        "subCategoryNameAr": "واجبات مدرسية",
        "subCategoryNameEn": "Homework",
        "difficulty": "Easy",
        "iconUrl": null,
        "points": 10,
        "status": "ReviewRequested",
        "assignedAt": "2026-03-14T00:00:00",
        "dueDate": null,
        "completedAt": null,
        "reviewRequestedAt": "2026-03-14T22:15:31.3390536",
        "rejectionReason": null,
        "evidenceUrl": "https://res.cloudinary.com/dhnlpsrf4/image/upload/v1773526530/ylfu4h60fpciygxsbfh0.jpg"
      },
      {
        "childTaskId": "67347eef-4938-4d46-86eb-a4cb56225530",
        "childId": "4dcd6d1e-287f-4216-a8c2-e8842b848488",
        "childName": "hamza",
        "taskTemplateId": "8e86de45-2bed-4bcb-9f81-627f4d74d037",
        "titleAr": "نظف غرفتك ",
        "titleEn": "clean your room",
        "categoryNameAr": "المهام الدراسية",
        "categoryNameEn": "Academic Tasks",
        "subCategoryNameAr": "واجبات مدرسية",
        "subCategoryNameEn": "Homework",
        "difficulty": "Easy",
        "iconUrl": null,
        "points": 10,
        "status": "ReviewRequested",
        "assignedAt": "2026-03-11T00:00:00",
        "dueDate": null,
        "completedAt": null,
        "reviewRequestedAt": "2026-03-11T21:53:59.3346055",
        "rejectionReason": null,
        "evidenceUrl": "https://res.cloudinary.com/dhnlpsrf4/image/upload/v1773266038/gqsn0glpintg5q82nawr.jpg"
      },
      {
        "childTaskId": "98e048a7-3526-42ea-9b3c-a63c0fa629ca",
        "childId": "4dcd6d1e-287f-4216-a8c2-e8842b848488",
        "childName": "hamza",
        "taskTemplateId": "6e4b6c65-500e-4d3e-b314-8260b66b411f",
        "titleAr": "string",
        "titleEn": "string",
        "categoryNameAr": "السلوك وتحمل المسؤولية",
        "categoryNameEn": "Behavior & Responsibility",
        "subCategoryNameAr": "روتين النوم",
        "subCategoryNameEn": "Bedtime Routine",
        "difficulty": "Easy",
        "iconUrl": "https://res.cloudinary.com/dhnlpsrf4/image/upload/v1769344009/qqxbvv6wrtx0nxt1hwme.jpg",
        "points": 8,
        "status": "ReviewRequested",
        "assignedAt": "2026-03-26T00:00:00",
        "dueDate": null,
        "completedAt": null,
        "reviewRequestedAt": "2026-03-26T18:56:26.7747542",
        "rejectionReason": null,
        "evidenceUrl": "https://res.cloudinary.com/dhnlpsrf4/image/upload/v1774551385/bnxcx9qcu42vxhbiufxb.jpg"
      },
      {
        "childTaskId": "c1f52b3a-7c4a-44f1-bb0f-b97b081a591f",
        "childId": "4dcd6d1e-287f-4216-a8c2-e8842b848488",
        "childName": "hamza",
        "taskTemplateId": "8e86de45-2bed-4bcb-9f81-627f4d74d037",
        "titleAr": "نظف غرفتك ",
        "titleEn": "clean your room",
        "categoryNameAr": "المهام الدراسية",
        "categoryNameEn": "Academic Tasks",
        "subCategoryNameAr": "واجبات مدرسية",
        "subCategoryNameEn": "Homework",
        "difficulty": "Easy",
        "iconUrl": null,
        "points": 10,
        "status": "ReviewRequested",
        "assignedAt": "2026-03-30T00:00:00",
        "dueDate": null,
        "completedAt": null,
        "reviewRequestedAt": "2026-03-30T10:09:30.7933284",
        "rejectionReason": null,
        "evidenceUrl": "https://res.cloudinary.com/dhnlpsrf4/image/upload/v1774865370/pc1jfoiqwuibhkuee2qe.jpg"
      },
      {
        "childTaskId": "dbed57c7-f791-4a43-b113-a020e9f7eeff",
        "childId": "5d807e7b-aef6-4915-96e4-11e6f0c53d22",
        "childName": "roqaia",
        "taskTemplateId": "0cd99f64-b836-4ff8-9827-6d6cf54d427e",
        "titleAr": "اميره ",
        "titleEn": "amira",
        "categoryNameAr": "الإبداع والمهارات",
        "categoryNameEn": "Creativity & Skills",
        "subCategoryNameAr": "تلوين",
        "subCategoryNameEn": "Coloring",
        "difficulty": "Medium",
        "iconUrl": null,
        "points": 30,
        "status": "ReviewRequested",
        "assignedAt": "2026-04-02T00:00:00",
        "dueDate": null,
        "completedAt": null,
        "reviewRequestedAt": "2026-04-02T04:40:23.3879161",
        "rejectionReason": null,
        "evidenceUrl": "https://res.cloudinary.com/dhnlpsrf4/image/upload/v1775104822/h694tdvywxwnygximx83.jpg"
      }
    ],
    "pageNumber": 1,
    "totalCount": 7,
    "totalPages": 1,
    "hasPreviousPage": false,
    "hasNextPage": false   
 */