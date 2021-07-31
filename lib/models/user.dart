class GUser {

  final String uid;
  final String email;
  final String firstName;
  final String lastName;
  final String sex;
  final String phone;
  final int isAdmin;
  final int isVerified;


  GUser(this.email, this.firstName, this.lastName, this.sex, this.phone, this.isAdmin, this.isVerified, { required this.uid });

}