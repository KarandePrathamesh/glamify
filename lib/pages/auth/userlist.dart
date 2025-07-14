class User {
  String username;
  String email;
  String password; // This will store the hashed password.
  String role;

  User({
    required this.username,
    required this.email,
    required this.password,
    required this.role,
  });
}

List<User> usersList = [
  User(
      username: 'admin',
      email: 'admin@gmail.com',
      password: 'admin123',
      role: 'Admin'),
  User(
      username: 'barber',
      email: 'barber@gmail.com',
      password: 'barber123',
      role: 'Barber'),
  User(
      username: 'customer',
      email: 'customer@gmail.com',
      password: 'customer123',
      role: 'User'),
];
