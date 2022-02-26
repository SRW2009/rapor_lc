
import 'package:rapor_lc/domain/entities/nk.dart';
import 'package:rapor_lc/domain/entities/santri.dart';

const _santri = Santri('12345678', 'John Doe');
final _variables = [
  'Inisiatif',
  'Kontrol Diri',
  'Kontrol Potensi',
  'Menghargai Karya'
];
final contents = List<NK>.generate(_variables.length,
        (i) => NK(i, _santri, 1, 1, '2021/2022', _variables[i], 89, 77, 65, 80, 'BB')).toList();


const adviceTitle = 'NASEHAT DEWAN GURU';
const adviceContent = '''
Inisiatif Ananda dinilai berkembang sangat baik, Ayah Bunda dapat membantu dengan memberikan banyak tugas dan tanggung jawab dengan bobot berat, serta sesekali mengkritisi pelaksanaan tugas itu sambil menunjukkan cara yang lebih baik dalam mengerjakan.\n
\n
Sedangkan kontrol diri Ananda dinilai berkembang sangat baik, Ayah Bunda dapat meningkatkan kemampuan mengendalikan diri ini dengan cara memberikan kepercayaan (hak lebih banyak) untuk mengawasi orang lain dalam mengendalikan dirinya, misalnya diberi tugas mengawasi adik mengisi jam belajar mandirinya.\n
\n 
Untuk kontrol potensi Ananda dinilai berkembang baik, Ayah Bunda dapat membantu dengan cara mencanangkan/mewajibkan waktu belajar dan sesekali mengulang hasil belajarnya (dengan memberikan 5 pertanyaan dsb).\n
\n
Kemudian dalam menghargai karya Ananda dinilai berkembang baik, Ayah Bunda dapat membantu dengan cara memuji karyanya dan menemaninya untuk mengkritisi karya orang lain . 
''';