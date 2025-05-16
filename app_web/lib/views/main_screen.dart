import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        title: const Text('Management Dashboard'),
        backgroundColor: Colors.blue,
      ),

      body: const Text('Dashboard'),
      sideBar: SideBar(
        items: [
          AdminMenuItem(
            title: 'Vendors',
            route: '',
            icon: CupertinoIcons.person_3,
          ),
          AdminMenuItem(
            title: 'Buyers',
            route: '',
            icon: CupertinoIcons.person,
          ),
          AdminMenuItem(
            title: 'Orders',
            route: '',
            icon: CupertinoIcons.shopping_cart,
          ),
          AdminMenuItem(
            title: 'Categories',
            route: '',
            icon: CupertinoIcons.square_list,
          ),
          AdminMenuItem(
            title: 'Upload Banners',
            route: '',
            icon: Icons.upload_file,
          ),

          AdminMenuItem(title: 'Products', route: '', icon: Icons.store),
        ],
        selectedRoute: '',
        onSelected: (item) {},
      ),
    );
  }
}
