class User {
  final String id;
  final String userName;
  final String profileImage;
  final String biography;

  User({
    required this.id,
    required this.userName,
    required this.profileImage,
    required this.biography,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userName: json['user_name'],
      profileImage: json['profile_image'],
      biography: json['biographie'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_name': userName,
      'profile_image': profileImage,
      'biographie': biography,
    };
  }
}
