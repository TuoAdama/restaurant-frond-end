import 'package:restaurant/models/Category.dart';
import 'package:restaurant/models/plat.dart';
import 'package:scoped_model/scoped_model.dart';

class Data extends Model {
  List<Category> categories = [];
  List<Plat> plats = [];
  List<Plat> filtrePlats = [];

  Data({required this.categories, required this.plats}) {
    this.filtrePlats = this.plats;
  }

  void filtredPlat(String search) {
    if (search.isNotEmpty) {
      filtrePlats =
          plats.where((element) => element.category == search).toList();
    } else {
      filtrePlats = plats;
    }
    notifyListeners();
  }
}
