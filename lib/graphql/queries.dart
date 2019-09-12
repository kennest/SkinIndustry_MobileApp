const String createCategory = r'''
  mutation addCategory($label:String!){
  createCategory(label:$label){label}
}
''';

const String AllCategories = r'''
 {
  allCategories {
    label
    products {
      id
      label
      price
      quantity
    }
  }
}
''';

const String createProduct = r'''
mutation {
  createProduct(label: $label, price: $price, quantity: $quantity) {
    id
    label
    price
    quantity
  }
}
''';

const String addProductToCategory = r'''
mutation {
  addToCategoryOnProduct(productsProductId: "$product_id", categoryCategoryId: "$category_id") {
    productsProduct {
      id
    }
    categoryCategory {
      id
    }
  }
}
''';

const String AllProducts = r'''
{
  allProducts {
    label
    price
    category {
      id
      label
    }
  }
}
''';

const String AllSells=r'''
{
  allSells {
    id
  }
}
''';

const String createClient=r'''
mutation addClient($email:String!,$password:String!){
  createClient(email: "$email", password: "$password") {
    id
  }
}
''';
