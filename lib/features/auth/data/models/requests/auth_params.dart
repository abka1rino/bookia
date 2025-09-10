class AuthParams {
  final String email;
  final String password;
  final String? confirmPassword;
  final String? name;

  AuthParams({required this.email, required this.password, this.confirmPassword, this.name});

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
    };
  }
}
