class User {
  String id;

  String name;

  static const String tableName = '_user';

  String toString() => "User($id, $name)";
}
