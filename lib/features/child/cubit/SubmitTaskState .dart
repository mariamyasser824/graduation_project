import 'package:rewarding_kids/features/child/data/models/SubmitTaskResponseModel.dart';

enum SubmitStatus { initial, loading, success, error }

class SubmitTaskState {
  final SubmitStatus status;
  final SubmitTaskResponse? response;
  final String? error;

  const SubmitTaskState({
    this.status = SubmitStatus.initial,
    this.response,
    this.error,
  });

  SubmitTaskState copyWith({
    SubmitStatus? status,
    SubmitTaskResponse? response,
    String? error,
  }) {
    return SubmitTaskState(
      status: status ?? this.status,
      response: response ?? this.response,
      error: error,
    );
  }
}
