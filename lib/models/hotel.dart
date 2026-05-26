class Hotel {
  final String id;
  final String name;
  final String city;
  final String address;
  final double pricePerNight;
  final double rating;
  final int stars;
  final List<String> amenities;
  final String imageUrl;
  final int reviewCount;

  Hotel({
    required this.id,
    required this.name,
    required this.city,
    required this.address,
    required this.pricePerNight,
    required this.rating,
    required this.stars,
    required this.amenities,
    this.imageUrl = '',
    this.reviewCount = 0,
  });

  factory Hotel.fromJson(Map<String, dynamic> json) {
    return Hotel(
      id: json['id'] as String,
      name: json['name'] as String,
      city: json['city'] as String,
      address: json['address'] as String? ?? '',
      pricePerNight: (json['pricePerNight'] as num).toDouble(),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      stars: json['stars'] as int? ?? 3,
      amenities: (json['amenities'] as List?)?.cast<String>() ?? [],
      imageUrl: json['imageUrl'] as String? ?? '',
      reviewCount: json['reviewCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'city': city,
        'address': address,
        'pricePerNight': pricePerNight,
        'rating': rating,
        'stars': stars,
        'amenities': amenities,
        'imageUrl': imageUrl,
        'reviewCount': reviewCount,
      };
}
