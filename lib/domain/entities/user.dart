
class User {
  final String email;
  final String password;
  final int status;

  User(this.email, this.password) : status = 0;

  User.teacher(this.email, this.password) : status = 1;

  User.admin(this.email, this.password) : status = 2;
}