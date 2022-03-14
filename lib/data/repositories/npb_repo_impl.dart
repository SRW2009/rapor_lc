import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/data/helpers/constant.dart';
import 'package:rapor_lc/data/helpers/shared_prefs/shared_prefs_repo.dart';
import 'package:rapor_lc/domain/entities/abstract/npb.dart';
import 'package:rapor_lc/domain/entities/npbmo.dart';
import 'package:rapor_lc/domain/repositories/npb_repo.dart';

class NPBRepositoryImpl extends NPBRepository {
  @override
  Future<RequestStatus> createNPB(NPB npb) async {
    final token = await SharedPrefsRepository().getToken;

    final response = await http.post(
      DataConstant.queryUri,
      headers: DataConstant.headers(token),
      body: jsonEncode({
        'query_type': DataConstant.queryType_action,
        'query': '''
          INSERT INTO `tb_nilai_proses_belajar`
          (`id`, `santri_nis`, `semester`, `tahun_ajaran`, `mata_pelajaran_id`, `n`, `presensi`, `note`) 
          VALUES (NULL,'${npb.santri.nis}',${npb.semester},'${npb.tahun_ajaran}',${npb.pelajaran.id},
          ${npb is NPBMO ? npb.n : -1},'${npb.presensi}','${npb.note}')
        ''',
      }),
    );
    if (response.statusCode == StatusCode.postSuccess) {
      return RequestStatus.success;
    }
    return RequestStatus.failed;
  }

  @override
  Future<RequestStatus> deleteNPB(List<String> ids) async {
    final token = await SharedPrefsRepository().getToken;

    final deleteQuery = ids.map<String>((e) =>
    'DELETE FROM tb_nilai_proses_belajar WHERE id=$e'
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
  Future<NPB> getNPB(int id) async {
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
            FROM tb_santri WHERE npb.santri_nis=tb_santri.nis
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
            FROM tb_mata_pelajaran WHERE npb.mata_pelajaran_id=tb_mata_pelajaran.id
          ) as pelajaran, 
          `n`, `presensi`, `note` 
          FROM `tb_nilai_proses_belajar` as npb 
          WHERE id=$id
        ''',
      }),
    );
    if (response.statusCode == StatusCode.getSuccess) {
      return (jsonDecode(response.body) as List)
          .map<NPB>((e) => NPB.fromJson(e))
          .toList()[0];
    }
    throw Exception();
  }

  @override
  Future<List<NPB>> getNPBList(String santriNis) async {
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
            FROM tb_santri WHERE npb.santri_nis=tb_santri.nis
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
            FROM tb_mata_pelajaran WHERE npb.mata_pelajaran_id=tb_mata_pelajaran.id
          ) as pelajaran, 
          `n`, `presensi`, `note` 
          FROM `tb_nilai_proses_belajar` as npb 
          WHERE santri_nis='$santriNis'
        ''',
      }),
    );
    if (response.statusCode == StatusCode.getSuccess) {
      return (jsonDecode(response.body) as List)
          .map<NPB>((e) => NPB.fromJson(e))
          .toList();
    }
    throw Exception();
  }

  @override
  Future<List<NPB>> getNPBListAdmin() async {
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
            FROM tb_santri WHERE npb.santri_nis=tb_santri.nis
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
            FROM tb_mata_pelajaran WHERE npb.mata_pelajaran_id=tb_mata_pelajaran.id
          ) as pelajaran, 
          `n`, `presensi`, `note` 
          FROM `tb_nilai_proses_belajar` as npb
        ''',
      }),
    );
    if (response.statusCode == StatusCode.getSuccess) {
      return (jsonDecode(response.body) as List)
          .map<NPB>((e) => NPB.fromJson(e))
          .toList();
    }
    throw Exception();
  }

  @override
  Future<RequestStatus> updateNPB(NPB npb) async {
    final token = await SharedPrefsRepository().getToken;

    final response = await http.post(
      DataConstant.queryUri,
      headers: DataConstant.headers(token),
      body: jsonEncode({
        'query_type': DataConstant.queryType_action,
        'query': '''
          UPDATE `tb_nilai_proses_belajar` 
          SET `santri_nis`='${npb.santri.nis}',`semester`=${npb.semester},
          `tahun_ajaran`='${npb.tahun_ajaran}',`mata_pelajaran_id`=${npb.pelajaran.id},
          `n`=${npb is NPBMO ? npb.n : -1},`presensi`='${npb.presensi}',`note`='${npb.note}' 
          WHERE `id`=${npb.id}
        ''',
      }),
    );
    if (response.statusCode == StatusCode.postSuccess) {
      return RequestStatus.success;
    }
    return RequestStatus.failed;
  }
}
