import 'package:restaurant/models/commande.dart';
import 'package:scoped_model/scoped_model.dart';

class Panier extends Model {
  List<Commande> commandes = [];

  void add(Commande commande) {
    commandes.add(commande);
    notifyListeners();
  }

  void delete(Commande cmd) {
    commandes.remove(cmd);
    notifyListeners();
  }

  void clear(){
    commandes.clear();
    notifyListeners();
  }
}
