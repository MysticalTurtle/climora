import 'package:climora/domain/entities/geocoding.dart';
import 'package:equatable/equatable.dart';

class Favorite extends Equatable {
  const Favorite({
    required this.id,
    required this.location,
    required this.date,
  });

  factory Favorite.fromMap(Map<String, dynamic> json) => Favorite(
    id: json['id'] as int? ?? 0,
    location: GeocodingLocation.fromMap(
      json['location'] as Map<String, dynamic>,
    ),
    date: DateTime.parse(json['date'] as String? ?? ''),
  );

  final int id;
  final GeocodingLocation location;
  final DateTime date;

  Favorite copyWith({
    int? id,
    GeocodingLocation? location,
    DateTime? date,
  }) => Favorite(
    id: id ?? this.id,
    location: location ?? this.location,
    date: date ?? this.date,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'location': location.toMap(),
    'date': date.toIso8601String(),
  };

  @override
  List<Object?> get props => [id, location, date];
}
