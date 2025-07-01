class User {
  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.profilePictureUrl,
    required this.points,
  });

  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final String profilePictureUrl;
  final int points ;
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'].toString(),
      email: json['email'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      profilePictureUrl: json['picture'] as String,
      points: json['pointBalance'] as int,
    );
  }
}
