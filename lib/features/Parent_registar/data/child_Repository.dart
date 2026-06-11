import 'package:rewarding_kids/features/Parent_registar/data/childRequestModel.dart';
import 'package:rewarding_kids/features/Parent_registar/data/childService.dart';
import 'package:rewarding_kids/features/Parent_registar/data/childmodel.dart';

class ChildRepository {
  final ChildService service;

  ChildRepository({required this.service});

  Future<ChildModel> addChild(ChildRequestModel request) {
    return service.addChild(request);
  }
}
