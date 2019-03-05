import 'package:mobile_ecommerce/models/product.dart';
import 'package:scoped_model/scoped_model.dart';

class Cart extends Model {
  Map<int, Product> box=Map();

  Map<int, Product> get cart=> box;

void addToCart(Product product,int qte){
  this.box[qte]=product;
  notifyListeners();
}

void removeFromCart(Product product,int qte){
  this.box.remove(product);
  notifyListeners();
}

void updateFromCart(Product product,int qte){
  this.box.update(qte,(product)=>product);
  notifyListeners();
}
  
}
