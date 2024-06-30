class Users {
  int? value;
  String? message;
  User? user;

  Users({this.value, this.message, this.user});

  Users.fromJson(Map<String, dynamic> json) {
    value = json['value'];
    message = json['message'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['value'] = value;
    data['message'] = message;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? userId;
  String? username;
  String? password;
  String? nik;
  String? nama;
  String? kodeKantor;
  String? cabangId;
  String? areaId;
  dynamic email;
  String? groupMenu;
  String? area;
  String? tglExpired;
  String? flgBlok;
  String? jabatanId;
  String? unitId;
  String? divisiId;
  String? rankId;
  String? userIdInduk;
  dynamic flag;
  dynamic foto;
  String? fcmToken;
  String? jabatan;
  String? namaDivisi;
  String? namaKantor;
  String? alamatKantor;
  String? accessToken;
  String? latitude;
  String? longitude;
  String? noWa;
  String? userIdUserInfo;

  User(
      {this.userId,
      this.username,
      this.password,
      this.nik,
      this.nama,
      this.kodeKantor,
      this.cabangId,
      this.areaId,
      this.email,
      this.groupMenu,
      this.area,
      this.tglExpired,
      this.flgBlok,
      this.jabatanId,
      this.unitId,
      this.divisiId,
      this.rankId,
      this.userIdInduk,
      this.flag,
      this.foto,
      this.fcmToken,
      this.jabatan,
      this.namaDivisi,
      this.namaKantor,
      this.alamatKantor,
      this.latitude,
      this.longitude,
      this.accessToken,
      this.noWa,
      this.userIdUserInfo});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    username = json['username'];
    password = json['password'];
    nik = json['nik'];
    nama = json['nama'];
    kodeKantor = json['kode_kantor'];
    cabangId = json['cabang_id'];
    areaId = json['area_id'];
    email = json['email'];
    groupMenu = json['group_menu'];
    area = json['area'];
    tglExpired = json['tgl_expired'];
    flgBlok = json['flg_blok'];
    jabatanId = json['jabatan_id'];
    unitId = json['unit_id'];
    divisiId = json['divisi_id'];
    rankId = json['rank_id'];
    userIdInduk = json['user_id_induk'];
    flag = json['flag'];
    foto = json['foto'];
    fcmToken = json['fcm_token'];
    jabatan = json['jabatan'];
    namaDivisi = json['nama_divisi'];
    namaKantor = json['nama_kantor'];
    alamatKantor = json['alamat_kantor'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    accessToken = json['access_token'];
    noWa = json['no_wa'];
    userIdUserInfo = json['user_id_userinfo'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user_id'] = userId;
    data['username'] = username;
    data['password'] = password;
    data['nik'] = nik;
    data['nama'] = nama;
    data['kode_kantor'] = kodeKantor;
    data['cabang_id'] = cabangId;
    data['area_id'] = areaId;
    data['email'] = email;
    data['group_menu'] = groupMenu;
    data['area'] = area;
    data['tgl_expired'] = tglExpired;
    data['flg_blok'] = flgBlok;
    data['jabatan_id'] = jabatanId;
    data['unit_id'] = unitId;
    data['divisi_id'] = divisiId;
    data['rank_id'] = rankId;
    data['user_id_induk'] = userIdInduk;
    data['flag'] = flag;
    data['foto'] = foto;
    data['fcm_token'] = fcmToken;
    data['jabatan'] = jabatan;
    data['nama_divisi'] = namaDivisi;
    data['nama_kantor'] = namaKantor;
    data['alamat_kantor'] = alamatKantor;
    data['access_token'] = accessToken;
    data['no_wa'] = noWa;
    data['user_id_userinfo'] = userIdUserInfo;
    return data;
  }
}
