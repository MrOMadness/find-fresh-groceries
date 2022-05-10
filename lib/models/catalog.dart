class Catalog {
  final String name;
  final String type;
  final String price;
  final String picture;
  final String rating;

  Catalog(
      {required this.name,
      required this.type,
      required this.price,
      required this.picture,
      required this.rating});

  factory Catalog.fromJson(Map<String, dynamic> json) {
    return Catalog(
      name: json['name'],
      picture: json['picture'],
      price: json['price'],
      rating: json['rating'],
      type: json['type'],
    );
  }
}
