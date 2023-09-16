class Category {
  final String name, image_url, description;
  final int id /*, numOfProducts*/;

  Category(
      {this.id,
      this.name,
      this.image_url,
      /*this.numOfProducts,*/ this.description});

  // It creates an Category from JSON
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json["id"],
      name: json["name"],
      image_url: json["image_url"],
      // numOfProducts: json["numOfProducts"],
      description: json["description"],
    );
  }
}

// // Our demo category
// Category category = Category(
//   id: "1",
//   title: "Armchair",
//   image: "https://i.imgur.com/JqKDdxj.png",
//   numOfProducts: 100,
// );
