class Category {
  final int id;
  final String libelle;
  final String avatar;

  Category({required this.id, required this.libelle, required this.avatar});
  
  factory Category.formJson(Map<String, dynamic> json){
    return Category(id: json['id'], libelle: json['libelle']
    , avatar: json['avatar']);
  }

  @override
  String toString() {
    return "id: $id, libelle: $libelle, avatar: $avatar";
  }

}