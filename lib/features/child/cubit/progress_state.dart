import 'package:equatable/equatable.dart';

enum ProgressStatus { initial, loading, success, error }

class ProgressState extends Equatable {
  final int totalPoints;
  final int goalPoints;
  final bool showCelebration;
  final ProgressStatus status;
  final String? errorMessage;

  const ProgressState({
    required this.totalPoints,
    required this.goalPoints,
    required this.showCelebration,
    required this.status,
    this.errorMessage,
  });

  ProgressState copyWith({
    int? totalPoints,
    int? goalPoints,
    bool? showCelebration,
    ProgressStatus? status,
    String? errorMessage,
  }) {
    return ProgressState(
      totalPoints: totalPoints ?? this.totalPoints,
      goalPoints: goalPoints ?? this.goalPoints,
      showCelebration: showCelebration ?? this.showCelebration,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    totalPoints,
    goalPoints,
    showCelebration,
    status,
    errorMessage,
  ];
}
