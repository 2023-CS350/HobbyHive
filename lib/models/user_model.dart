class User {
  final String id;
  final String userName;
  final String profileImage;
  final String biography;
  final List<String> interest;

  User({
    required this.id,
    required this.userName,
    required this.profileImage,
    required this.biography,
    required this.interest,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userName: json['user_name'],
      profileImage: json['profile_image'],
      biography: json['biographie'],
      interest: List<String>.from(json['interest']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_name': userName,
      'profile_image': profileImage,
      'biographie': biography,
      'interest': interest,
    };
  }
}
