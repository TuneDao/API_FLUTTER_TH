// import 'dart:convert';
// import 'package:app_api/app/data/sharepre.dart';
// import 'package:app_api/app/model/user.dart';
// import 'package:app_api/app/page/cart/cart_provider.dart';
// import 'package:app_api/app/page/cart/cart_screen.dart';
// import 'package:app_api/app/page/category/category_list.dart';
// import 'package:app_api/app/page/detail.dart';
// import 'package:app_api/app/page/history/history_screen.dart';
// import 'package:app_api/app/page/home/home_screen.dart';
// import 'package:app_api/app/page/product/product_list.dart';
// import 'package:app_api/app/route/page3.dart';
// import 'package:flutter/material.dart';
// import 'app/page/defaultwidget.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Mainpage extends StatefulWidget {
//   const Mainpage({super.key});

//   @override
//   State<Mainpage> createState() => _MainpageState();
// }

// class _MainpageState extends State<Mainpage> {
//   User user = User.userEmpty();
//   int _selectedIndex = 0;

//   getDataUser() async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     String strUser = pref.getString('user')!;

//     user = User.fromJson(jsonDecode(strUser));
//     setState(() {});
//   }

//   @override
//   void initState() {
//     super.initState();
//     getDataUser();
//   }

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   _loadWidget(int index) {
//     var nameWidgets = "Home";
//     switch (index) {
//       case 0:
//         {
//           return HomeBuilder();
//         }
//       case 1:
//         {
//           return HistoryScreen();
//         }
//       case 2:
//         {
//           return CartScreen();
//         }
//       case 3:
//         {
//           return const Detail();
//         }
//       case 4:
//         {
//           return const Page3();
//         }
//       default:
//         nameWidgets = "None";
//         break;
//     }
//     return DefaultWidget(title: nameWidgets);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 48, 210, 228),
//         title: const Text(
//           "HL Mobile",
//           style: TextStyle(color: Colors.white),
//         ),
//         actions: [
//           InkWell(
//             onTap: () {
//               _onItemTapped(2);
//             },
//             child: const Padding(
//               padding: EdgeInsets.only(left: 0, right: 15, top: 8, bottom: 8),
//               child: Stack(
//                 children: [
//                   Align(
//                     alignment: Alignment.bottomCenter,
//                     child: Icon(
//                       Icons.shopping_bag,
//                       size: 24,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: [
//             DrawerHeader(
//               decoration: const BoxDecoration(
//                 color: Color.fromARGB(255, 121, 11, 255),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   user.imageURL!.length < 5
//                       ? const SizedBox()
//                       : CircleAvatar(
//                           radius: 40,
//                           backgroundImage: NetworkImage(
//                             user.imageURL!,
//                           )),
//                   const SizedBox(
//                     height: 8,
//                   ),
//                   Text(
//                     user.fullName!,
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                 ],
//               ),
//             ),
//             ListTile(
//               leading: const Icon(Icons.home, color: Colors.blue),
//               title: const Text('Home'),
//               onTap: () {
//                 Navigator.pop(context);
//                 _selectedIndex = 0;
//                 setState(() {});
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.contact_mail, color: Colors.blue),
//               title: const Text('History'),
//               onTap: () {
//                 Navigator.pop(context);
//                 _selectedIndex = 1;
//                 setState(() {});
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.shop, color: Colors.blue),
//               title: const Text('Cart'),
//               onTap: () {
//                 Navigator.pop(context);
//                 _selectedIndex = 2;
//                 setState(() {});
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.category, color: Colors.blue),
//               title: const Text('Category'),
//               onTap: () {
//                 Navigator.pop(context);
//                 _selectedIndex = 0;
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const CategoryList()));
//               },
//             ),
//             ListTile(
//               leading: const Icon(Icons.shopping_basket, color: Colors.blue),
//               title: const Text('Product'),
//               onTap: () {
//                 Navigator.pop(context);
//                 _selectedIndex = 0;
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => const ProductList()));
//               },
//             ),
//             const Divider(
//               color: Colors.black,
//             ),
//             user.accountId == ''
//                 ? const SizedBox()
//                 : ListTile(
//                     leading: const Icon(Icons.exit_to_app, color: Colors.blue),
//                     title: const Text('Logout'),
//                     onTap: () {
//                       logOut(context);
//                     },
//                   ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.history),
//             label: 'History',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.shop),
//             label: 'Cart',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person),
//             label: 'User',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search),
//             label: 'Search',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: Colors.amber[800],
//         unselectedItemColor: Colors.grey,
//         onTap: _onItemTapped,
//       ),
//       body: _loadWidget(_selectedIndex),
//     );
//   }
// }
import 'dart:convert';
import 'package:app_api/app/data/sharepre.dart';
import 'package:app_api/app/model/user.dart';
import 'package:app_api/app/page/cart/cart_provider.dart';
import 'package:app_api/app/page/cart/cart_screen.dart';
import 'package:app_api/app/page/category/category_list.dart';
import 'package:app_api/app/page/detail.dart';
import 'package:app_api/app/page/history/history_screen.dart';
import 'package:app_api/app/page/home/home_screen.dart';
import 'package:app_api/app/page/product/product_list.dart';
import 'package:app_api/app/route/page3.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app/page/defaultwidget.dart';

class Mainpage extends StatefulWidget {
  const Mainpage({super.key});

  @override
  State<Mainpage> createState() => _MainpageState();
}

class _MainpageState extends State<Mainpage> {
  User user = User.userEmpty();
  int _selectedIndex = 0;

  getDataUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String strUser = pref.getString('user')!;

    user = User.fromJson(jsonDecode(strUser));
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getDataUser();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  _loadWidget(int index) {
    var nameWidgets = "Home";
    switch (index) {
      case 0:
        {
          return HomeBuilder();
        }
      case 1:
        {
          return HistoryScreen();
        }
      case 2:
        {
          return CartScreen();
        }
      case 3:
        {
          return const Detail();
        }
      case 4:
        {
          return const Page3();
        }
      default:
        nameWidgets = "None";
        break;
    }
    return DefaultWidget(title: nameWidgets);
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 48, 210, 228),
        title: const Text(
          "HL Mobile",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          InkWell(
            onTap: () {
              _onItemTapped(2);
            },
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 0, right: 15, top: 8, bottom: 8),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Icon(
                      Icons.shopping_bag,
                      size: 24,
                    ),
                  ),
                  if (cartProvider.itemCount > 0)
                    Align(
                      alignment: Alignment.topRight,
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Colors.red,
                        child: Text(
                          '${cartProvider.itemCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 121, 11, 255),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  user.imageURL!.length < 5
                      ? const SizedBox()
                      : CircleAvatar(
                          radius: 40,
                          backgroundImage: NetworkImage(
                            user.imageURL!,
                          )),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    user.fullName!,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: Colors.blue),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 0;
                setState(() {});
              },
            ),
            ListTile(
              leading: const Icon(Icons.contact_mail, color: Colors.blue),
              title: const Text('History'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 1;
                setState(() {});
              },
            ),
            ListTile(
              leading: const Icon(Icons.shop, color: Colors.blue),
              title: const Text('Cart'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 2;
                setState(() {});
              },
            ),
            ListTile(
              leading: const Icon(Icons.category, color: Colors.blue),
              title: const Text('Category'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 0;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CategoryList()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.shopping_basket, color: Colors.blue),
              title: const Text('Product'),
              onTap: () {
                Navigator.pop(context);
                _selectedIndex = 0;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProductList()));
              },
            ),
            const Divider(
              color: Colors.black,
            ),
            user.accountId == ''
                ? const SizedBox()
                : ListTile(
                    leading: const Icon(Icons.exit_to_app, color: Colors.blue),
                    title: const Text('Logout'),
                    onTap: () {
                      logOut(context);
                    },
                  ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'User',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
      body: _loadWidget(_selectedIndex),
    );
  }
}
