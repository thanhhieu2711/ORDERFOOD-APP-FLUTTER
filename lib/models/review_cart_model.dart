class ReviewCartModel {
  String? cartId;
  String? cartImage;
  String? cartName;
  String? cartPrice;
  int? cartQuantity;
  var cartUnit;
  ReviewCartModel({
    this.cartId,
    this.cartUnit,
    this.cartImage,
    this.cartName,
    this.cartPrice,
    this.cartQuantity,
  });
}
