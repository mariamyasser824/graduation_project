import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewarding_kids/core/utils/pref_helper.dart';
import 'package:rewarding_kids/features/Parent_registar/data/childRequestModel.dart';
import 'package:rewarding_kids/features/Parent_registar/data/child_repository.dart';

import 'package:rewarding_kids/features/Parent_registar/data/childmodel.dart';

import 'child_state.dart';

class ChildRegistrationCubit extends Cubit<ChildRegistrationState> {
  final ChildRepository repository;

  ChildRegistrationCubit({required this.repository})
    : super(const ChildRegistrationState());

  // ---------- NAME ----------
  void setName(String name, String nick) {
    emit(state.copyWith(name: name, nickName: nick));
  }

  // ---------- GENDER ----------
  void setGender(String gender) {
    emit(state.copyWith(gender: gender));
  }

  // ---------- AGE ----------
  void setAge(int age) {
    emit(state.copyWith(age: age));
  }

  // ---------- RELATION ----------
  void setRelation(String relation) {
    emit(state.copyWith(relation: relation));
  }

  // ---------- AVATAR ----------
  void setAvatar(String path) {
    emit(state.copyWith(avatarPath: path));
  }

  // ---------- SUBMIT ----------
  Future<void> submit() async {
    if (state.name == null ||
        state.gender == null ||
        state.age == null ||
        state.relation == null ||
        state.avatarPath == null) {
      emit(state.copyWith(error: "Please complete all fields"));
      return;
    }

    emit(state.copyWith(isLoading: true, error: null));

    try {
      final request = ChildRequestModel(
        name: state.name!,
        nickName: state.nickName,
        age: state.age!,
        gender: state.gender!,
        relationship: state.relation!,
        avatarPath: state.avatarPath!,
      );

      final child = await repository.addChild(request);

      emit(state.copyWith(isLoading: false, child: child));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
