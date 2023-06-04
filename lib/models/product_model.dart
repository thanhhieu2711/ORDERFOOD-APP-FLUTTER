class ProductModel {
  String? productName;
  String? productImage;
  String? productPrice;
  String? productId;
  String? productDes;

  int? productQuantity;
  List<dynamic>? productUnit;
  ProductModel(
      {this.productQuantity,
      this.productId,
      this.productUnit,
      this.productImage,
      this.productName,
      this.productPrice,
      this.productDes});
}
