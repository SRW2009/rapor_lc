

import 'package:get_it/get_it.dart';
import 'package:rapor_lc/domain/usecase/nhb/create_nhb.dart';
import 'package:rapor_lc/domain/usecase/nhb/delete_nhb.dart';
import 'package:rapor_lc/domain/usecase/nhb/get_nhb.dart';
import 'package:rapor_lc/domain/usecase/nhb/get_nhb_chart_data.dart';
import 'package:rapor_lc/domain/usecase/nhb/get_nhb_list.dart';
import 'package:rapor_lc/domain/usecase/nhb/update_nhb.dart';
import 'package:rapor_lc/domain/usecase/nk/create_nk.dart';
import 'package:rapor_lc/domain/usecase/nk/delete_nk.dart';
import 'package:rapor_lc/domain/usecase/nk/get_nk.dart';
import 'package:rapor_lc/domain/usecase/nk/get_nk_chart_data.dart';
import 'package:rapor_lc/domain/usecase/nk/get_nk_list.dart';
import 'package:rapor_lc/domain/usecase/nk/update_nk.dart';
import 'package:rapor_lc/domain/usecase/npb/create_npb.dart';
import 'package:rapor_lc/domain/usecase/npb/delete_npb.dart';
import 'package:rapor_lc/domain/usecase/npb/get_npb.dart';
import 'package:rapor_lc/domain/usecase/npb/get_npb_chart_data.dart';
import 'package:rapor_lc/domain/usecase/npb/get_npb_list.dart';
import 'package:rapor_lc/domain/usecase/npb/update_npb.dart';
import 'package:rapor_lc/domain/usecase/santri/create_santri.dart';
import 'package:rapor_lc/domain/usecase/santri/delete_santri.dart';
import 'package:rapor_lc/domain/usecase/santri/get_santri.dart';
import 'package:rapor_lc/domain/usecase/santri/get_santri_list.dart';
import 'package:rapor_lc/domain/usecase/santri/update_santri.dart';

final locator = GetIt.instance;

void init() {
  // use case
  // santri
  locator.registerLazySingleton(() => GetSantriList(locator()));
  locator.registerLazySingleton(() => GetSantri(locator()));
  locator.registerLazySingleton(() => CreateSantri(locator()));
  locator.registerLazySingleton(() => UpdateSantri(locator()));
  locator.registerLazySingleton(() => DeleteSantri(locator()));
  // nhb
  locator.registerLazySingleton(() => GetNHBList(locator()));
  locator.registerLazySingleton(() => GetNHB(locator()));
  locator.registerLazySingleton(() => CreateNHB(locator()));
  locator.registerLazySingleton(() => UpdateNHB(locator()));
  locator.registerLazySingleton(() => DeleteNHB(locator()));
  locator.registerLazySingleton(() => GetNHBChartData(locator()));
  // nk
  locator.registerLazySingleton(() => GetNKList(locator()));
  locator.registerLazySingleton(() => GetNK(locator()));
  locator.registerLazySingleton(() => CreateNK(locator()));
  locator.registerLazySingleton(() => UpdateNK(locator()));
  locator.registerLazySingleton(() => DeleteNK(locator()));
  locator.registerLazySingleton(() => GetNKChartData(locator()));
  // npb
  locator.registerLazySingleton(() => GetNPBList(locator()));
  locator.registerLazySingleton(() => GetNPB(locator()));
  locator.registerLazySingleton(() => CreateNPB(locator()));
  locator.registerLazySingleton(() => UpdateNPB(locator()));
  locator.registerLazySingleton(() => DeleteNPB(locator()));
  locator.registerLazySingleton(() => GetNPBChartData(locator()));
}