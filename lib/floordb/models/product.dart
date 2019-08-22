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
  final int id;
  final String title;
  final String description;
  final int price;
  final String picture;
  @ColumnInfo(name: 'category_id')
  final int categoryId;


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
