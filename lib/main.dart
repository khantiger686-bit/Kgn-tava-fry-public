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
      home: const LoginPage(),
    );
  }
}

// ================= LOGIN =================

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String user = 'Admin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KGN TAWA FRY'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Icon(
              Icons.restaurant,
              size: 90,
              color: Colors.deepOrange,
            ),
            const SizedBox(height: 20),
            const Text(
              'Smart Restaurant',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Billing • KOT • Orders • Tables',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 35),
            DropdownButtonFormField<String>(
              value: user,
              decoration: const InputDecoration(
                labelText: 'Login As',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Admin',
                  child: Text('Admin / Owner'),
                ),
                DropdownMenuItem(
                  value: 'Cashier',
                  child: Text('Cashier'),
                ),
                DropdownMenuItem(
                  value: 'Waiter',
                  child: Text('Waiter'),
                ),
                DropdownMenuItem(
                  value: 'Kitchen',
                  child: Text('Kitchen'),
                ),
              ],
              onChanged: (v) {
                setState(() => user = v!);
              },
            ),
            const SizedBox(height: 25),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => HomePage(user: user),
                    ),
                  );
                },
                child: const Text(
                  'OPEN RESTAURANT',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= HOME =================

class HomePage extends StatefulWidget {
  final String user;

  const HomePage({super.key, required this.user});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;

  final List<Widget> pages = const [
    DashboardPage(),
    TablesPage(),
    OrdersPage(),
    KotPage(),
    MenuPage(),
    ReportsPage(),
    MorePage(),
  ];

  final List<String> titles = [
    'Dashboard',
    'Tables',
    'Orders',
    'Kitchen KOT',
    'Menu',
    'Reports',
    'More',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KGN TAWA FRY - ${titles[index]}'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) {
          setState(() => index = i);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.table_restaurant),
            label: 'Tables',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long),
            label: 'Orders',
          ),
          NavigationDestination(
            icon: Icon(Icons.soup_kitchen),
            label: 'KOT',
          ),
          NavigationDestination(
            icon: Icon(Icons.restaurant_menu),
            label: 'Menu',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart),
            label: 'Reports',
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

// ================= DASHBOARD =================

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Today Overview',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: _card(
                '₹0',
                'Today Sales',
                Icons.currency_rupee,
                Colors.green,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _card(
                '0',
                'Orders',
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
              child: _card(
                '0',
                'KOT Pending',
                Icons.soup_kitchen,
                Colors.orange,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _card(
                '0',
                'Occupied',
                Icons.table_restaurant,
                Colors.red,
              ),
            ),
          ],
        ),
        const SizedBox(height: 25),
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        _action(
          context,
          'New Dine-In Order',
          Icons.table_restaurant,
        ),
        _action(
          context,
          'New Takeaway',
          Icons.shopping_bag,
        ),
        _action(
          context,
          'New Delivery',
          Icons.delivery_dining,
        ),
        _action(
          context,
          'Create Bill',
          Icons.receipt,
        ),
        _action(
          context,
          'Kitchen KOT',
          Icons.soup_kitchen,
        ),
      ],
    );
  }

  static Widget _card(
    String value,
    String title,
    IconData icon,
    Color color,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Icon(icon, size: 35, color: color),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(title),
          ],
        ),
      ),
    );
  }

  static Widget _action(
    BuildContext context,
    String title,
    IconData icon,
  ) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: Colors.deepOrange),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {},
      ),
    );
  }
}

// ================= TABLES =================

class TablesPage extends StatefulWidget {
  const TablesPage({super.key});

  @override
  State<TablesPage> createState() => _TablesPageState();
}

class _TablesPageState extends State<TablesPage> {
  final List<String> status = List.generate(12, (_) => 'Empty');

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: status.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.05,
      ),
      itemBuilder: (_, i) {
        final occupied = status[i] == 'Occupied';

        return Card(
          child: InkWell(
            onTap: () {
              setState(() {
                status[i] = occupied ? 'Empty' : 'Occupied';
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.table_restaurant,
                  size: 55,
                  color: occupied ? Colors.red : Colors.green,
                ),
                const SizedBox(height: 8),
                Text(
                  'Table ${i + 1}',
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  status[i],
                  style: TextStyle(
                    fontSize: 17,
                    color: occupied ? Colors.red : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ================= ORDERS =================

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _orderCard(
          'Table 1',
          'Dine-In',
          'Pending',
        ),
        _orderCard(
          'Takeaway #001',
          'Takeaway',
          'Ready',
        ),
        _orderCard(
          'Delivery #002',
          'Delivery',
          'Preparing',
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 55,
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add),
            label: const Text('NEW ORDER'),
          ),
        ),
      ],
    );
  }

  Widget _orderCard(
    String order,
    String type,
    String status,
  ) {
    return Card(
      child: ListTile(
        leading: const Icon(
          Icons.receipt_long,
          color: Colors.deepOrange,
        ),
        title: Text(
          order,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(type),
        trailing: Text(
          status,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

// ================= KOT =================

class KotPage extends StatefulWidget {
  const KotPage({super.key});

  @override
  State<KotPage> createState() => _KotPageState();
}

class _KotPageState extends State<KotPage> {
  final List<Map<String, String>> orders = [
    {
      'table': 'Table 1',
      'items': 'Murg Do Pyaza x2, Roti x4',
      'status': 'New',
    },
    {
      'table': 'Table 3',
      'items': 'Chicken Fry x1',
      'status': 'Preparing',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: orders.length,
      itemBuilder: (_, i) {
        final order = orders[i];

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order['table']!,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  order['items']!,
                  style: const TextStyle(fontSize: 17),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                  children: [
                    Chip(
                      label: Text(order['status']!),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          orders.removeAt(i);
                        });
                      },
                      child: const Text('DONE'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ================= MENU =================

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  static const List<Map<String, dynamic>> menu = [
    {
      'name': 'Murgh Do Pyaza',
      'category': 'Chicken',
      'price': 300
    },
    {
      'name': 'Murgh Mughlai',
      'category': 'Chicken',
      'price': 320
    },
    {
      'name': 'Chicken Handi',
      'category': 'Chicken',
      'price': 300
    },
    {
      'name': 'Chicken Peshawar',
      'category': 'Chicken',
      'price': 320
    },
    {
      'name': 'Shahi Chicken',
      'category': 'Chicken',
      'price': 320
    },
    {
      'name': 'Malai Tikka',
      'category': 'Chicken',
      'price': 350
    },
    {
      'name': 'Tikka Masala',
      'category': 'Chicken',
      'price': 320
    },
    {
      'name': 'Karahi',
      'category': 'Chicken',
      'price': 300
    },
    {
      'name': 'Garlic Chicken',
      'category': 'Chicken',
      'price': 300
    },
    {
      'name': 'Chicken Fry',
      'category': 'Chicken',
      'price': 220
    },
    {
      'name': 'Chicken Biryani',
      'category': 'Biryani',
      'price': 120
    },
    {
      'name': 'Mutton Fry',
      'category': 'Mutton',
      'price': 220
    },
    {
      'name': 'Fish Fry',
      'category': 'Fish',
      'price': 160
    },
    {
      'name': 'Zinga Fry',
      'category': 'Fish',
      'price': 240
    },
    {
      'name': 'Dal Fry',
      'category': 'Veg',
      'price': 100
    },
    {
      'name': 'Jeera Rice',
      'category': 'Rice',
      'price': 100
    },
    {
      'name': 'Special Roti',
      'category': 'Roti',
      'price': 15
    },
    {
      'name': 'Special Paratha',
      'category': 'Roti',
      'price': 20
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: menu.length,
      itemBuilder: (_, i) {
        final item = menu[i];

        return Card(
          child: ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.restaurant),
            ),
            title: Text(
              item['name'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(item['category']),
            trailing: Text(
              '₹${item['price']}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}

// ================= REPORTS =================

class ReportsPage extends StatelessWidget {
  const ReportsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Business Reports',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 15),
        _report('Today Sales', '₹0'),
        _report('Total Orders', '0'),
        _report('Cash Payment', '₹0'),
        _report('UPI Payment', '₹0'),
        _report('Discount', '₹0'),
        _report('Expenses', '₹0'),
        _report('Net Sales', '₹0'),
        const SizedBox(height: 20),
        const Card(
          child: ListTile(
            leading: Icon(Icons.info),
            title: Text('GST'),
            subtitle: Text('No GST'),
          ),
        ),
      ],
    );
  }

  Widget _report(String title, String value) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

// ================= MORE =================

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        _item(Icons.inventory, 'Inventory & Stock'),
        _item(Icons.menu_book, 'Menu Management'),
        _item(Icons.people, 'Staff & Waiters'),
        _item(Icons.money_off, 'Expenses'),
        _item(Icons.print, 'Printer Settings'),
        _item(Icons.bluetooth, 'Bluetooth Printer'),
        _item(Icons.wifi, 'Wi-Fi Printer'),
        _item(Icons.settings, 'Restaurant Settings'),
        _item(Icons.backup, 'Backup & Restore'),
        _item(Icons.info, 'About KGN TAWA FRY'),
      ],
    );
  }

  Widget _item(IconData icon, String title) {
    return Card(
      child: ListTile(
        leading: Icon(
          icon,
          color: Colors.deepOrange,
        ),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {},
      ),
    );
  }
}
