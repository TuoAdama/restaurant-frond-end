import 'package:restaurant/models/plat.dart';

class Commande {
  Plat plat;
  int quantite;
  Commande(this.plat, this.quantite);

  @override
  bool operator ==(Object other) {
    return (other is Commande)
        && other.plat == plat;
  }

  Map<String, dynamic> toJson(){
    return {
      "plat_id":this.plat.id,
      "quantite":this.quantite,
    };
  }

  @override
  String toString() {
    return "[plat:${plat.toString()}, quantite:$quantite]";
  }

}