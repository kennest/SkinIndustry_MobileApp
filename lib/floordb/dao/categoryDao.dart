import 'dart:async';
import 'package:floor/floor.dart';
import 'package:mobile_ecommerce/floordb/models/category.dart';

@dao
abstract class CategoryDao {
  @Query('SELECT * FROM Category')
  Future<List<Category>> findAllCategories();

  @Query('SELECT * FROM Category WHERE id = :id')
  Future<Category> findCategoryById(int id);

  @insert
  Future<void> insertCategory(Category category);
}