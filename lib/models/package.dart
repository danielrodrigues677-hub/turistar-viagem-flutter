class TravelPackage {
  final String id;
  final String title;
  final String destination;
  final String description;
  final double price;
  final int nights;
  final List<String> includes;
  final double rating;
  final String imageUrl;
  final String type;

  TravelPackage({
    required this.id,
    required this.title,
    required this.destination,
    required this.description,
    required this.price,
    required this.nights,
    required this.includes,
    this.rating = 0.0,
    this.imageUrl = '',
    this.type = 'Lazer',
  });

  factory TravelPackage.fromJson(Map<String, dynamic> json) {
    return TravelPackage(
      id: json['id'] as String,
      title: json['title'] as String,
      destination: json['destination'] as String,
      description: json['description'] as String? ?? '',
      price: (json['price'] as num).toDouble(),
      nights: json['nights'] as int? ?? 1,
      includes: (json['includes'] as List?)?.cast<String>() ?? [],
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['imageUrl'] as String? ?? '',
      type: json['type'] as String? ?? 'Lazer',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'destination': destination,
        'description': description,
        'price': price,
        'nights': nights,
        'includes': includes,
        'rating': rating,
        'imageUrl': imageUrl,
        'type': type,
      };
}
