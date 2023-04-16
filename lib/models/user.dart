class User {
  final String email;
  final String  name;
  final String username;
  final String uid;
  final String displayPic;
  final String banner;
  final String bio;
  final String location;
  final String url;
  final dynamic joined;
  final String dob;
  final List<String> followers;
  final List<String> following;

//<editor-fold desc="Data Methods">
  const User({
    required this.email,
    required this.name,
    required this.username,
    required this.uid,
    required this.displayPic,
    required this.banner,
    required this.bio,
    required this.location,
    required this.url,
    required this.joined,
    required this.dob,
    required this.followers,
    required this.following,
  });

  User copyWith({
    String? email,
    String? name,
    String? username,
    String? uid,
    String? displayPic,
    String? banner,
    String? bio,
    String? location,
    String? url,
    dynamic? joined,
    String? dob,
    List<String>? followers,
    List<String>? following,
  }) {
    return User(
      email: email ?? this.email,
      name: name ?? this.name,
      username: username ?? this.username,
      uid: uid ?? this.uid,
      displayPic: displayPic ?? this.displayPic,
      banner: banner ?? this.banner,
      bio: bio ?? this.bio,
      location: location ?? this.location,
      url: url ?? this.url,
      joined: joined ?? this.joined,
      dob: dob ?? this.dob,
      followers: followers ?? this.followers,
      following: following ?? this.following,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': this.email,
      'name': this.name,
      'username': this.username,
      'uid': this.uid,
      'displayPic': this.displayPic,
      'banner': this.banner,
      'bio': this.bio,
      'location': this.location,
      'url': this.url,
      'joined': this.joined,
      'dob': this.dob,
      'followers': this.followers,
      'following': this.following,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      email: map['email'] as String,
      name: map['name'] as String,
      username: map['username'] as String,
      uid: map['uid'] as String,
      displayPic: map['displayPic'] as String,
      banner: map['banner'] as String,
      bio: map['bio'] as String,
      location: map['location'] as String,
      url: map['url'] as String,
      joined: map['joined'] as dynamic,
      dob: map['dob'] as String,
      followers: map['followers'] as List<String>,
      following: map['following'] as List<String>,
    );
  }

//</editor-fold>
}
