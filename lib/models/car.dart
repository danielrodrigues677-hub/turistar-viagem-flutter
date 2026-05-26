class CarRental {
  final String id;
  final String company;
  final String model;
  final String category;
  final double pricePerDay;
  final int seats;
  final String transmission;
  final bool airConditioning;
  final int bags;
  final String pickupLocation;

  CarRental({
    required this.id,
    required this.company,
    required this.model,
    required this.category,
    required this.pricePerDay,
    required this.seats,
    required this.transmission,
    required this.airConditioning,
    required this.bags,
    this.pickupLocation = '',
  });

  factory CarRental.fromJson(Map<String, dynamic> json) {
    return CarRental(
      id: json['id'] as String,
      company: json['company'] as String,
      model: json['model'] as String,
      category: json['category'] as String? ?? 'Econômico',
      pricePerDay: (json['pricePerDay'] as num).toDouble(),
      seats: json['seats'] as int? ?? 5,
      transmission: json['transmission'] as String? ?? 'Manual',
      airConditioning: json['airConditioning'] as bool? ?? true,
      bags: json['bags'] as int? ?? 2,
      pickupLocation: json['pickupLocation'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'company': company,
        'model': model,
        'category': category,
        'pricePerDay': pricePerDay,
        'seats': seats,
        'transmission': transmission,
        'airConditioning': airConditioning,
        'bags': bags,
        'pickupLocation': pickupLocation,
      };
}
