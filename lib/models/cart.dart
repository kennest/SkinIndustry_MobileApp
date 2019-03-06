import 'package:mobile_ecommerce/models/product.dart';
import 'package:scoped_model/scoped_model.dart';

class Cart extends Model {
  //Map<int, Product> box=Map();
  Map<int, Map<int,Product>> Hbox=Map();

 // Map<int, Product> get cart=> box;
  Map<int, Map<int,Product>> get Hcart=>Hbox;

void addToCart(Product product,int qte){
  //this.box[qte]=product;
  var box = {qte: product};
  this.Hbox[product.id]=box;
  notifyListeners();
}

void removeFromCart(Product product,int qte){
  //this.box.remove(product);
  this.Hbox.remove(product.id);
  notifyListeners();
}

void updateFromCart(Product product,int qte){
  //this.box.update(qte,(product)=>product);
  notifyListeners();
}
  
}
