import 'package:flutter/material.dart';

void main() {
  runApp(const KgnTavaFryApp());
}

class KgnTavaFryApp extends StatelessWidget {
  const KgnTavaFryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KGN TAVA FRY',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepOrange,
        scaffoldBackgroundColor: const Color(0xFFF7F7F7),
      ),
      home: const HomePage(),
    );
  }
}

// ============================================================
// MODELS
// ============================================================

class MenuItem {
  final String name;
  final String category;
  final double price;

  const MenuItem({
    required this.name,
    required this.category,
    required this.price,
  });
}

class CartItem {
  final MenuItem item;
  int quantity;

  CartItem({
    required this.item,
    this.quantity = 1,
  });

  double get total => item.price * quantity;
}

// ============================================================
// SAMPLE MENU
// ============================================================

const List<MenuItem> menuItems = [
  MenuItem(name: 'Chicken Tawa Fry', category: 'Non-Veg', price: 220),
  MenuItem(name: 'Chicken Handi', category: 'Non-Veg', price: 280),
  MenuItem(name: 'Chicken Biryani', category: 'Biryani', price: 180),
  MenuItem(name: 'Mutton Biryani', category: 'Biryani', price: 260),
  MenuItem(name: 'Chicken Tikka', category: 'Tandoor', price: 240),
  MenuItem(name: 'Paneer Tikka', category: 'Veg', price: 180),
  MenuItem(name: 'Paneer Butter Masala', category: 'Veg', price: 190),
  MenuItem(name: 'Dal Tadka', category: 'Veg', price: 130),
  MenuItem(name: 'Butter Naan', category: 'Roti', price: 40),
  MenuItem(name: 'Tandoori Roti', category: 'Roti', price: 25),
  MenuItem(name: 'Garlic Naan', category: 'Roti', price: 60),
  MenuItem(name: 'Cold Drink', category: 'Drinks', price: 40),
  MenuItem(name: 'Mineral Water', category: 'Drinks', price: 20),
];

// ============================================================
// HOME
// ============================================================

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final List<Widget> pages = const [
    DashboardPage(),
    BillingPage(),
    KotPage(),
    TablesPage(),
    MorePage(),
  ];

  final List<String> titles = const [
    'KGN TAVA FRY',
    'Billing',
    'Kitchen KOT',
    'Tables',
    'More',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[currentIndex],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: pages[currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'Billing',
          ),
          NavigationDestination(
            icon: Icon(Icons.soup_kitchen_outlined),
            selectedIcon: Icon(Icons.soup_kitchen),
            label: 'KOT',
          ),
          NavigationDestination(
            icon: Icon(Icons.table_restaurant_outlined),
            selectedIcon: Icon(Icons.table_restaurant),
            label: 'Tables',
          ),
          NavigationDestination(
            icon: Icon(Icons.more_horiz),
            label: 'More',
          ),
        ],
      ),
    );
  }
}

// ============================================================
// DASHBOARD
// ============================================================

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Today Overview',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: DashboardCard(
                  title: 'Sales',
                  value: '₹12,450',
                  icon: Icons.currency_rupee,
                ),
              ),
              const SizedBox(width: 12),
              Expanded
