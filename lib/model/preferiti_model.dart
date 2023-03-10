class PreferitiModel {
  String? id;
  String? idUser;
  String? idCat;

  PreferitiModel({
    this.id = '',
    this.idUser = '',
    this.idCat = '',
  });

  PreferitiModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUser = json['idUser'];
    idCat = json['idCat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['idUser'] = idUser;
    data['idCat'] = idCat;
    return data;
  }
}