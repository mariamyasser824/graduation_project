import 'package:rewarding_kids/features/parent/models/statistics_model.dart';

abstract class StatisticsState {}

class StatisticsInitial extends StatisticsState {}

class StatisticsLoading extends StatisticsState {}

class StatisticsSuccess extends StatisticsState {
  final StatisticsModel data;

  StatisticsSuccess(this.data);
}

class StatisticsError extends StatisticsState {
  final String message;

  StatisticsError(this.message);
}
