import 'package:mobile_ecommerce/floordb/models/product.dart';
import 'package:scoped_model/scoped_model.dart';

class Cart extends Model {
  //Map<int, Product> box=Map();
  Map<int, Map<int,Product>> hBox=Map();

void addToCart(Product product,int qte){
  //this.box[qte]=product;
  var box = {qte: product};
  this.hBox[product.id]=box;
  notifyListeners();
}

void removeFromCart(Product product,int qte){
  //this.box.remove(product);
  this.hBox.remove(product.id);
  notifyListeners();
}

void updateFromCart(Product product,int qte){
  //this.box.update(qte,(product)=>product);
  notifyListeners();
}
  
}
