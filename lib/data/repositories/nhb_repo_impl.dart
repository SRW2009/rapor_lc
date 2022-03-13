
import 'dart:convert';

import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/data/helpers/constant.dart';
import 'package:rapor_lc/data/helpers/shared_prefs/shared_prefs_repo.dart';
import 'package:rapor_lc/domain/entities/divisi.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/nhb.dart';
import 'package:rapor_lc/domain/entities/santri.dart';
import 'package:rapor_lc/domain/repositories/nhb_repo.dart';
import 'package:http/http.dart' as http;

class NHBRepositoryImpl extends NHBRepository {
  @override
  Future<RequestStatus> createNHB(NHB nhb) async {
    final token = await SharedPrefsRepository().getToken;

    final response = await http.post(
      DataConstant.queryUri,
      headers: DataConstant.headers(token),
      body: jsonEncode({
        'query_type': DataConstant.queryType_action,
        'query': '''
          INSERT INTO `tb_nilai_hasil_belajar`
          (`id`, `santri_nis`, `semester`, `tahun_ajaran`, `mata_pelajaran_id`, 
          `nilai_harian`, `nilai_bulanan`, `nilai_projek`, `nilai_akhir`, `akumulatif`, 
          `predikat`) 
          VALUES (NULL,'${nhb.santri.nis}',${nhb.semester},'${nhb.tahun_ajaran}',${nhb.pelajaran.id},
          ${nhb.nilai_harian},${nhb.nilai_bulanan},${nhb.nilai_projek},${nhb.nilai_akhir},${nhb.akumulasi},'${nhb.predikat}')
        ''',
      }),
    );
    if (response.statusCode == StatusCode.postSuccess) {
      return RequestStatus.success;
    }
    return RequestStatus.failed;
  }

  @override
  Future<RequestStatus> deleteNHB(List<String> ids) async {
    final token = await SharedPrefsRepository().getToken;

    final deleteQuery = ids.map<String>((e) =>
    'DELETE FROM tb_nilai_hasil_belajar WHERE id=$e'
    ).join(';');
    final response = await http.post(
      DataConstant.queryUri,
      headers: DataConstant.headers(token),
      body: jsonEncode({
        'query_type': DataConstant.queryType_action,
        'query': deleteQuery,
      }),
    );
    if (response.statusCode == StatusCode.postSuccess) {
      return RequestStatus.success;
    }
    return RequestStatus.failed;
  }
  @override
  Future<NHB> getNHB(int id) async {
    final token = await SharedPrefsRepository().getToken;

    final response = await http.post(
      DataConstant.queryUri,
      headers: DataConstant.headers(token),
      body: jsonEncode({
        'query_type': DataConstant.queryType_get,
        'query': '''
          SELECT `id`, `santri_nis`, 
          `semester`, `tahun_ajaran`, `mata_pelajaran_id`, 
          `nilai_harian`, `nilai_bulanan`, `nilai_projek`, `nilai_akhir`, `akumulatif`, 
          `predikat` 
          FROM tb_nilai_hasil_belajar as nhb 
          WHERE id=$id
        ''',
      }),
    );
    if (response.statusCode == StatusCode.getSuccess) {
      return (jsonDecode(response.body) as List)
          .map<NHB>((e) => NHB.fromJson(e)).toList()[0];
    }
    throw Exception();
  }

  @override
  Future<List<NHB>> getNHBList(String santriNis) {
    // TODO: implement getNHBList
    throw UnimplementedError();
  }

  @override
  Future<List<NHB>> getNHBListAdmin() async {
    final token = await SharedPrefsRepository().getToken;

    final response = await http.post(
      DataConstant.queryUri,
      headers: DataConstant.headers(token),
      body: jsonEncode({
        'query_type': DataConstant.queryType_get,
        'query': '''
          SELECT `id`, 
          (SELECT 
            GROUP_CONCAT(JSON_OBJECT(
              'nis', tb_santri.nis,
              'nama', tb_santri.nama,
              'guru', (SELECT
                        JSON_OBJECT(
                          'email', tb_user.email,
                          'password', '',
                          'status', tb_user.status
                        )
                        FROM tb_user WHERE tb_santri.teacher_email=tb_user.email
                      )
            ))
            FROM tb_santri WHERE nhb.santri_nis=tb_santri.nis
          ) as santri, 
          `semester`, `tahun_ajaran`, 
          (SELECT 
            GROUP_CONCAT(JSON_OBJECT(
              'id', tb_mata_pelajaran.id,
              'divisi', (SELECT
                          JSON_OBJECT(
                            'id', tb_divisi.id,
                            'nama', tb_divisi.nama,
                            'kadiv', tb_divisi.kadiv
                          )
                          FROM tb_divisi WHERE tb_mata_pelajaran.divisi_id=tb_divisi.id
                        ),
              'nama_mapel', tb_mata_pelajaran.nama_mapel
            ))
            FROM tb_mata_pelajaran WHERE nhb.mata_pelajaran_id=tb_mata_pelajaran.id
          ) as pelajaran, 
          `nilai_harian`, `nilai_bulanan`, `nilai_projek`, `nilai_akhir`, 
          `akumulasi`, `predikat` 
          FROM tb_nilai_hasil_belajar as nhb
        ''',
      }),
    );
    if (response.statusCode == StatusCode.getSuccess) {
      return (jsonDecode(response.body) as List)
          .map<NHB>((e) => NHB.fromJson(e)).toList();
    }
    throw Exception();
  }

  @override
  Future<RequestStatus> updateNHB(NHB newNHB) {
    // TODO: implement updateNHB
    throw UnimplementedError();
  }
}