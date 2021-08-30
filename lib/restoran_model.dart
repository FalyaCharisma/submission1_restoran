class RestoranModel{
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final MenuModel menu;

  RestoranModel({required this.id, required this.name, required this.description, required this.pictureId,
   required this.city, required this.rating, required this.menu});

  factory RestoranModel.fromJson(Map<String, dynamic> json){
    return RestoranModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      pictureId: json['pictureId'] as String,
      city: json['city'] as String,
      rating: (json['rating'] as num).toDouble(),
      menu: MenuModel.fromJson(json['menus']),
    );
  }
}

class MenuModel{
  late final List<Food> foods;
  late final List<Drink> drinks;

  MenuModel({required this.foods, required this.drinks});

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    var listFood = json['foods'] as List;
    List<Food> foodList = listFood.map((i) => Food.fromJson(i)).toList();
    var listDrink = json['drinks'] as List;
    List<Drink> drinkList = listDrink.map((i) => Drink.fromJson(i)).toList();
    return MenuModel(foods: foodList, drinks: drinkList);
  }
}

class Food {
  final String name;

  Food({required this.name});

  factory Food.fromJson(Map<String, dynamic> json) {
    return Food(name: json['name']);
  }
}

class Drink {
  final String name;

  Drink({required this.name});

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(name: json['name']);
  }
}
