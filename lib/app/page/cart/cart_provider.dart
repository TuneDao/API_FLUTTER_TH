import 'package:flutter/foundation.dart';
import 'package:app_api/app/model/cart.dart';
import 'package:app_api/app/data/sqlite.dart';

class CartProvider extends ChangeNotifier {
  final DatabaseHelper _databaseHelper = DatabaseHelper();
  List<Cart> _products = [];

  List<Cart> get products => _products;

  CartProvider() {
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    _products = await _databaseHelper.products();
    notifyListeners();
  }

  void addProduct(Cart product) async {
    await _databaseHelper.insertProduct(product);
    await _loadProducts();
  }

  void removeProduct(int productId) async {
    await _databaseHelper.deleteProduct(productId);
    await _loadProducts();
  }

  void clearCart() async {
    await _databaseHelper.clear();
    await _loadProducts();
  }

  void decreaseProduct(Cart product) async {
    await _databaseHelper.minus(product);
    await _loadProducts();
  }

  int get itemCount => _products.length;
}
