class DeliveryAddressModel {
  String? address_id;
  String? fullname;
  String? phone;
  String? street;
  String? ward;
  String? district;
  String? city;
  String? addressType;

  DeliveryAddressModel(
      {this.address_id,
      this.fullname,
      this.phone,
      this.street,
      this.ward,
      this.district,
      this.city,
      this.addressType});
}
