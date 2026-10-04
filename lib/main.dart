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
        scaffoldBackgroundColor: const Color(0xfffff8f2),
      ),
      home: const LoginPage(),
    );
  }
}

/* ===================== MODELS ===================== */

class MenuItem {
  final String name;
  final String category;
  final double price;

  MenuItem(this.name, this.category, this.price);
}

class OrderItem {
  final MenuItem item;
  int qty;

  OrderItem(this.item, this.qty);
}

class RestaurantOrder {
  final int table;
  final String type;
  final List<OrderItem> items;
  String status;

  RestaurantOrder({
    required this.table,
    required this.type,
    required this.items,
    this.status = 'KOT Pending',
  });
}

/* ===================== DATA ===================== */

final List<MenuItem> menu = [
  MenuItem('Murgh Do Pyaza', 'Chicken', 300),
  MenuItem('Murgh Mughlai', 'Chicken', 320),
  MenuItem('Chicken Handi', 'Chicken', 300),
  MenuItem('Chicken Peshawar', 'Chicken', 320),
  MenuItem('Shahi Chicken', 'Chicken', 320),
  MenuItem('Malai Tikka', 'Chicken', 350),
  MenuItem('Tikka Masala', 'Chicken', 320),
  MenuItem('Karahi', 'Chicken', 300),
  MenuItem('Garlic Chicken', 'Chicken', 300),
  MenuItem('Chicken India', 'Chicken', 450),
  MenuItem('Butter Chicken Boneless', 'Chicken', 320),
  MenuItem('White Chicken', 'Chicken', 350),
  MenuItem('Green Chicken', 'Chicken', 350),
  MenuItem('Chicken Fry', 'Chicken', 220),
  MenuItem('Chicken Masala', 'Chicken', 220),
  MenuItem('Biryani', 'Biryani', 120),
  MenuItem('Tandoori Masala', 'Chicken', 480),
  MenuItem('Ahmedabad Masala', 'Chicken', 320),
  MenuItem('Tikka Rice', 'Rice', 320),

  MenuItem('Mughlai Mutton', 'Mutton', 280),
  MenuItem('Dalbati Gos', 'Mutton', 280),
  MenuItem('White Mutton', 'Mutton', 300),
  MenuItem('Green Mutton', 'Mutton', 280),
  MenuItem('Mutton Kurma', 'Mutton', 300),
  MenuItem('Mutton Fry', 'Mutton', 220),
  MenuItem('Mutton Masala', 'Mutton', 220),
  MenuItem('Kaleji Masala', 'Mutton', 220),
  MenuItem('Bhaji Gos', 'Mutton', 240),
  MenuItem('Paya Fry', 'Mutton', 220),

  MenuItem('Chaap Fry', 'Fish', 220),
  MenuItem('Bheja Fry', 'Fish', 240),
  MenuItem('Boti Masala', 'Fish', 220),
  MenuItem('Kheema Fry', 'Fish', 160),
  MenuItem('Kheema Pulao', 'Rice', 180),
  MenuItem('Fish Fry', 'Fish', 160),
  MenuItem('Fish Kadhi', 'Fish', 200),
  MenuItem('Zinga Fry', 'Fish', 240),
  MenuItem('Zinga Rice', 'Rice', 320),

  MenuItem('Anda Kadhi', 'Egg', 160),
  MenuItem('Anda Kheema', 'Egg', 160),
  MenuItem('Anda Bhurji', 'Egg', 100),
  MenuItem('Anda Pulao', 'Egg', 120),

  MenuItem('Dal Tadka', 'Veg', 140),
  MenuItem('Dal Gotala', 'Veg', 160),
  MenuItem('Butter Dal Fry', 'Veg', 140),
  MenuItem('Dal Fry', 'Veg', 100),
  MenuItem('Sabji Fry', 'Veg', 100),
  MenuItem('Sev Tomato', 'Veg', 100),
  MenuItem('Masala Rice', 'Rice', 100),
  MenuItem('Jeera Rice', 'Rice', 100),
  MenuItem('Kadhi Khichdi', 'Veg', 60),
  MenuItem('Dal Pulao', 'Rice', 100),
  MenuItem('Plain Rice', 'Rice', 100),

  MenuItem('Special Roti', 'Roti', 15),
  MenuItem('Special Paratha', 'Roti', 20),
  MenuItem('Butter Roti', 'Roti', 15),
  MenuItem('Chapati Roti', 'Roti', 7),
  MenuItem('Papad Fry', 'Roti', 10),

  MenuItem('Chicken Tandoori', 'Starter', 350),
  MenuItem('Chicken Leg Piece', 'Starter', 100),
  MenuItem('Chicken Lollipop', 'Starter', 50),
  MenuItem('Chicken Tikka Stick', 'Starter', 10),
  MenuItem('Chicken Crispy', 'Starter', 20),
  MenuItem('Chicken Hyderabadi', 'Starter', 20),
  MenuItem('Chicken Cutlets', 'Starter', 10),
  MenuItem('Chicken Egg Kabab', 'Starter', 10),
  MenuItem('Mutton Seekh Kabab', 'Starter', 10),
  MenuItem('Mutton Boti Kabab', 'Starter', 10),
  MenuItem('Chicken Dana Small', 'Starter', 50),
  MenuItem('Chicken Dana Large', 'Starter', 100),
];

/* ===================== LOGIN ===================== */

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String role = 'Admin';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffff5722),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(25),
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.restaurant,
                  size: 70,
                  color: Colors.deepOrange,
                ),
                const SizedBox(height: 15),
                const Text(
                  'KGN TAWA FRY',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text('Smart Restaurant Billing'),
                const SizedBox(height: 25),

                DropdownButtonFormField<String>(
                  value: role,
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
                  ],
                  onChanged: (v) {
                    setState(() => role = v!);
                  },
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => Dashboard(role: role),
                        ),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(14),
                      child: Text('LOGIN'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/* ===================== DASHBOARD ===================== */

class Dashboard extends StatefulWidget {
  final String role;

  const Dashboard({super.key, required this.role});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int selected = 0;

  final List<RestaurantOrder> orders = [];

  final List<double> sales = [];

  double expenses = 0;

  final int tableCount = 20;

  void addOrder(RestaurantOrder order) {
    setState(() {
      orders.removeWhere((o) => o.table == order.table);
      orders.add(order);
    });
  }

  double get todaySales {
    double total = 0;

    for (final order in orders) {
      for (final item in order.items) {
        total += item.item.price * item.qty;
      }
    }

    return total;
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      TablesPage(
        orders: orders,
        onOrderSaved: addOrder,
        tableCount: tableCount,
      ),
      KotPage(orders: orders),
      BillingPage(orders: orders),
      MenuPage(),
      ReportsPage(
        sales: todaySales,
        expenses: expenses,
        orders: orders,
      ),
      ExpensePage(
        onExpenseAdded: (amount) {
          setState(() {
            expenses += amount;
          });
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'KGN TAWA FRY - ${widget.role}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: pages[selected],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selected,
        onDestinationSelected: (i) {
          setState(() => selected = i);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.table_restaurant),
            label: 'Tables',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long),
            label: 'KOT',
          ),
          NavigationDestination(
            icon: Icon(Icons.point_of_sale),
            label: 'Billing',
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
            icon: Icon(Icons.money_off),
            label: 'Expense',
          ),
        ],
      ),
    );
  }
}

/* ===================== TABLES ===================== */

class TablesPage extends StatelessWidget {
  final List<RestaurantOrder> orders;
  final Function(RestaurantOrder) onOrderSaved;
  final int tableCount;

  const TablesPage({
    super.key,
    required this.orders,
    required this.onOrderSaved,
    required this.tableCount,
  });

  RestaurantOrder? getOrder(int table) {
    for (final order in orders) {
      if (order.table == table) return order;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(14),
      itemCount: tableCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 14,
        mainAxisSpacing: 14,
        childAspectRatio: 1.05,
      ),
      itemBuilder: (_, index) {
        final table = index + 1;
        final order = getOrder(table);
        final occupied = order != null;

        return Card(
          elevation: 3,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () async {
              final result = await Navigator.push<RestaurantOrder>(
                context,
                MaterialPageRoute(
                  builder: (_) => OrderPage(
                    table: table,
                    oldOrder: order,
                  ),
                ),
              );

              if (result != null) {
                onOrderSaved(result);
              }
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.table_restaurant,
                  size: 60,
                  color: occupied ? Colors.red : Colors.green,
                ),
                const SizedBox(height: 8),
                Text(
                  'Table $table',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  occupied ? order.status : 'EMPTY',
                  style: TextStyle(
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

/* ===================== ORDER ===================== */

class OrderPage extends StatefulWidget {
  final int table;
  final RestaurantOrder? oldOrder;

  const OrderPage({
    super.key,
    required this.table,
    this.oldOrder,
  });

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  String category = 'All';
  String orderType = 'Dine-in';

  final Map<MenuItem, int> cart = {};

  final categories = [
    'All',
    'Chicken',
    'Mutton',
    'Fish',
    'Egg',
    'Veg',
    'Rice',
    'Roti',
    'Starter',
    'Biryani',
  ];

  @override
  void initState() {
    super.initState();

    if (widget.oldOrder != null) {
      orderType = widget.oldOrder!.type;

      for (final x in widget.oldOrder!.items) {
        cart[x.item] = x.qty;
      }
    }
  }

  double get total {
    double x = 0;

    cart.forEach((item, qty) {
      x += item.price * qty;
    });

    return x;
  }

  void saveOrder() {
    if (cart.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add items first')),
      );
      return;
    }

    final items = cart.entries
        .map((e) => OrderItem(e.key, e.value))
        .toList();

    Navigator.pop(
      context,
      RestaurantOrder(
        table: widget.table,
        type: orderType,
        items: items,
        status: 'KOT Pending',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filtered = category == 'All'
        ? menu
        : menu.where((x) => x.category == category).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Table ${widget.table} Order'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 55,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: categories
                  .map(
                    (x) => Padding(
                      padding: const EdgeInsets.all(5),
                      child: ChoiceChip(
                        label: Text(x),
                        selected: category == x,
                        onSelected: (_) {
                          setState(() => category = x);
                        },
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: DropdownButtonFormField<String>(
              value: orderType,
              decoration: const InputDecoration(
                labelText: 'Order Type',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Dine-in',
                  child: Text('Dine-in'),
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
              onChanged: (v) {
                setState(() => orderType = v!);
              },
            ),
          ),

          const SizedBox(height: 8),

          Expanded(
            child: ListView.builder(
              itemCount: filtered.length,
              itemBuilder: (_, index) {
                final item = filtered[index];
                final qty = cart[item] ?? 0;

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: ListTile(
                    title: Text(
                      item.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${item.category} • ₹${item.price.toStringAsFixed(0)}',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: qty == 0
                              ? null
                              : () {
                                  setState(() {
                                    if (qty == 1) {
                                      cart.remove(item);
                                    } else {
                                      cart[item] = qty - 1;
                                    }
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
                              cart[item] = qty + 1;
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
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: ElevatedButton.icon(
            onPressed: saveOrder,
            icon: const Icon(Icons.send),
            label: Text(
              'SEND KOT • ₹${total.toStringAsFixed(0)}',
            ),
          ),
        ),
      ),
    );
  }
}

/* ===================== KOT ===================== */

class KotPage extends StatelessWidget {
  final List<RestaurantOrder> orders;

  const KotPage({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return const Center(
        child: Text(
          'No KOT orders',
          style: TextStyle(fontSize: 20),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: orders.length,
      itemBuilder: (_, index) {
        final order = orders[index];

        return Card(
          child: ExpansionTile(
            leading: const Icon(
              Icons.soup_kitchen,
              color: Colors.deepOrange,
            ),
            title: Text(
              'Table ${order.table}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              '${order.type} • ${order.status}',
            ),
            children: [
              ...order.items.map(
                (x) => ListTile(
                  title: Text(x.item.name),
                  trailing: Text(
                    'x${x.qty}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('ACCEPT KOT'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        child: const Text('READY'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/* ===================== BILLING =============
