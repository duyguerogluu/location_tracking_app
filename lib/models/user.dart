class User {
  final int id;
  final String name;
  final String surname;
  final String image;
  final bool isActive;
  final String address;

  User({
    required this.id,
    required this.name,
    required this.surname,
    required this.image,
    required this.isActive,
    required this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      image: json['image'],
      isActive: json['isActive'],
      address: json['Address'],
    );
  }
}
