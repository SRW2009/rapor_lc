
import 'package:pdf/widgets.dart';
import 'package:rapor_lc/domain/entities/mata_pelajaran.dart';
import 'package:rapor_lc/domain/entities/nhb_block.dart';
import 'package:rapor_lc/domain/entities/nhb_semester.dart';
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/entities/npb.dart';

class NHBDatasets {
  final List<MataPelajaran> mapels;
  final List<BarDataSet> datasets;

  NHBDatasets(this.mapels, this.datasets);
}

class NHBContents {
  final List<NHBSemester> moContents;
  final List<NHBSemester> poContents;

  NHBContents(this.moContents, this.poContents);
}

typedef NHBBlockContents = List<MapEntry<String, List<NHBBlock>>>;

class NPBDatasets {
  final List<MataPelajaran> mapels;
  final List<BarDataSet> datasets;

  NPBDatasets(this.mapels, this.datasets);
}

/// List<ItemFrequency<NPB>>
typedef NPBContents = List<NPB>;

class NKDatasets {
  final List<LineDataSet> datasets;
  final Map<String, Map<String, List<double>>> contents;

  NKDatasets(this.datasets, this.contents);
}

/// Map<String, NK>
typedef NKContents = Map<String, NK>;