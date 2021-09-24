import 'package:scoped_model/scoped_model.dart';

class Personnel extends Model {
  final int id, idPoste;
  final String nom, prenom, dateNaissance;

  Personnel({required this.id,
            required this.nom,
            required this.prenom,
            required this.dateNaissance,
            required this.idPoste});

  @override
  String toString() {
    return "[id:$id, nom:$nom, prenom: $prenom, idPoste:$idPoste]";
  }

}