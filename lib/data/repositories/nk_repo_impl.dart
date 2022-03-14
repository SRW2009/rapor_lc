
import 'dart:convert';

import 'package:rapor_lc/common/request_status.dart';
import 'package:rapor_lc/data/helpers/constant.dart';
import 'package:rapor_lc/data/helpers/shared_prefs/shared_prefs_repo.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/repositories/nk_repo.dart';
import 'package:http/http.dart' as http;

class NKRepositoryImpl extends NKRepository {
  @override
  Future<RequestStatus> createNK(NK nk) async {
    final token = await SharedPrefsRepository().getToken;

    final response = await http.post(
      DataConstant.queryUri,
      headers: DataConstant.headers(token),
      body: jsonEncode({
        'query_type': DataConstant.queryType_action,
        'query': '''
          INSERT INTO `tb_nilai_kemandirian`
          (`id`, `santri_nis`, `bulan`, `semester`, `tahun_ajaran`, `nama_variabel`, 
          `nilai_mesjid`, `nilai_kelas`, `nilai_asrama`, `akumulatif`, `predikat`,`note`) 
          VALUES (NULL,'${nk.santri.nis}',${nk.bulan},${nk.semester},'${nk.tahun_ajaran}','${nk.nama_variabel}',
          ${nk.nilai_mesjid},${nk.nilai_kelas},${nk.nilai_asrama},${nk.akumulatif},'${nk.predikat}','${nk.note}')
        ''',
      }),
    );
    if (response.statusCode == StatusCode.postSuccess) {
      return RequestStatus.success;
    }
    return RequestStatus.failed;
  }

  @override
  Future<RequestStatus> deleteNK(List<String> ids) async {
    final token = await SharedPrefsRepository().getToken;

    final deleteQuery = ids.map<String>((e) =>
    'DELETE FROM tb_nilai_kemandirian WHERE id=$e'
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
  Future<NK> getNK(int id) async {
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
            FROM tb_santri WHERE nk.santri_nis=tb_santri.nis
          ) as santri, 
          `bulan`, `semester`, `tahun_ajaran`, `nama_variabel`, 
          `nilai_mesjid`, `nilai_kelas`, `nilai_asrama`, 
          `akumulatif`, `predikat`, `note` 
          FROM `tb_nilai_kemandirian` as nk 
          WHERE id=$id
        ''',
      }),
    );
    if (response.statusCode == StatusCode.getSuccess) {
      return (jsonDecode(response.body) as List)
          .map<NK>((e) => NK.fromJson(e)).toList()[0];
    }
    throw Exception();
  }

  @override
  Future<List<NK>> getNKList(String santriNis) async {
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
            FROM tb_santri WHERE nk.santri_nis=tb_santri.nis
          ) as santri, 
          `bulan`, `semester`, `tahun_ajaran`, `nama_variabel`, 
          `nilai_mesjid`, `nilai_kelas`, `nilai_asrama`, 
          `akumulatif`, `predikat`, `note` 
          FROM `tb_nilai_kemandirian` as nk 
          WHERE santri_nis='$santriNis'
        ''',
      }),
    );
    if (response.statusCode == StatusCode.getSuccess) {
      return (jsonDecode(response.body) as List)
          .map<NK>((e) => NK.fromJson(e)).toList();
    }
    throw Exception();
  }

  @override
  Future<List<NK>> getNKListAdmin() async {
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
            FROM tb_santri WHERE nk.santri_nis=tb_santri.nis
          ) as santri, 
          `bulan`, `semester`, `tahun_ajaran`, `nama_variabel`, 
          `nilai_mesjid`, `nilai_kelas`, `nilai_asrama`, 
          `akumulatif`, `predikat`, `note` 
          FROM `tb_nilai_kemandirian` as nk
        ''',
      }),
    );
    if (response.statusCode == StatusCode.getSuccess) {
      return (jsonDecode(response.body) as List)
          .map<NK>((e) => NK.fromJson(e)).toList();
    }
    throw Exception();
  }

  @override
  Future<RequestStatus> updateNK(NK nk) async {
    final token = await SharedPrefsRepository().getToken;

    final response = await http.post(
      DataConstant.queryUri,
      headers: DataConstant.headers(token),
      body: jsonEncode({
        'query_type': DataConstant.queryType_action,
        'query': '''
          UPDATE `tb_nilai_kemandirian` 
          SET `santri_nis`='${nk.santri.nis}',`bulan`=${nk.bulan},
          `semester`=${nk.semester},`tahun_ajaran`='${nk.tahun_ajaran}',`nama_variabel`='${nk.nama_variabel}',
          `nilai_mesjid`=${nk.nilai_mesjid},`nilai_kelas`=${nk.nilai_kelas},`nilai_asrama`=${nk.nilai_asrama},
          `akumulatif`=${nk.akumulatif},`predikat`='${nk.predikat}',`note`='${nk.note}' 
          WHERE `id`=${nk.id}
        ''',
      }),
    );
    if (response.statusCode == StatusCode.postSuccess) {
      return RequestStatus.success;
    }
    return RequestStatus.failed;
  }
}