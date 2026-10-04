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
      home: const LoginPage(),
    );
  }
}

/* =========================
   LOGIN
========================= */

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    userController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const DashboardPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 42,
                    child: Icon(Icons.restaurant, size: 42),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    'KGN TAVA FRY',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text('Restaurant Billing & KOT'),
                  const SizedBox(height: 28),
                  TextField(
                    controller: userController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 14),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: login,
                      icon: const Icon(Icons.login),
                      label: const Text('LOGIN'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/* =========================
   MODELS
========================= */

class MenuItemModel {
  String name;
  double price;
  String category;

  MenuItemModel({
    required this.name,
    required this.price,
    required this.category,
  });
}

class OrderLine {
  MenuItemModel item;
  int quantity;

  OrderLine({
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
  int selectedIndex = 0;

  final List<MenuItemModel> menu = [
    MenuItemModel(
      name: 'Chicken Tawa',
      price: 220,
      category: 'Non-Veg',
    ),
    MenuItemModel(
      name: 'Chicken Fry',
      price: 180,
      category: 'Non-Veg',
    ),
    MenuItemModel(
      name: 'Chicken Biryani',
      price: 190,
      category: 'Biryani',
    ),
    MenuItemModel(
      name: 'Mutton Tawa',
      price: 320,
      category: 'Non-Veg',
    ),
    MenuItemModel(
      name: 'Paneer Tawa',
      price: 180,
      category: 'Veg',
    ),
    MenuItemModel(
      name: 'Paneer Butter Masala',
      price: 170,
      category: 'Veg',
    ),
    MenuItemModel(
      name: 'Tandoori Roti',
      price: 20,
      category: 'Roti',
    ),
    MenuItemModel(
      name: 'Butter Naan',
      price: 45,
      category: 'Roti',
    ),
    MenuItemModel(
      name: 'Cold Drink',
      price: 40,
      category: 'Drinks',
    ),
  ];

  final List<OrderLine> currentOrder = [];

  final List<String> tables = [
    'Table 1',
    'Table 2',
    'Table 3',
    'Table 4',
    'Table 5',
    'Table 6',
    'Table 7',
    'Table 8',
  ];

  double totalSales = 0;
  int completedBills = 0;
  double expenses = 0;

  String orderType = 'Dine-In';

  void addItem(MenuItemModel item) {
    setState(() {
      final index =
          currentOrder.indexWhere((element) => element.item.name == item.name);

      if (index >= 0) {
        currentOrder[index].quantity++;
      } else {
        currentOrder.add(OrderLine(item: item));
      }
    });
  }

  void removeItem(int index) {
    setState(() {
      if (currentOrder[index].quantity > 1) {
        currentOrder[index].quantity--;
      } else {
        currentOrder.removeAt(index);
      }
    });
  }

  double get orderTotal {
    double total = 0;

    for (final line in currentOrder) {
      total += line.total;
    }

    return total;
  }

  void saveBill() {
    if (currentOrder.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pehle item add karo')),
      );
      return;
    }

    setState(() {
      totalSales += orderTotal;
      completedBills++;
      currentOrder.clear();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Bill saved successfully'),
      ),
    );
  }

  void sendKOT() {
    if (currentOrder.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('KOT ke liye item add karo')),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('KOT kitchen ko bhej diya'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(
        totalSales: totalSales,
        completedBills: completedBills,
        expenses: expenses,
        onBilling: () {
          setState(() {
            selectedIndex = 1;
          });
        },
        onTables: () {
          setState(() {
            selectedIndex = 2;
          });
        },
      ),
      BillingPage(
        menu: menu,
        currentOrder: currentOrder,
        orderTotal: orderTotal,
        orderType: orderType,
        onOrderTypeChanged: (value) {
          setState(() {
            orderType = value;
          });
        },
        onAdd: addItem,
        onRemove: removeItem,
        onSave: saveBill,
        onKOT: sendKOT,
      ),
      TablesPage(tables: tables),
      MenuPage(
        menu: menu,
        onChanged: () {
          setState(() {});
        },
      ),
      ReportsPage(
        totalSales: totalSales,
        completedBills: completedBills,
        expenses: expenses,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'KGN TAVA FRY',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                selectedIndex = 4;
              });
            },
            icon: const Icon(Icons.bar_chart),
          ),
        ],
      ),
      body: pages[selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
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
            icon: Icon(Icons.table_restaurant_outlined),
            selectedIcon: Icon(Icons.table_restaurant),
            label: 'Tables',
          ),
          NavigationDestination(
            icon: Icon(Icons.restaurant_menu_outlined),
            selectedIcon: Icon(Icons.restaurant_menu),
            label: 'Menu',
          ),
          NavigationDestination(
            icon: Icon(Icons.analytics_outlined),
            selectedIcon: Icon(Icons.analytics),
            label: 'Reports',
          ),
        ],
      ),
    );
  }
}

/* =========================
   HOME
========================= */

class HomePage extends StatelessWidget {
  final double totalSales;
  final int completedBills;
  final double expenses;
  final VoidCallback onBilling;
  final VoidCallback onTables;

  const HomePage({
    super.key,
    required this.totalSales,
    required this.completedBills,
    required this.expenses,
    required this.onBilling,
    required this.onTables,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Restaurant Dashboard',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: StatCard(
                  title: 'Today Sales',
                  value: '₹${totalSales.toStringAsFixed(0)}',
                  icon: Icons.currency_rupee,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatCard(
                  title: 'Bills',
                  value: '$completedBills',
                  icon: Icons.receipt,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: StatCard(
                  title: 'Expenses',
                  value: '₹${expenses.toStringAsFixed(0)}',
                  icon: Icons.money_off,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: StatCard(
                  title: 'GST',
                  value: 'No GST',
                  icon: Icons.percent,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ActionTile(
            icon: Icons.add_shopping_cart,
            title: 'New Bill',
            subtitle: 'Create a new restaurant bill',
            onTap: onBilling,
          ),
          ActionTile(
            icon: Icons.table_restaurant,
            title: 'Table Management',
            subtitle: 'Check table status',
            onTap: onTables,
          ),
          ActionTile(
            icon: Icons.soup_kitchen,
            title: 'KOT Management',
            subtitle: 'Send orders to kitchen',
            onTap: onBilling,
          ),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, size: 30),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(title),
          ],
        ),
      ),
    );
  }
}

class ActionTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const ActionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 18),
        onTap: onTap,
      ),
    );
  }
}

/* =========================
   BILLING
========================= */

class BillingPage extends StatelessWidget {
  final List<MenuItemModel> menu;
  final List<OrderLine> currentOrder;
  final double orderTotal;
  final String orderType;
  final ValueChanged<String> onOrderTypeChanged;
  final Function(MenuItemModel) onAdd;
  final Function(int) onRemove;
  final VoidCallback onSave;
  final VoidCallback onKOT;

  const BillingPage({
    super.key,
    required this.menu,
    required this.currentOrder,
    required this.orderTotal,
    required this.orderType,
    required this.onOrderTypeChanged,
    required this.onAdd,
    required this.onRemove,
    required this.onSave,
    required this.onKOT,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: DropdownButtonFormField<String>(
            initialValue: orderType,
            decoration: const InputDecoration(
              labelText: 'Order Type',
              border: OutlineInputBorder(),
            ),
            items: const [
              DropdownMenuItem(
                value: 'Dine-In',
                child: Text('Dine-In'),
              ),
              DropdownMenuItem(
                value: 'Takeaway',
                child: Text('Takeaway'),
              ),
              DropdownMenuItem(
                value: 'Delivery',
                child: Text('Delivery'),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                onOrderTypeChanged(value);
              }
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Menu',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: menu.length,
            itemBuilder: (context, index) {
              final item = menu[index];

              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      item.name.substring(0, 1),
                    ),
                  ),
                  title: Text(
                    item.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(item.category),
                  trailing: FilledButton(
                    onPressed: () => onAdd(item),
                    child: Text('₹${item.price.toStringAsFixed(0)}'),
                  ),
                ),
              );
            },
          ),
        ),
        if (currentOrder.isNotEmpty)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 8,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Current Order',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  height: 110,
                  child: ListView.builder(
                    itemCount: currentOrder.length,
                    itemBuilder: (context, index) {
                      final line = currentOrder[index];

                      return Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${line.item.name} x${line.quantity}',
                            ),
                          ),
                          Text(
                            '₹${line.total.toStringAsFixed(0)}',
                          ),
                          IconButton(
                            onPressed: () => onRemove(index),
                            icon: const Icon(Icons.remove_circle_outline),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'TOTAL',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '₹${orderTotal.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: onKOT,
                        icon: const Icon(Icons.soup_kitchen),
                        label: const Text('SEND KOT'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: onSave,
                        icon: const Icon(Icons.check),
                        label: const Text('SAVE BILL'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}

/* =========================
   TABLES
========================= */

cl
