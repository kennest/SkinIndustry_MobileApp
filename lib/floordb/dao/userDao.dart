import 'package:floor/floor.dart';
import 'package:mobile_ecommerce/floordb/models/user.dart';

@dao
abstract class UserDao {
  @Query('SELECT * FROM User')
  Future<List<User>> findAllUsers();

  @Query('SELECT * FROM User WHERE id = :id')
  Future<User> findUserById(int id);

  @insert
  Future<void> insertUser(User user);
}