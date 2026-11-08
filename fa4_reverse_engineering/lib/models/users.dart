class FireflyUser {
  final String firstName;
  final String lastName;
  final String username;
  final String password;

  FireflyUser({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.password,
  });

  String get fullName => '$firstName $lastName';
}