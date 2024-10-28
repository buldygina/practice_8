class Coffee {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final String cost;
  final String article;

  Coffee(this.id, this.title, this.description, this.imageUrl, this.cost, this.article);
Map<String, dynamic> toJson(){
  return{
    'ID': id,
    'Title': title,
    'Description': description,
    'ImageURL': imageUrl,
    'Cost': cost,
    'Article': article,
  };
}

  factory Coffee.fromJson(Map<String, dynamic> json) {
    return Coffee(
      json['ID'] as int,
      json['Title'] as String,
      json['Description'] as String,
      json['ImageURL'] as String,
      json['Cost'] as String,
      json['Article'] as String,
    );
  }
}
