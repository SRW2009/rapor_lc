
import 'package:rapor_lc/domain/entities/divisi.dart';

var _divI = 0;
final divisiMap = <String, Divisi>{
  'it': Divisi(_divI++, 'IT', 'Ustad Andri'),
  'tahfiz': Divisi(_divI++, 'Tahfiz', 'Ustad Ismail'),
  'bahasa': Divisi(_divI++, 'Bahasa', 'Ustadzah Siti'),
  'mpp': Divisi(_divI++, 'MPP', 'Ustad Fauzan'),
};