import 'package:rewarding_kids/features/adventures/models/adventure_details_model.dart';
import 'package:rewarding_kids/features/adventures/models/adventure_model.dart';

abstract class AdventureState {}

class AdventureInitial extends AdventureState {}

class AdventureLoading extends AdventureState {}

class AdventureSuccess extends AdventureState {
  final List<AdventureModel> adventures;

  AdventureSuccess(this.adventures);
}

class AdventureError extends AdventureState {
  final String message;

  AdventureError(this.message);
}

/// Details
class AdventureDetailsLoading extends AdventureState {}

class AdventureDetailsSuccess extends AdventureState {
  final AdventureDetailsModel details;

  AdventureDetailsSuccess(this.details);
}

class AdventureDetailsError extends AdventureState {
  final String message;

  AdventureDetailsError(this.message);
}
