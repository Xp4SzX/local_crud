class Mahasiswa {
  String nama;
  String jurusan;

  Mahasiswa(this.nama, this.jurusan);

  Map<String, dynamic> toJson() => {
    'nama': nama,
    'jurusan': jurusan,
  };

  factory Mahasiswa.fromJson(Map<String, dynamic> json) {
    return Mahasiswa(json['nama'], json['jurusan']);
  }
}
