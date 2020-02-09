class ProductModel {
  // Field
  String id, category, nameFood, price, detail;

  // Consturctor
  ProductModel(this.id, this.category, this.nameFood, this.price, this.detail);

  ProductModel.fromJSON(Map<String, dynamic> map){
    id = map['id'];
    category = map['Category'];
    nameFood = map['NameFood'];
    price = map['Price'];
    detail = map['Detail'];
  }

}
