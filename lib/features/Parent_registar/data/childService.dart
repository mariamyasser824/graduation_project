import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart';
import 'package:rewarding_kids/core/network/api_constants.dart';
import 'package:rewarding_kids/core/network/api_service.dart';
import 'package:rewarding_kids/features/Parent_registar/data/childRequestModel.dart';
import 'package:rewarding_kids/features/Parent_registar/data/childmodel.dart';

class ChildService {
  final ApiService _api = ApiService();

  /// تحويل asset لصورة bytes
  Future<MultipartFile> _assetToMultipart(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);

    return MultipartFile.fromBytes(
      byteData.buffer.asUint8List(),
      filename: assetPath.split('/').last,
      contentType: MediaType('image', 'svg+xml'),
    );
  }

  /// تحويل صورة من الموبايل
  Future<MultipartFile> _fileToMultipart(String path) async {
    final extension = path.split('.').last;

    return MultipartFile.fromFile(
      path,
      filename: path.split('/').last,
      contentType: MediaType('image', extension),
    );
  }

  Future<ChildModel> addChild(ChildRequestModel request) async {
    MultipartFile? avatarFile;

    if (request.avatarPath != null) {
      if (request.avatarPath!.startsWith('assets')) {
        avatarFile = await _assetToMultipart(request.avatarPath!);
      } else {
        avatarFile = await _fileToMultipart(request.avatarPath!);
      }
    }

    FormData formData = FormData.fromMap({
      "Name": request.name,
      "NickName": request.nickName,
      "Age": request.age,
      "Gender": request.gender,
      "RelationshipToParent": request.relationship,
      if (avatarFile != null) "Avatar": avatarFile,
    });

    final response = await _api.post(ApiConstants.addChild, formData);

    return ChildModel.fromJson(response);
  }
}
