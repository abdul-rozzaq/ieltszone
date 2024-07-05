class User {
  int id;
  String fullName;
  String token;

  User({required this.id, required this.fullName, required this.token});

  toJson() => {'id': id, 'full_name': fullName, 'token': token};

  static User fromJson(Map data) => User(id: data['id'], fullName: data['full_name'], token: data['token']);
}
