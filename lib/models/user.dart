class User {
  final String fullName;
  final String userName;
  final String email;
  final String phone;
  final String pictureSmall;
  final String pictureLarge;
  final String province;
  final String address;

  User(
      {required this.fullName,
      required this.userName,
      required this.email,
      required this.phone,
      required this.pictureSmall,
      required this.pictureLarge,
      required this.address,
      required this.province});
}
