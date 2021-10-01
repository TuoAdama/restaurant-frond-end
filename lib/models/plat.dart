class Plat {
  
  final String  name, category, price, imagePath;
  final int id;

  Plat({required this.category,
        required this.name,
        required this.price,
        required this.imagePath,
        required this.id});

  factory Plat.fromJson(Map<dynamic, dynamic> values){
    return new Plat(category:values["categorie"]['libelle'],
                    name: values['libelle'],
                    price: values["prix"].toString(),
                    imagePath: values['images'][0]['chemin'],
                    id: values['id']);

  }

  @override
  bool operator ==(Object other) {
    return (other is Plat)
        && other.name == name
        && other.price == price
        && other.imagePath == imagePath
        && other.id == id;
  }

  Map<String, dynamic> toJson() {
    return {
      "id":this.id,
      "category":this.category,
      "name":this.name,
      "price":this.price,
      "imagePath":this.imagePath,
    };
  }

  @override
  String toString() {
    return "[id:$id, name:$name, prix:$price,imagePath:$imagePath, category:$category]";
  }
}