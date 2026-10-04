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
        colorSchemeSeed: Colors.deepOrange,
        scaffoldBackgroundColor: const Color(0xFFFFF8F3),
      ),
      home: const DashboardPage(),
    );
  }
}

// ==================== MENU DATA ====================

class MenuItemData {
  final String name;
  final String category;
  final int half;
  final int full;

  const MenuItemData({
    required this.name,
    required this.category,
    required this.half,
    required this.full,
  });
}

const menuItems = <MenuItemData>[
  MenuItemData(name: 'Murgh Do Pyaza', category: 'Chicken', half: 160, full: 300),
  MenuItemData(name: 'Murgh Mughlai', category: 'Chicken', half: 170, full: 320),
  MenuItemData(name: 'Chicken Handi', category: 'Chicken', half: 160, full: 300),
  MenuItemData(name: 'Chicken Peshawar', category: 'Chicken', half: 170, full: 320),
  MenuItemData(name: 'Shahi Chicken', category: 'Chicken', half: 170, full: 320),
  MenuItemData(name: 'Malai Tikka', category: 'Chicken', half: 180, full: 350),
  MenuItemData(name: 'Tikka Masala', category: 'Chicken', half: 170, full: 320),
  MenuItemData(name: 'Karahi', category: 'Chicken', half: 160, full: 300),
  MenuItemData(name: 'Garlic Chicken', category: 'Chicken', half: 160, full: 300),
  MenuItemData(name: 'Chicken India', category: 'Chicken', half: 250, full: 450),
  MenuItemData(name: 'Butter Chicken Boneless', category: 'Chicken', half: 170, full: 320),
  MenuItemData(name: 'White Chicken', category: 'Chicken', half: 180, full: 350),
  MenuItemData(name: 'Green Chicken', category: 'Chicken', half: 180, full: 350),
  MenuItemData(name: 'Chicken Fry', category: 'Chicken', half: 120, full: 220),
  MenuItemData(name: 'Chicken Masala', category: 'Chicken', half: 120, full: 220),
  MenuItemData(name: 'Biryani', category: 'Biryani', half: 80, full: 120),
  MenuItemData(name: 'Tandoori Masala', category: 'Chicken', half: 250, full: 480),
  MenuItemData(name: 'Ahmedabad Masala', category: 'Chicken', half: 160, full: 320),
  MenuItemData(name: 'Tikka Rice', category: 'Rice', half: 170, full: 320),

  MenuItemData(name: 'Mughlai Mutton', category: 'Mutton', half: 150, full: 280),
  MenuItemData(name: 'Dalbati Gos', category: 'Mutton', half: 150, full: 280),
  MenuItemData(name: 'White Mutton', category: 'Mutton', half: 160, full: 300),
  MenuItemData(name: 'Green Mutton', category: 'Mutton', half: 150, full: 280),
  MenuItemData(name: 'Mutton Kurma', category: 'Mutton', half: 160, full: 300),
  MenuItemData(name: 'Mutton Fry', category: 'Mutton', half: 120, full: 220),
  MenuItemData(name: 'Mutton Masala', category: 'Mutton', half: 120, full: 220),
  MenuItemData(name: 'Kaleji Masala', category: 'Mutton', half: 120, full: 220),
  MenuItemData(name: 'Bhaji Gos', category: 'Mutton', half: 130, full: 240),
  MenuItemData(name: 'Paya Fry', category: 'Mutton', half: 120, full: 220),

  MenuItemData(name: 'Chaap Fry', category: 'Fish', half: 120, full: 220),
  MenuItemData(name: 'Bheja Fry', category: 'Fish', half: 130, full: 240),
  MenuItemData(name: 'Boti Masala', category: 'Fish', half: 120, full: 220),
  MenuItemData(name: 'Kheema Fry', category: 'Fish', half: 80, full: 160),
  MenuItemData(name: 'Kheema Pulao', category: 'Rice', half: 100, full: 180),
  MenuItemData(name: 'Fish Fry', category: 'Fish', half: 80, full: 160),
  MenuItemData(name: 'Fish Kadhi', category: 'Fish', half: 100, full: 200),
  MenuItemData(name: 'Zinga Fry', category: 'Fish', half: 130, full: 240),
  MenuItemData(name: 'Zinga Rice', category: 'Rice', half: 170, full: 320),

  MenuItemData(name: 'Anda Kadhi', category: 'Egg', half: 80, full: 160),
  MenuItemData(name: 'Anda Kheema', category: 'Egg', half: 80, full: 160),
  MenuItemData(name: 'Anda Bhurji', category: 'Egg', half: 50, full: 100),
  MenuItemData(name: 'Anda Pulao', category: 'Egg', half: 60, full: 120),

  MenuItemData(name: 'Dal Tadka', category: 'Veg', half: 70, full: 140),
  MenuItemData(name: 'Dal Gotala', category: 'Veg', half: 80, full: 160),
  MenuItemData(name: 'Butter Dal Fry', category: 'Veg', half: 70, full: 140),
  MenuItemData(name: 'Dal Fry', category: 'Veg', half: 50, full: 100),
  MenuItemData(name: 'Sabji Fry', category: 'Veg', half: 50, full: 100),
  MenuItemData(name: 'Sev Tomato', category: 'Veg', half: 50, full: 100),
  MenuItemData(name: 'Masala Rice', category: 'Rice', half: 50, full: 100),
  MenuItemData(name: 'Jeera Rice', category: 'Rice', half: 50, full: 100),
  MenuItemData(name: 'Khichdi', category: 'Veg', half: 30, full: 60),
  MenuItemData(name: 'Dal Palak', category: 'Veg', half: 50, full: 100),
  MenuItemData(name: 'Plain Rice', category: 'Rice', half: 50, full: 100),
];

// ==================== DASHBOARD ====================

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'KGN TAWA FRY - Admin',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Smart Restaurant Billing',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 6),
          const Text(
            'Billing • KOT • Orders • Tables • Reports',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 20),

          _menuButton(
            context,
            Icons.table_restaurant,
            'Tables',
            'Dine-in table management',
            const TablesPage(),
          ),

          _menuButton(
            context,
            Icons.receipt_long,
            'New Order / Billing',
            'Create restaurant bills',
            const BillingPage(),
          ),

          _menuButton(
            context,
            Icons.restaurant_menu,
            'Menu',
            'Chicken, Mutton, Fish, Egg & Veg',
            const MenuPage(),
          ),

          _menuButton(
            context,
            Icons.soup_kitchen,
            'KOT Management',
            'Kitchen order tickets',
            const KotPage(),
          ),

          _menuButton(
            context,
            Icons.bar_chart,
            'Reports',
            'Sales and business summary',
            const ReportsPage(),
          ),

          _menuButton(
            context,
            Icons.account_balance_wallet,
            'Expenses',
            'Daily expense tracking',
            const ExpensePage(),
          ),

          _menuButton(
            context,
            Icons.inventory_2,
            'Inventory',
            'Stock management',
            const InventoryPage(),
          ),

          const SizedBox(height: 15),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: const [
                  Icon(Icons.store, size: 42, color: Colors.deepOrange),
                  SizedBox(height: 8),
                  Text(
                    'KGN TAWA FRY',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Machhipith, Raopura, Vadodara'),
                  SizedBox(height: 5),
                  Text('No GST'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuButton(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    Widget page,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.deepOrange,
          child: Icon(icon, color: Colors.white),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => page),
          );
        },
      ),
    );
  }
}

// ==================== TABLES ====================

class TablesPage extends StatelessWidget {
  const TablesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tables'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 12,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 1.15,
        ),
        itemBuilder: (context, index) {
          final tableNo = index + 1;

          return Card(
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => BillingPage(tableNumber: tableNo),
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.table_restaurant,
                    size: 58,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Table $tableNo',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Empty',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ==================== BILLING ====================

class BillingPage extends StatefulWidget {
  final int? tableNumber;

  const BillingPage({super.key, this.tableNumber});

  @override
  State<BillingPage> createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  final Map<int, int> quantities = {};

  int get total {
    int amount = 0;

    quantities.forEach((index, quantity) {
      amount += menuItems[index].full * quantity;
    });

    return amount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.tableNumber == null
              ? 'New Order'
              : 'Table ${widget.tableNumber} Order',
        ),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                final item = menuItems[index];
                final qty = quantities[index] ?? 0;

                return Card(
                  child: ListTile(
                    title: Text(
                      item.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    subtitle: Text(
                      '${item.category} • ₹${item.full}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: qty == 0
                              ? null
                              : () {
                                  setState(() {
                                    quantities[index] = qty - 1;
                                  });
                                },
                          icon: const Icon(Icons.remove),
                        ),
                        Text(
                          '$qty',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              quantities[index] = qty + 1;
                            });
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 8,
                  color: Colors.black12,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Total: ₹$total',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: total == 0
                      ? null
                      : () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Order saved successfully',
                              ),
                            ),
                          );
                        },
                  icon: const Icon(Icons.check),
                  label: const Text('SAVE ORDER'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== MENU ====================

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = <String>[
      'Chicken',
      'Mutton',
      'Fish',
      'Egg',
      'Veg',
      'Biryani',
      'Rice',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Management'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          for (final category in categories) ...[
            Padding(
              padding: const EdgeInsets.only(
                left: 8,
                top: 12,
                bottom: 5,
              ),
              child: Text(
                category,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepOrange,
                ),
              ),
            ),
            ...menuItems
                .where((item) => item.category == category)
                .map(
                  (item) => Card(
                    child: ListTile(
                      title: Text(
                        item.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Half ₹${item.half}  •  Full ₹${item.full}',
                      ),
                    ),
                  ),
                ),
          ],
        ],
      ),
    );
  }
}

// ==================== KOT ====================

class KotPage extends StatelessWidget {
  const KotPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KOT Management'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _kotCard(
            'KOT #001',
            'Table 1',
            'Pending',
            Colors.orange,
          ),
          _kotCard(
            'KOT #002',
            'Table 3',
            'Preparing',
            Colors.blue,
          ),
          _kotCard(
            'KOT #003',
            'Takeaway',
            'Ready',
            Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _kotCard(
    String kot,
    String table,
    String status,
    Color color,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: const Icon(
          Icons.receipt_long,
          size: 38,
        ),
        title: Text(
          kot,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(table),
        trailing: Chip(
          label: Text(status),
          backgroundColor: color.withOpacity(.15),
        ),
      ),
    );
  }
}

// ==================== REPORTS ====================

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _reportCard(
            Icons.currency_rupee,
            'Today Sales',
            '₹0',
          ),
          _reportCard(
            Icons.receipt,
            'Total Orders',
            '0',
          ),
          _reportCard(
            Icons.restaurant,
            'Items Sold',
            '0',
          ),
          _reportCard(
            Icons.payments,
            'Cash Collection',
            '₹0',
          ),
          _reportCard(
            Icons.credit_card,
            'Other Payments',
            '₹0',
          ),
        ],
      ),
    );
  }

  Widget _reportCard(
    IconData icon,
    String title,
    String value,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(
          icon,
          size: 35,
          color: Colors.deepOrange,
        ),
        title: Text(title),
        trailing: Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// ==================== EXPENSE ====================

class ExpensePage extends StatefulWidget {
  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  final amountController = TextEditingController();
  final noteController = TextEditing
