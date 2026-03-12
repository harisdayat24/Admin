/// Enum sektor BLUD
enum Sektor {
  pendidikan('Pendidikan', '🎓'),
  kesehatan('Kesehatan', '🏥'),
  uptLainnya('UPT Lainnya', '🏛️');

  final String label;
  final String icon;
  const Sektor(this.label, this.icon);

  /// Key yang dipakai di Supabase (sesuai enum PostgreSQL)
  String get dbKey {
    switch (this) {
      case Sektor.pendidikan:
        return 'pendidikan';
      case Sektor.kesehatan:
        return 'kesehatan';
      case Sektor.uptLainnya:
        return 'upt_lainnya';
    }
  }

  static Sektor fromString(String s) {
    switch (s) {
      case 'pendidikan':
        return Sektor.pendidikan;
      case 'kesehatan':
        return Sektor.kesehatan;
      case 'upt_lainnya':
        return Sektor.uptLainnya;
      default:
        return Sektor.pendidikan;
    }
  }
}

/// Status BLUD unit
enum StatusBlud {
  blud('Sudah BLUD'),
  calon('Calon BLUD'),
  belumMengusulkan('Belum Mengusulkan');

  final String label;
  const StatusBlud(this.label);

  String get dbKey {
    switch (this) {
      case StatusBlud.blud:
        return 'blud';
      case StatusBlud.calon:
        return 'calon';
      case StatusBlud.belumMengusulkan:
        return 'belum_mengusulkan';
    }
  }

  static StatusBlud fromString(String s) {
    switch (s) {
      case 'blud':
        return StatusBlud.blud;
      case 'calon':
        return StatusBlud.calon;
      default:
        return StatusBlud.belumMengusulkan;
    }
  }
}
