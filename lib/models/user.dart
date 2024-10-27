class User {
  final int id;
  final String name;
  final String surname;
  final String image;
  final bool isActive;
  final String address;
  final Location location;

  User(
      {required this.id,
      required this.name,
      required this.surname,
      required this.image,
      required this.isActive,
      required this.address,
      required this.location});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      image: json['image'],
      isActive: json['isActive'],
      address: json['Address'],
      location: Location.fromJson(json['location']),
    );
  }
}

class Location {
  final double latitude;
  final double longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
