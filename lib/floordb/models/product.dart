import 'package:floor/floor.dart';
import 'category.dart';

@Entity(
  tableName: 'product',
  foreignKeys: [
    ForeignKey(
      childColumns: ['category_id'],
      parentColumns: ['id'],
      entity: Category,
    )
  ],
)
class Product{
  @primaryKey
   int id;
   String title;
   String description;
   int price;
   String picture;
  @ColumnInfo(name: 'category_id')
   int categoryId;

  Product(
      this.id,
      this.title,
      this.description,
      this.price,
      this.picture,
      this.categoryId);

  factory Product.fromJson(Map<String, dynamic> json) {
    return new Product(
       json['id'],
       json['description'],
        json['title'],
        json['price'],
        json['picture'],
         json['category_id']);
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
    'id': id,
    'description': description,
    'title': title,
    'price': price,
    'picture': picture,
    'category_id': categoryId
  };

}
