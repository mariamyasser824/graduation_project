import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewarding_kids/features/adventures/cubits/adventure_cubit/adventure_state.dart';
import 'package:rewarding_kids/features/adventures/models/adv_task_model.dart';
import 'package:rewarding_kids/features/adventures/repos/adventure_repo.dart';

class AdventureCubit extends Cubit<AdventureState> {
  final AdventureRepo repo;

  AdventureCubit(this.repo) : super(AdventureInitial());

  /// 🔥 Load Adventures
  Future<void> getAdventures() async {
    emit(AdventureLoading());

    try {
      final data = await repo.getAdventures();
      emit(AdventureSuccess(data));
    } catch (e) {
      emit(AdventureError(e.toString()));
    }
  }

  /// 🔥 Load Details
  Future<void> getDetails(String id) async {
    emit(AdventureDetailsLoading());

    try {
      final data = await repo.getAdventureDetails(id);
      emit(AdventureDetailsSuccess(data));
    } catch (e) {
      emit(AdventureDetailsError(e.toString()));
    }
  }
   Future<void> submitTask({
  required AdvTaskModel task,
  File? voiceFile,
  File? imageFile,
}) async {
  try {
    await repo.submitTask(
      adventureTaskId: task.adventureTaskId,
      weeklyAdventureId: task.weeklyAdventureId,
      voiceFile: voiceFile,
      imageFile: imageFile,
    );

    print("Submitted ✅");
  } catch (e) {
    print("Error: $e");
  }
}
}
