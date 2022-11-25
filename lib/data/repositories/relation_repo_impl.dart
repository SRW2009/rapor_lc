
import 'dart:convert';

import 'package:rapor_lc/common/enum/request_status.dart';
import 'package:rapor_lc/data/helpers/constant.dart';
import 'package:rapor_lc/data/helpers/shared_prefs.dart';
import 'package:rapor_lc/data/models/relation_model.dart';
import 'package:rapor_lc/domain/entities/relation.dart';
import 'package:rapor_lc/domain/repositories/relation_repo.dart';
import 'package:http/http.dart' as http;

class RelationRepositoryImpl extends RelationRepository {

  @override
  String url = Urls.adminRelation;

  @override
  Future<List<Relation>> getRelationList() async {
    final token = await SharedPrefs().getToken;

    final response = await http.get(
      readUri(),
      headers: DataConstant.headers(token),
    );
    if (response.statusCode == StatusCode.getSuccess) {
      return (jsonDecode(response.body) as List)
          .map<Relation>((e) => Relation.fromJson(e)).toList();
    }
    throw Exception();
  }

  @override
  Future<RequestStatus> createRelation(Relation relation) async {
    final token = await SharedPrefs().getToken;

    final response = await http.post(
      createUri(),
      headers: DataConstant.headers(token),
      body: jsonEncode(RelationModel.toJsonRequest(relation)),
    );
    if (response.statusCode == StatusCode.postSuccess) {
      return RequestStatus.success;
    }
    return RequestStatus.failed;
  }

  @override
  Future<RequestStatus> updateRelation(Relation relation) async {
    final token = await SharedPrefs().getToken;

    final response = await http.put(
      updateUri(relation.id),
      headers: DataConstant.headers(token),
      body: jsonEncode(RelationModel.toJsonRequest(relation)),
    );
    if (response.statusCode == StatusCode.putSuccess) {
      return RequestStatus.success;
    }
    return RequestStatus.failed;
  }

  @override
  Future<RequestStatus> deleteRelation(List<String> ids) async {
    final token = await SharedPrefs().getToken;

    bool success = true;
    for (var id in ids) {
      final response = await http.delete(
        deleteUri(id),
        headers: DataConstant.headers(token),
      );

      if (response.statusCode != StatusCode.deleteSuccess) {
        success = false;
        break;
      }
    }
    if (success) return RequestStatus.success;
    return RequestStatus.failed;
  }
}