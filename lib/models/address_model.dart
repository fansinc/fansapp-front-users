class AddressModel {
  AddressModel({
    required this.id,
    required this.userId,
    required this.userEmail,
    required this.userName,
    required this.addressLine1,
    required this.addressLine2,
    required this.country,
    required this.state,
    required this.city,
    required this.postalCode,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  int userId;
  String userEmail;
  String userName;
  String addressLine1;
  String addressLine2;
  String country;
  String state;
  String city;
  String postalCode;
  String createdAt;
  String updatedAt;
}
