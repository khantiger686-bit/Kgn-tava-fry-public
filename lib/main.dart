import 'package:flutter/material.dart';

void main() => runApp(const KgnApp());

class Item {
  final String name;
  final String category;
  final int half;
  final int full;

  const Item(this.name, this.category, this.half, this.full);
}

const items = <Item>[
  Item('Murgh Do Pyaza', 'Chicken', 160, 300),
  Item('Murgh Mughlai', 'Chicken', 170, 320),
  Item('Chicken Handi', 'Chicken', 160, 300),
  Item('Chicken Peshawar', 'Chicken', 170, 320),
  Item('Shahi Chicken', 'Chicken', 170, 320),
  Item('Malai Tikka', 'Chicken', 180, 350),
  Item('Tikka Masala', 'Chicken', 170, 320),
  Item('Karahi', 'Chicken', 160, 300),
  Item('Garlic Chicken', 'Chicken', 160, 300),
  Item('Chicken India', 'Chicken', 250, 450),
  Item('Butter Chicken Boneless', 'Chicken', 170, 320),
  Item('White Chicken', 'Chicken', 180, 350),
  Item('Green Chicken', 'Chicken', 180, 350),
  Item('Chicken Fry', 'Chicken', 120, 220),
  Item('Chicken Masala', 'Chicken', 120, 220),
  Item('Biryani', 'Chicken', 80, 120),
  Item('Tandoori Masala', 'Chicken', 250, 480),
  Item('Ahmedabad Masala', 'Chicken', 160, 320),
  Item('Tikka Rice', 'Chicken', 170, 320),

  Item('Mughlai Mutton', 'Mutton', 150, 280),
  Item('Dalbati Gos', 'Mutton', 150, 280),
  Item('White Mutton', 'Mutton', 160, 300),
  Item('Green Mutton', 'Mutton', 150, 280),
  Item('Mutton Kurma', 'Mutton', 160, 300),
  Item('Mutton Fry', 'Mutton', 120, 220),
  Item('Mutton Masala', 'Mutton', 120, 220),
  Item('Kaleji Masala', 'Mutton', 120, 220),
  Item('Bhaji Gos', 'Mutton', 130, 240),
  Item('Paya Fry', 'Mutton', 120, 220),

  Item('Chaap Fry', 'Fish', 120, 220),
  Item('Bheja Fry', 'Fish', 130, 240),
  Item('Boti Masala', 'Fish', 120, 220),
  Item('Kheema Fry', 'Fish', 80, 160),
  Item('Kheema Pulao', 'Fish', 100, 180),
  Item('Fish Fry', 'Fish', 80, 160),
  Item('Fish Kadhi', 'Fish', 100, 200),
  Item('Zinga Fry', 'Fish', 130, 240),
  Item('Zinga Rice', 'Fish', 170, 320),

  Item('Anda Kadhi', 'Egg', 80, 160),
  Item('Anda Kheema', 'Egg', 80, 160),
  Item('Anda Bhurji', 'Egg', 50, 100),
  Item('Anda Pulao', 'Egg', 60, 120),

  Item('Dal Tadka', 'Veg', 70, 140),
  Item('Dal Gotala', 'Veg', 80, 160),
  Item('Butter Dal Fry', 'Veg', 70, 140),
  Item('Dal Fry', 'Veg', 50, 100),
  Item('Sabji Fry', 'Veg', 50, 100),
  Item('Sev Tomato', 'Veg', 50, 100),
  Item('Masala Rice', 'Veg', 50, 100),
  Item('Jeera Rice', 'Veg', 50, 100),
  Item('Kadhi Khichdi', 'Veg', 30, 60),
  Item('Dal Palak', 'Veg', 50, 100),
  Item('Plain Rice', 'Veg', 50, 100),

  Item('Special Roti', 'Roti', 15, 15),
  Item('Special Paratha', 'Roti', 20, 20),
  Item('Butter Roti', 'Roti', 15, 15),
  Item('Chapati Roti', 'Roti', 7, 7),
  Item('Papad Fry', 'Roti', 10, 10),

  Item('Chicken Tandoori', 'Starter', 180, 350),
  Item('Chicken Leg Piece', 'Starter', 100, 100),
  Item('Chicken Lollipop', 'Starter', 50, 50),
  Item('Chicken Tikka Stick', 'Starter', 10, 10),
  Item('Chicken Crispy', 'Starter', 20, 20),
  Item('Chicken Hyderabadi', 'Starter', 20, 20),
  Item('Chicken Cutlets', 'Starter', 10, 10),
  Item('Chicken Egg Kabab', 'Starter', 10, 10),
  Item('Mutton Seekh Kabab', 'Starter', 10, 10),
  Item('Mutton Boti Kabab', 'Starter', 10, 10),
  Item('Chicken Dana Small', 'Starter', 50, 50),
  Item('Chicken Dana Large', 'Starter', 100, 100),
];

class CartLine {
  final Item item;
  final bool full;
  int qty;

  CartLine(this.item, this.full, this.qty);

  int get total => (full ? item.full : item.half) * qty;
}

class KgnApp extends StatelessWidget {
  const KgnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KGN TAWA FRY',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepOrange,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int tab = 0;

  final List<String> tables =
      List.generate(12, (index) => 'T${index + 1}');

  final Set<String> occupied = {};
  final List<Map<String, dynamic>> orders = [];

  int orderNo = 1;

  void newOrder(
    String type,
    String table,
    List<CartLine> cart,
  ) {
    setState(() {
      orders.insert(0, {
        'no': orderNo++,
        'type': type,
        'table': table,
        'items': List<CartLine>.from(cart),
        'paid': false,
      });

      if (table != 'Takeaway') {
        occupied.add(table);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      Dashboard(
        orders: orders,
        occupied: occupied,
        onBill: () => setState(() => tab = 1),
      ),
      Billing(
        onSave: newOrder,
        tables: tables,
      ),
      Kots(
        orders: orders,
        onPaid: (order) {
          setState(() {
            order['paid'] = true;

            if (order['table'] != 'Takeaway') {
              occupied.remove(order['table']);
            }
          });
        },
      ),
      Tables(
        tables: tables,
        occupied: occupied,
      ),
      const MenuPage(),
      Reports(orders: orders),
      const Expenses(),
      const SettingsPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'KGN TAWA FRY',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepOrange,
              ),
              child: Text(
                'KGN TAWA FRY\nBilling • KOT • Orders',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ...[
              'Dashboard',
              'Billing',
              'KOT Management',
              'Tables',
              'Menu',
              'Reports',
              'Expenses',
              'Settings',
            ].asMap().entries.map(
              (entry) {
                final icons = [
                  Icons.dashboard,
                  Icons.receipt_long,
                  Icons.soup_kitchen,
                  Icons.table_restaurant,
                  Icons.restaurant_menu,
                  Icons.bar_chart,
                  Icons.money_off,
                  Icons.settings,
                ];

                return ListTile(
                  leading: Icon(icons[entry.key]),
                  title: Text(entry.value),
                  onTap: () {
                    Navigator.pop(context);
                    setState(() => tab = entry.key);
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: pages[tab],
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab > 3 ? 0 : tab,
        onDestinationSelected: (index) {
          setState(() => tab = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long),
            label: 'Billing',
          ),
          NavigationDestination(
            icon: Icon(Icons.soup_kitchen),
            label: 'KOT',
          ),
          NavigationDestination(
            icon: Icon(Icons.table_restaurant),
            label: 'Tables',
          ),
        ],
      ),
    );
  }
}

class Dashboard extends StatelessWidget {
  final List<Map<String, dynamic>> orders;
  final Set<String> occupied;
  final VoidCallback onBill;

  const Dashboard({
    super.key,
    required this.orders,
    required this.occupied,
    required this.onBill,
  });

  @override
  Widget build(BuildContext context) {
    int sales = 0;

    for (final order in orders) {
      if (order['paid'] == true) {
        for (final item in order['items'] as List<CartLine>) {
          sales += item.total;
        }
      }
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'आज का Dashboard',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),

        Row(
          children: [
            Expanded(
              child: dashboardCard(
                'Sales',
                '₹$sales',
                Icons.currency_rupee,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: dashboardCard(
                'Pending KOT',
                '${orders.where((o) => o['paid'] != true).length}',
                Icons.soup_kitchen,
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),

        Row(
          children: [
            Expanded(
              child: dashboardCard(
                'Occupied',
                '${occupied.length}',
                Icons.table_restaurant,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: dashboardCard(
                'Orders',
                '${orders.length}',
                Icons.receipt_long,
              ),
            ),
          ],
        ),

        const SizedBox(height: 15),

        FilledButton.icon(
          onPressed: onBill,
          icon: const Icon(Icons.add),
          label: const Text('New Bill'),
        ),

        const SizedBox(height: 15),

        const Text(
          'Recent Orders',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),

        ...orders.take(8).map(
          (order) {
            return Card(
              child: ListTile(
                title: Text(
                  'Order #${order['no']} • ${order['type']}',
                ),
                subtitle: Text(
                  '${order['table']} • '
                  '${(order['items'] as List).length} items • '
                  '${order['paid'] ? 'Paid' : 'KOT Pending'}',
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget dashboardCard(
    String title,
    String value,
    IconData icon,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              color: Colors.deepOrange,
            ),
            Text(title),
            Text(
              value,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Billing extends StatefulWidget {
  final void Function(
    String,
    String,
    List<CartLine>,
  ) onSave;

  final List<String> tables;

  const Billing({
    super.key,
    required this.onSave,
    required this.tables,
  });

  @override
  State<Billing> createState() => _BillingState();
}

class _BillingState extends State<Billing> {
  String category = 'Chicken';
  String orderType = 'Dine-in';
  String table = 'T1';

  bool full = false;

  final List<CartLine> cart = [];

  int get total {
    return cart.fold(
      0,
      (sum, item) => sum + item.total,
    );
  }

  @override
  Widget build(BuildContext context) {
    final list = items
        .where((item) => item.category == category)
        .toList();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  initialValue: orderType,
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
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => orderType = value);
                    }
                  },
                ),
              ),

              if (orderType == 'Dine-in') ...[
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: table,
                    decoration: const InputDecoration(
                      labelText: 'Table',
                      border: OutlineInputBorder(),
                    ),
                    items: widget.tables
                        .map(
                          (tableName) => DropdownMenuItem(
                            value: tableName,
                            child: Text(tableName),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => table = value);
                      }
                    },
                  ),
                ),
              ],
            ],
          ),
        ),

        SizedBox(
          height: 52,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
            ),
            children: [
              'Chicken',
              'Mutton',
              'Fish',
              'Egg',
              'Veg',
              'Roti',
              'Starter',
            ].map(
              (categoryName) {
                return Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: ChoiceChip(
                    label: Text(categoryName),
                    selected: category == categoryName,
                    onSelected: (_) {
                      setState(() {
                        category = categoryName;
                      });
                    },
                  ),
                );
              },
            ).toList(),
          ),
        ),

        SwitchListTile(
          title: Text(
            full ? 'Full' : 'Half',
          ),
          value: full,
          onChanged: (value) {
            setState(() => full = value);
          },
        ),

        Expanded(
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              final item = list[index];

              return Card(
                child: ListTile(
                  title: Text(item.name),
                  subtitle: Text(
                    'Half ₹${item.half} • Full ₹${item.full}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.add_circle,
                      color: Colors.deepOrange,
                    ),
                    onPressed: () {
                      setState(() {
                        final existing = cart.where(
                          (line) =>
                              line.item == item &&
                              line.full == full,
                        ).toList();

                        if (existing.isEmpty) {
                          cart.add(
                            CartLine(
                              item,
                              full,
                              1,
                            ),
                          );
                        } else {
                          existing.first.qty++;
                        }
                      });
                    },
                  ),
                ),
              );
            },
          ),
        ),

        if (cart.isNotEmpty)
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text('${cart.length} items'),
                    const Spacer(),
                    Text(
                      '₹$total',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

                SizedBox(
                  height: 48,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: cart.map(
                      (line) {
                        return Padding(
                          padding:
                              const EdgeInsets.only(right: 5),
                          child: Chip(
                            label: Text(
                              '${line.item.name} ×${line.qty}',
                            ),
                            onDeleted: () {
                              setState(() {
                                cart.remove(line);
                              });
                            },
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),

                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: () {
                      widget.onSave(
                        orderType,
                        orderType == 'Takeaway'
                            ? 'Takeaway'
                            : table,
                        List<CartLine>.from(cart),
                      );

                      setState(() {
                        cart.clear();
                      });

                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        const SnackBar(
                          content:
                              Text('KOT sent successfully'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.send),
                    label: const Text(
                      'Send KOT & Save',
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class Kots extends StatelessWidget {
  final List<Map<String, dynamic>> orders;
  final void Function(Map<String, dynamic>) onPaid;

  const Kots({
    super.key,
    required this.orders,
    required this.onPaid,
  });

  @override
  Widget build(BuildContext context) {
    final pending = orders
        .where((order) => order['paid'] != true)
        .toList();

    if (pending.isEmpty) {
      return const Center(
        child: Text(
          'कोई pending KOT नहीं है',
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(12),
      children: pending.map(
        (order) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                chi
