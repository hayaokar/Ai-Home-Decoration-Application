class Product {
  final int id, price, quantity, category;
  final String name, image_url, description;

  Product({
    this.id,
    this.price,
    this.name,
    this.category,
    this.image_url,
    this.quantity,
    // this.subTitle,
    this.description,
  });

  // It create an Category from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json["id"],
      name: json["name"],
      image_url: json["image_url"],
      price: json["price"] ?? 0,
      category: json["category"],
      // subTitle: json["subTitle"],
      description: json["description"],
      quantity: json["quantity"],
    );
  }
}

Product product = Product(
  id: 1,
  price: 1600,
  name: "Wood Frame",
  image_url: "https://i.imgur.com/sI4GvE6.png",
  category: 1,
  // subTitle: "Tieton Armchair",
  description: "description",
);

// String description =
//     "This armchair is an elegant and functional piece of furniture. It is suitable for family visits and parties with friends and perfect for relaxing in front of the TV after hard work.";
