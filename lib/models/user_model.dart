class User {
  final String id;
  final String userName;
  final String profileImage;
  final String biography;
  final int score;
  final List<String> interest;

  User({
    required this.id,
    required this.userName,
    required this.profileImage,
    required this.biography,
    required this.score,
    required this.interest,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      userName: json['user_name'],
      profileImage: json['profile_image'],
      biography: json['biographie'],
      score: json['score'],
      interest: List<String>.from(json['interest']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_name': userName,
      'profile_image': profileImage,
      'biographie': biography,
      'score': score,
      'interest': interest,
    };
  }
}
