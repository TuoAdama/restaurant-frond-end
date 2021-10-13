import 'package:scoped_model/scoped_model.dart';

class Personnel extends Model {
  int? id, idPoste;
  String? nom, prenom, dateNaissance;

  Personnel({this.id, this.idPoste, this.nom, this.prenom, this.dateNaissance});

  factory Personnel.fromJson(Map<String, dynamic> json){
    return new Personnel(
      id: json['id'],
      idPoste: json['poste_id'],
      nom: json['nom'],
      prenom: json['prenom'],
      dateNaissance: json['date_de_naissance']
    );
  }

  void setPerson(Personnel personnel){
    this.id = personnel.id;
    this.idPoste = personnel.idPoste;
    this.nom = personnel.nom;
    this.prenom = personnel.prenom;
    this.dateNaissance = personnel.dateNaissance;

    notifyListeners();

  }

  @override
  String toString() {
    return "[id:$id, nom:$nom, prenom: $prenom, idPoste:$idPoste]";
  }

}