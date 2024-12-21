class Article {
  final String name;
  final String description;
  final num price;
  final String imageUrl;
  final String category;

  Article({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      name: json['title'],
      description: json['description'],
      price: json['price'],
      imageUrl: json['image'],
      category: json['category'],
    );
  }

  // Print price in euros
  String get priceInEuros => '${price.toStringAsFixed(2)}€';
}
