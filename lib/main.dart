import 'package:flutter/material.dart';

void main() {
  runApp(const KgnTawaFryApp());
}

class KgnTawaFryApp extends StatelessWidget {
  const KgnTawaFryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KGN TAWA FRY',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
        ),
        scaffoldBackgroundColor: const Color(0xFFFFF8F0),
      ),
      home: const DashboardPage(),
    );
  }
}

/* =========================
   MENU DATA
========================= */

class MenuItemData {
  final String name;
  final String category;
  final double price;
  final double? halfPrice;

  const MenuItemData({
    required this.name,
    required this.category,
    required this.price,
    this.halfPrice,
  });
}

const List<MenuItemData> menuItems = [
  // CHICKEN
  MenuItemData(
    name: 'Murgh Do Pyaza',
    category: 'Chicken',
    halfPrice: 160,
    price: 300,
  ),
  MenuItemData(
    name: 'Murgh Mughlai',
    category: 'Chicken',
    halfPrice: 170,
    price: 320,
  ),
  MenuItemData(
    name: 'Chicken Handi',
    category: 'Chicken',
    halfPrice: 160,
    price: 300,
  ),
  MenuItemData(
    name: 'Chicken Peshawar',
    category: 'Chicken',
    halfPrice: 170,
    price: 320,
  ),
  MenuItemData(
    name: 'Shahi Chicken',
    category: 'Chicken',
    halfPrice: 170,
    price: 320,
  ),
  MenuItemData(
    name: 'Malai Tikka',
    category: 'Chicken',
    halfPrice: 180,
    price: 350,
  ),
  MenuItemData(
    name: 'Tikka Masala',
    category: 'Chicken',
    halfPrice: 170,
    price: 320,
  ),
  MenuItemData(
    name: 'Karahi',
    category: 'Chicken',
    halfPrice: 160,
    price: 300,
  ),
  MenuItemData(
    name: 'Garlic Chicken',
    category: 'Chicken',
    halfPrice: 160,
    price: 300,
  ),
  MenuItemData(
    name: 'Chicken India',
    category: 'Chicken',
    halfPrice: 250,
    price: 450,
  ),
  MenuItemData(
    name: 'Butter Chicken Boneless',
    category: 'Chicken',
    halfPrice: 170,
    price: 320,
  ),
  MenuItemData(
    name: 'White Chicken',
    category: 'Chicken',
    halfPrice: 180,
    price: 350,
  ),
  MenuItemData(
    name: 'Green Chicken',
    category: 'Chicken',
    halfPrice: 180,
    price: 350,
  ),
  MenuItemData(
    name: 'Chicken Fry',
    category: 'Chicken',
    halfPrice: 120,
    price: 220,
  ),
  MenuItemData(
    name: 'Chicken Masala',
    category: 'Chicken',
    halfPrice: 120,
    price: 220,
  ),
  MenuItemData(
    name: 'Biryani',
    category: 'Chicken',
    halfPrice: 80,
    price: 120,
  ),
  MenuItemData(
    name: 'Tandoori Masala',
    category: 'Chicken',
    halfPrice: 250,
    price: 480,
  ),
  MenuItemData(
    name: 'Ahmedabad Masala',
    category: 'Chicken',
    halfPrice: 160,
    price: 320,
  ),
  MenuItemData(
    name: 'Tikka Rice',
    category: 'Chicken',
    halfPrice: 170,
    price: 320,
  ),

  // MUTTON
  MenuItemData(
    name: 'Mughlai Mutton',
    category: 'Mutton',
    halfPrice: 150,
    price: 280,
  ),
  MenuItemData(
    name: 'Dalbati Gos',
    category: 'Mutton',
    halfPrice: 150,
    price: 280,
  ),
  MenuItemData(
    name: 'White Mutton',
    category: 'Mutton',
    halfPrice: 160,
    price: 300,
  ),
  MenuItemData(
    name: 'Green Mutton',
    category: 'Mutton',
    halfPrice: 150,
    price: 280,
  ),
  MenuItemData(
    name: 'Mutton Kurma',
    category: 'Mutton',
    halfPrice: 160,
    price: 300,
  ),
  MenuItemData(
    name: 'Mutton Fry',
    category: 'Mutton',
    halfPrice: 120,
    price: 220,
  ),
  MenuItemData(
    name: 'Mutton Masala',
    category: 'Mutton',
    halfPrice: 120,
    price: 220,
  ),
  MenuItemData(
    name: 'Kaleji Masala',
    category: 'Mutton',
    halfPrice: 120,
    price: 220,
  ),
  MenuItemData(
    name: 'Bhaji Gos',
    category: 'Mutton',
    halfPrice: 130,
    price: 240,
  ),
  MenuItemData(
    name: 'Paya Fry',
    category: 'Mutton',
    halfPrice: 120,
    price: 220,
  ),

  // FISH
  MenuItemData(
    name: 'Chaap Fry',
    category: 'Fish',
    halfPrice: 120,
    price: 220,
  ),
  MenuItemData(
    name: 'Bheja Fry',
    category: 'Fish',
    halfPrice: 130,
    price: 240,
  ),
  MenuItemData(
    name: 'Boti Masala',
    category: 'Fish',
    halfPrice: 120,
    price: 220,
  ),
  MenuItemData(
    name: 'Kheema Fry',
    category: 'Fish',
    halfPrice: 80,
    price: 160,
  ),
  MenuItemData(
    name: 'Kheema Pulao',
    category: 'Fish',
    halfPrice: 100,
    price: 180,
  ),
  MenuItemData(
    name: 'Fish Fry',
    category: 'Fish',
    halfPrice: 80,
    price: 160,
  ),
  MenuItemData(
    name: 'Fish Kadhi',
    category: 'Fish',
    halfPrice: 100,
    price: 200,
  ),
  MenuItemData(
    name: 'Zinga Fry',
    category: 'Fish',
    halfPrice: 130,
    price: 240,
  ),
  MenuItemData(
    name: 'Zinga Rice',
    category: 'Fish',
    halfPrice: 170,
    price: 320,
  ),

  // EGG
  MenuItemData(
    name: 'Anda Kadhi',
    category: 'Egg',
    halfPrice: 80,
    price: 160,
  ),
  MenuItemData(
    name: 'Anda Kheema',
    category: 'Egg',
    halfPrice: 80,
    price: 160,
  ),
  MenuItemData(
    name: 'Anda Bhurji',
    category: 'Egg',
    halfPrice: 50,
    price: 100,
  ),
  MenuItemData(
    name: 'Anda Pulao',
    category: 'Egg',
    halfPrice: 60,
    price: 120,
  ),

  // VEG
  MenuItemData(
    name: 'Dal Tadka',
    category: 'Veg',
    halfPrice: 70,
    price: 140,
  ),
  MenuItemData(
    name: 'Dal Gotala',
    category: 'Veg',
    halfPrice: 80,
    price: 160,
  ),
  MenuItemData(
    name: 'Butter Dal Fry',
    category: 'Veg',
    halfPrice: 70,
    price: 140,
  ),
  MenuItemData(
    name: 'Dal Fry',
    category: 'Veg',
    halfPrice: 50,
    price: 100,
  ),
  MenuItemData(
    name: 'Sabji Fry',
    category: 'Veg',
    halfPrice: 50,
    price: 100,
  ),
  MenuItemData(
    name: 'Sev Tomato',
    category: 'Veg',
    halfPrice: 50,
    price: 100,
  ),
  MenuItemData(
    name: 'Masala Rice',
    category: 'Veg',
    halfPrice: 50,
    price: 100,
  ),
  MenuItemData(
    name: 'Jeera Rice',
    category: 'Veg',
    halfPrice: 50,
    price: 100,
  ),
  MenuItemData(
    name: 'Kadhi Khichdi',
    category: 'Veg',
    halfPrice: 30,
    price: 60,
  ),
  MenuItemData(
    name: 'Dal Pulav',
    category: 'Veg',
    halfPrice: 50,
    price: 100,
  ),
  MenuItemData(
    name: 'Plain Rice',
    category: 'Veg',
    halfPrice: 50,
    price: 100,
  ),

  // ROTI
  MenuItemData(
    name: 'Special Roti',
    category: 'Roti',
    price: 15,
  ),
  MenuItemData(
    name: 'Special Paratha',
    category: 'Roti',
    price: 20,
  ),
  MenuItemData(
    name: 'Butter Roti',
    category: 'Roti',
    price: 15,
  ),
  MenuItemData(
    name: 'Chapati Roti',
    category: 'Roti',
    price: 7,
  ),
  MenuItemData(
    name: 'Papad Fry',
    category: 'Roti',
    price: 10,
  ),

  // STARTERS
  MenuItemData(
    name: 'Chicken Tandoori',
    category: 'Starter',
    halfPrice: 180,
    price: 350,
  ),
  MenuItemData(
    name: 'Chicken Leg Piece',
    category: 'Starter',
    price: 100,
  ),
  MenuItemData(
    name: 'Chicken Lollipop',
    category: 'Starter',
    price: 50,
  ),
  MenuItemData(
    name: 'Chicken Tikka Stick',
    category: 'Starter',
    price: 10,
  ),
  MenuItemData(
    name: 'Chicken Crispy',
    category: 'Starter',
    price: 20,
  ),
  MenuItemData(
    name: 'Chicken Hyderabadi',
    category: 'Starter',
    price: 20,
  ),
  MenuItemData(
    name: 'Chicken Cutlets',
    category: 'Starter',
    price: 10,
  ),
  MenuItemData(
    name: 'Chicken Egg Kabab',
    category: 'Starter',
    price: 10,
  ),
  MenuItemData(
    name: 'Mutton Seekh Kabab',
    category: 'Starter',
    price: 10,
  ),
  MenuItemData(
    name: 'Mutton Boti Kabab',
    category: 'Starter',
    price: 10,
  ),
  MenuItemData(
    name: 'Chicken Dana Small',
    category: 'Starter',
    price: 50,
  ),
  MenuItemData(
    name: 'Chicken Dana Large',
    category: 'Starter',
    price: 100,
  ),
];

/* =========================
   ORDER CART
========================= */

class CartItem {
  final MenuItemData item;
  int quantity;

  CartItem({
    required this.item,
    this.quantity = 1,
  });

  double get total => item.price * quantity;
}

/* =========================
   DASHBOARD
========================= */

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<CartItem> cart = [];

  int selectedIndex = 0;

  void addToCart(MenuItemData item) {
    setState(() {
      final existing = cart.where((x) => x.item.name == item.name);

      if (existing.isNotEmpty) {
        existing.first.quantity++;
      } else {
        cart.add(CartItem(item: item));
      }
    });
  }

  double get total {
    return cart.fold(0, (sum, item) => sum + item.total);
  }

  void openPage(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'KGN TAWA FRY',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Badge(
              label: Text('${cart.length}'),
              child: const Icon(Icons.shopping_cart),
            ),
            onPressed: () {
              openPage(
                BillingPage(
                  cart: cart,
                  onChanged: () => setState(() {}),
                ),
              );
            },
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: _buildDashboard(),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.deepOrange,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(
                  Icons.restaurant,
                  color: Colors.white,
                  size: 45,
                ),
                SizedBox(height: 10),
                Text(
                  'KGN TAWA FRY',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Restaurant Management',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard),
            title: const Text('Dashboard'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.receipt_long),
            title: const Text('Billing'),
            onTap: () {
              Navigator.pop(context);
              openPage(
                BillingPage(
                  cart: cart,
                  onChanged: () => setState(() {}),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.soup_kitchen),
            title: const Text('KOT Management'),
            onTap: () {
              Navigator.pop(context);
              openPage(const KotPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.table_restaurant),
            title: const Text('Table Management'),
            onTap: () {
              Navigator.pop(context);
              openPage(const TablesPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.restaurant_menu),
            title: const Text('Menu Management'),
            onTap: () {
              Navigator.pop(context);
              openPage(const MenuPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.inventory_2),
            title: const Text('Inventory'),
            onTap: () {
              Navigator.pop(context);
              openPage(const InventoryPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.money_off),
            title: const Text('Expenses'),
            onTap: () {
              Navigator.pop(context);
              openPage(const ExpensesPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text('Reports'),
            onTap: () {
              Navigator.pop(context);
              openPage(const ReportsPage());
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Staff / Waiter'),
            onTap: () {
              Navigator.pop(context);
              openPage(const StaffPage());
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              openPage(const SettingsPage());
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDashboard() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Good Evening 👋',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Manage your restaurant quickly and easily.',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: _statCard(
                  'Today Sales',
                  '₹0',
                  Icons.currency_rupee,
                  Colors.green,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _statCard(
                  'Orders',
                  '0',
                  Icons.receipt_long,
                  Colors.blue,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Expanded(
                child: _statCard(
                  'KOT Pending',
                  '0',
                  Icons.soup_kitchen,
                  Colors.orange,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _statCard(
                  'Tables',
                  '20',
                  Icons.table_restaurant,
                  Colors.purple,
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.4,
            children: [
              _actionCard(
                'New Order',
                Icons.add_shopping_cart,
                Colors.deepOrange,
                () => openPage(
                  BillingPage(
                    cart: cart,
                    onChanged: () => setState(() {}),
                  ),
                ),
              ),
              _actionCard(
                'KOT',
                Icons.soup_kitchen,
                Colors.orange,
                () => openPage(const KotPage()),
              ),
              _actionCard(
                'Tables',
                Icons.table_restaurant,
                Colors.blue,
                () => openPage(const TablesPage()),
              ),
              _actionCard(
                'Reports',
                Icons.bar_chart,
                Colors.green,
                () => openPage(const ReportsPage()),
              ),
            ],
          ),

          const SizedBox(height: 25),

          Card(
            child: ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ),
              title: const Text(
                'No GST Billing',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text(
                'GST is disabled for KGN TAWA FRY.',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionCard(
    String title,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 35, color: color),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* =========================
   BILLING
========================= */

class BillingPage extends StatefulWidget {
  final List<CartItem> cart;
  final VoidCallback onChanged;

  const BillingPage({
    super.key,
    required this.cart,
    required this.onChanged,
  });

  @override
  State<BillingPage> createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  String orderType = 'Dine-in';
  String payment = 'Cash';
  double discount = 0;

  double get subtotal {
    return widget.cart.fold(
      0,
      (sum, item) => sum + item.total,
    );
  }

  double get finalTotal {
    final value = subtotal - discount;
    return value < 0 ? 0 : value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Billing'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: orderType,
                    decoratio
