import 'package:rewarding_kids/features/Parent_registar/data/childRequestModel.dart';
import 'package:rewarding_kids/features/Parent_registar/data/childmodel.dart';

class ChildRegistrationState {
  final String? name;
  final String? nickName;
  final String? gender;
  final int? age;
  final String? relation;
  final String? avatarPath;

  final bool isLoading;
  final ChildModel? child;
  final String? error;

  const ChildRegistrationState({
    this.name,
    this.nickName,
    this.gender,
    this.age,
    this.relation,
    this.avatarPath,
    this.isLoading = false,
    this.child,
    this.error,
  });

  // 🟣 Progress ديناميك
  double get progress {
    int step = 0;

    if (name != null) step++;
    if (gender != null) step++;
    if (age != null) step++;
    if (relation != null) step++;
    if (avatarPath != null) step++;

    return step / 5;
  }

  ChildRegistrationState copyWith({
    String? name,
    String? nickName,
    String? gender,
    int? age,
    String? relation,
    String? avatarPath,
    bool? isLoading,
    ChildModel? child,
    String? error,
  }) {
    return ChildRegistrationState(
      name: name ?? this.name,
      nickName: nickName ?? this.nickName,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      relation: relation ?? this.relation,
      avatarPath: avatarPath ?? this.avatarPath,
      isLoading: isLoading ?? this.isLoading,
      child: child ?? this.child,
      error: error,
    );
  }
}
