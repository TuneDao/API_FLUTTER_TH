import 'package:app_api/app/data/api.dart';
import 'package:app_api/app/data/sqlite.dart';
import 'package:app_api/app/model/cart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  Future<List<Cart>> _getProducts() async {
    return await _databaseHelper.products();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Cart List"),
        Expanded(
          flex: 11,
          child: FutureBuilder<List<Cart>>(
            future: _getProducts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.data == null || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text("No items in the cart"),
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final itemProduct = snapshot.data![index];
                    return _buildProduct(itemProduct, context);
                  },
                ),
              );
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                List<Cart> temp = await _databaseHelper.products();
                await APIRepository()
                    .addBill(temp, pref.getString('token').toString());
                _databaseHelper.clear();
                setState(() {});
              },
              child: const Text("Payment"),
            ),
            ElevatedButton(
              onPressed: () async {
                await _databaseHelper.clear();
                setState(() {});
              },
              child: const Text("Clear All"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildProduct(Cart pro, BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(pro.img),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pro.name,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    NumberFormat('#,##0').format(pro.price),
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.red,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text('Count: ${pro.count}'),
                  Text('Description: ${pro.des}'),
                ],
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _databaseHelper.minus(pro);
                });
              },
              icon: Icon(
                Icons.remove,
                color: Colors.yellow.shade800,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _databaseHelper.deleteProduct(pro.productID);
                });
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _databaseHelper.add(pro);
                });
              },
              icon: Icon(
                Icons.add,
                color: Colors.yellow.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
