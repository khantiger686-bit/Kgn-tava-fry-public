import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';

void main() { runApp(const TableByKgnApp()); }

class TableByKgnApp extends StatelessWidget {
  const TableByKgnApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Table by Kgn PRO',
      theme: ThemeData(primarySwatch: Colors.deepOrange, useMaterial3: true),
      home: const BillingPOSScreen(),
    );
  }
}

class MenuItem {
  final String id; final String name; final double price; final String category;
  MenuItem({required this.id, required this.name, required this.price, required this.category});
}

class CartItem {
  final MenuItem item; int quantity;
  CartItem({required this.item, this.quantity = 1});
  double get total => item.price * quantity;
}

class BillingPOSScreen extends StatefulWidget {
  const BillingPOSScreen({super.key});
  @override
  State<BillingPOSScreen> createState() => _BillingPOSScreenState();
}

class _BillingPOSScreenState extends State<BillingPOSScreen> {
  final List<String> tables = ['T-01', 'T-02', 'T-03', 'T-04', 'T-05', 'Takeaway'];
  String selectedTable = 'T-01';
  String selectedCategory = 'All';
  double todaySale = 0.0;

  final List<String> categories = ['All', 'Main Course', 'Breads', 'Chinese', 'Beverages', 'Desserts'];

  final List<MenuItem> menuItems = [
    MenuItem(id: '1', name: 'Paneer Butter Masala', price: 260, category: 'Main Course'),
    MenuItem(id: '2', name: 'Butter Naan', price: 40, category: 'Breads'),
    MenuItem(id: '3', name: 'Chicken Biryani', price: 290, category: 'Main Course'),
    MenuItem(id: '4', name: 'Veg Fried Rice', price: 180, category: 'Chinese'),
    MenuItem(id: '5', name: 'Cold Coffee', price: 120, category: 'Beverages'),
    MenuItem(id: '6', name: 'Gulab Jamun (2 Pcs)', price: 80, category: 'Desserts'),
  ];

  List<CartItem> cart = [];
  double discountPercentage = 0.0;
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  double get subtotal => cart.fold(0, (s, i) => s + i.total);
  double get discountAmount => (subtotal * discountPercentage) / 100;
  double get finalTotal => subtotal - discountAmount;

  List<MenuItem> get filteredMenu {
    if(selectedCategory == 'All') return menuItems;
    return menuItems.where((m) => m.category == selectedCategory).toList();
  }

  void addToCart(MenuItem item) {
    setState(() {
      int index = cart.indexWhere((c) => c.item.id == item.id);
      if(index!= -1) cart[index].quantity++; else cart.add(CartItem(item: item));
    });
  }

  void updateQuantity(int index, int delta) {
    setState(() {
      cart[index].quantity += delta;
      if(cart[index].quantity <= 0) cart.removeAt(index);
    });
  }

  void printKOT() {
