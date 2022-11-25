
class NKAdviceFactory {
  String inisiatifPredicate;
  String kontrolDiriPredicate;
  String kontrolPotensiPredicate;
  String menghargaiKaryaPredicate;

  NKAdviceFactory(this.inisiatifPredicate, this.kontrolDiriPredicate,
      this.kontrolPotensiPredicate, this.menghargaiKaryaPredicate);

  String generate() {
    return '''
      Inisiatif Ananda dinilai ${_parser(inisiatifPredicate)}, Ayah Bunda dapat membantu dengan memberikan banyak tugas dan tanggung jawab dengan bobot berat, serta sesekali mengkritisi pelaksanaan tugas itu sambil menunjukkan cara yang lebih baik dalam mengerjakan.\n
      \n
      Sedangkan kontrol diri Ananda dinilai ${_parser(kontrolDiriPredicate)}, Ayah Bunda dapat meningkatkan kemampuan mengendalikan diri ini dengan cara memberikan kepercayaan (hak lebih banyak) untuk mengawasi orang lain dalam mengendalikan dirinya, misalnya diberi tugas mengawasi adik mengisi jam belajar mandirinya.\n
      \n 
      Untuk kontrol potensi Ananda dinilai ${_parser(kontrolPotensiPredicate)}, Ayah Bunda dapat membantu dengan cara mencanangkan/mewajibkan waktu belajar dan sesekali mengulang hasil belajarnya (dengan memberikan 5 pertanyaan dsb).\n
      \n
      Kemudian dalam menghargai karya Ananda dinilai ${_parser(menghargaiKaryaPredicate)}, Ayah Bunda dapat membantu dengan cara memuji karyanya dan menemaninya untuk mengkritisi karya orang lain . 
    ''';
  }

  String _parser(String predicate) {
    if (predicate == 'BA') return 'belum ada';
    if (predicate == 'MB') return 'mulai berkembang';
    if (predicate == 'BB') return 'berkembang baik';
    if (predicate == 'BSB') return 'berkembang sangat baik';
    return '';
  }
}