class Aktivitas {
  List<Results>? results;

  Aktivitas({results});

  Aktivitas.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? id;
  String? userId;
  String? tanggal;
  String? keterangan;
  String? createdAt;

  Results({id, userId, tanggal, keterangan, createdAt});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    tanggal = json['tanggal'];
    keterangan = json['keterangan'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userId;
    data['tanggal'] = tanggal;
    data['keterangan'] = keterangan;
    data['created_at'] = createdAt;
    return data;
  }
}
