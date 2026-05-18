import 'package:intl/intl.dart';

class Flight {
  final String id;
  final String airline;
  final String flightNumber;
  final String origin;
  final String destination;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final String aircraft;
  final String seatClass;
  final double basePrice;
  final double taxes;
  final int baggage;
  final int stops;
  final String? stopInfo;

  Flight({
    required this.id,
    required this.airline,
    required this.flightNumber,
    required this.origin,
    required this.destination,
    required this.departureTime,
    required this.arrivalTime,
    required this.aircraft,
    required this.seatClass,
    required this.basePrice,
    required this.taxes,
    required this.baggage,
    required this.stops,
    this.stopInfo,
  });

  double get totalPrice => basePrice + taxes;

  String get duration {
    final difference = arrivalTime.difference(departureTime);
    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;
    return '${hours}h ${minutes}m';
  }

  String get departureTimeFormatted {
    return DateFormat('HH:mm').format(departureTime);
  }

  String get arrivalTimeFormatted {
    return DateFormat('HH:mm').format(arrivalTime);
  }

  String get stopsText {
    if (stops == 0) return 'Direto';
    return '$stops parada${stops > 1 ? 's' : ''}';
  }

  factory Flight.fromJson(Map<String, dynamic> json) {
    return Flight(
      id: json['id'] as String,
      airline: json['airline'] as String,
      flightNumber: json['flightNumber'] as String,
      origin: json['origin'] as String,
      destination: json['destination'] as String,
      departureTime: DateTime.parse(json['departureTime'] as String),
      arrivalTime: DateTime.parse(json['arrivalTime'] as String),
      aircraft: json['aircraft'] as String? ?? 'N/A',
      seatClass: json['seatClass'] as String? ?? 'economy',
      basePrice: (json['basePrice'] as num).toDouble(),
      taxes: (json['taxes'] as num?)?.toDouble() ?? 0.0,
      baggage: json['baggage'] as int? ?? 1,
      stops: json['stops'] as int? ?? 0,
      stopInfo: json['stopInfo'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'airline': airline,
      'flightNumber': flightNumber,
      'origin': origin,
      'destination': destination,
      'departureTime': departureTime.toIso8601String(),
      'arrivalTime': arrivalTime.toIso8601String(),
      'aircraft': aircraft,
      'seatClass': seatClass,
      'basePrice': basePrice,
      'taxes': taxes,
      'baggage': baggage,
      'stops': stops,
      'stopInfo': stopInfo,
    };
  }

  Flight copyWith({
    String? id,
    String? airline,
    String? flightNumber,
    String? origin,
    String? destination,
    DateTime? departureTime,
    DateTime? arrivalTime,
    String? aircraft,
    String? seatClass,
    double? basePrice,
    double? taxes,
    int? baggage,
    int? stops,
    String? stopInfo,
  }) {
    return Flight(
      id: id ?? this.id,
      airline: airline ?? this.airline,
      flightNumber: flightNumber ?? this.flightNumber,
      origin: origin ?? this.origin,
      destination: destination ?? this.destination,
      departureTime: departureTime ?? this.departureTime,
      arrivalTime: arrivalTime ?? this.arrivalTime,
      aircraft: aircraft ?? this.aircraft,
      seatClass: seatClass ?? this.seatClass,
      basePrice: basePrice ?? this.basePrice,
      taxes: taxes ?? this.taxes,
      baggage: baggage ?? this.baggage,
      stops: stops ?? this.stops,
      stopInfo: stopInfo ?? this.stopInfo,
    );
  }
}
