class GigUser {

  final String uid;
  final String email;
  final String firstName;
  final String lastName;
  final String sex;
  final String phone;
  final bool isAdmin;


  GigUser(this.email, this.firstName, this.lastName, this.sex, this.phone, this.isAdmin, { required this.uid });

}