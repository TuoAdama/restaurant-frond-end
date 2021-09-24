import 'package:intl/intl.dart';

class CommandeItem {
  String numTable;
  String createAt;
  int total;
  String statut;
  List commandes;

  CommandeItem({
    required this.numTable,
    required this.statut,
    required this.total,
    required this.commandes,
    required this.createAt,
  });

  factory CommandeItem.toJson(Map<dynamic, dynamic> map) {
    int nbCommande = (map['table_client']['commandes'] as List).length;
    return new CommandeItem(
        numTable: map['table_client']['numero_table'],
        statut: map['etat']['libelle'],
        total: nbCommande,
        commandes: map['table_client']['commandes'],
        createAt: DateFormat("yyyy-MM-dd HH:mm:ss")
            .format(DateTime.parse(map['created_at'])));
  }
}
