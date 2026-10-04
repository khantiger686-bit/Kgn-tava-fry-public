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
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      home: const HomePage(),
    );
  }
}

// =========================
// MENU MODEL
// =========================

class MenuItemModel {
  final String name;
  final String category;
  final double price;

  const MenuItemModel(
    this.name,
    this.category,
    this.price,
  );
}

// =========================
// ORDER MODEL
// =========================

class OrderItem {
  final MenuItemModel item;
  int qty;

  OrderItem(
    this.item,
    this.qty,
  );
}

// =========================
// SAMPLE MENU
// =========================

const menuItems = <MenuItemModel>[
  MenuItemModel(
    'Tava Chicken',
    'Non-Veg',
    180,
  ),
  MenuItemModel(
    'Chicken Fry',
    'Non-Veg',
    160,
  ),
  MenuItemModel(
    'Chicken Tikka',
    'Tandoor',
    220,
  ),
  MenuItemModel(
    'Paneer Tikka',
    'Veg',
    170,
  ),
  MenuItemModel(
    'Paneer Tava',
    'Veg',
    190,
  ),
  MenuItemModel(
    'Butter Naan',
    'Roti',
    35,
  ),
  MenuItemModel(
    'Garlic Naan',
    'Roti',
    50,
  ),
  MenuItemModel(
    'French Fries',
    'Snacks',
    90,
  ),
  MenuItemModel(
    'Cold Drink',
    'Beverage',
    40,
  ),
];

// =========================
// HOME PAGE
// =========================

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  final List<OrderItem> cart = [];

  final List<String> titles = const [
    'Dashboard',
    'Billing',
    'KOT Orders',
    'Tables',
    'Menu',
    'Inventory',
    'Expenses',
    'Reports',
  ];

  // =========================
  // ADD ITEM
  // =========================

  void addToCart(MenuItemModel item) {
    setState(() {
      OrderItem? existing;

      for (final order in cart) {
        if (order.item.name == item.name) {
          existing = order;
          break;
        }
      }

      if (existing == null) {
        cart.add(
          OrderItem(
            item,
            1,
          ),
        );
      } else {
        existing.qty++;
      }
    });
  }

  // =========================
  // CHANGE QUANTITY
  // =========================

  void changeQty(
    OrderItem order,
    int delta,
  ) {
    setState(() {
      order.qty += delta;

      if (order.qty <= 0) {
        cart.remove(order);
      }
    });
  }

  // =========================
  // TOTAL
  // =========================

  double get cartTotal {
    double total = 0;

    for (final order in cart) {
      total += order.item.price * order.qty;
    }

    return total;
  }

  // =========================
  // MAIN BUILD
  // =========================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          titles[selectedIndex],
        ),
        actions: [
          if (selectedIndex == 1)
            Padding(
              padding: const EdgeInsets.only(
                right: 12,
              ),
              child: Center(
                child: Text(
                  '₹${cartTotal.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),

      // =========================
      // DRAWER
      // =========================

      drawer: Drawer(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 12,
              ),

              const CircleAvatar(
                radius: 34,
                child: Icon(
                  Icons.restaurant,
                  size: 34,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              const Text(
                'KGN TAVA FRY',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const Text(
                'Restaurant Management',
              ),

              const Divider(
                height: 28,
              ),

              Expanded(
                child: ListView.builder(
                  itemCount: titles.length,
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    return ListTile(
                      selected: selectedIndex == index,
                      leading: Icon(
                        _iconFor(index),
                      ),
                      title: Text(
                        titles[index],
                      ),
                      onTap: () {
                        Navigator.pop(context);

                        setState(() {
                          selectedIndex = index;
                        });
                      },
                    );
                  },
                ),
              ),

              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'No GST • Fast • Simple',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      body: _buildPage(),

      // =========================
      // CREATE BILL BUTTON
      // =========================

      floatingActionButton:
          selectedIndex == 1 && cart.isNotEmpty
              ? FloatingActionButton.extended(
                  onPressed: _showPaymentDialog,
                  icon: const Icon(
                    Icons.receipt_long,
                  ),
                  label: const Text(
                    'Create Bill',
                  ),
                )
              : null,
    );
  }

  // =========================
  // ICONS
  // =========================

  IconData _iconFor(
    int index,
  ) {
    const icons = [
      Icons.dashboard,
      Icons.point_of_sale,
      Icons.soup_kitchen,
      Icons.table_restaurant,
      Icons.restaurant_menu,
      Icons.inventory_2,
      Icons.payments,
      Icons.bar_chart,
    ];

    return icons[index];
  }

  // =========================
  // PAGE ROUTING
  // =========================

  Widget _buildPage() {
    switch (selectedIndex) {
      case 0:
        return _dashboard();

      case 1:
        return _billing();

      case 2:
        return _kot();

      case 3:
        return _tables();

      case 4:
        return _menu();

      case 5:
        return _inventory();

      case 6:
        return _expenses();

      case 7:
        return _reports();

      default:
        return const SizedBox.shrink();
    }
  }

  // =========================
  // DASHBOARD
  // =========================

  Widget _dashboard() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _welcomeCard(),

        const SizedBox(
          height: 16,
        ),

        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics:
              const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.55,
          children: [
            _statCard(
              'Today Sales',
              '₹12,450',
              Icons.currency_rupee,
            ),
            _statCard(
              'Orders',
              '48',
              Icons.receipt_long,
            ),
            _statCard(
              'KOT Pending',
              '6',
              Icons.soup_kitchen,
            ),
            _statCard(
              'Occupied Tables',
              '7/12',
              Icons.table_restaurant,
            ),
          ],
        ),

        const SizedBox(
          height: 20,
        ),

        _sectionTitle(
          'Quick Actions',
        ),

        const SizedBox(
          height: 8,
        ),

        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            _actionButton(
              'New Bill',
              Icons.add_shopping_cart,
              1,
            ),
            _actionButton(
              'New KOT',
              Icons.soup_kitchen,
              2,
            ),
            _actionButton(
              'Tables',
              Icons.table_restaurant,
              3,
            ),
            _actionButton(
              'Menu',
              Icons.restaurant_menu,
              4,
            ),
          ],
        ),
      ],
    );
  }

  // =========================
  // WELCOME CARD
  // =========================

  Widget _welcomeCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 28,
              child: Icon(
                Icons.restaurant,
              ),
            ),

            const SizedBox(
              width: 14,
            ),

            Expanded(
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Welcome to KGN TAVA FRY',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Billing, KOT and restaurant operations in one place.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // STAT CARD
  // =========================

  Widget _statCard(
    String title,
    String value,
    IconData icon,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon),

            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
              ),
            ),

            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // SECTION TITLE
  // =========================

  Widget _sectionTitle(
    String text,
  ) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  // =========================
  // ACTION BUTTON
  // =========================

  Widget _actionButton(
    String label,
    IconData icon,
    int page,
  ) {
    return FilledButton.icon(
      onPressed: () {
        setState(() {
          selectedIndex = page;
        });
      },
      icon: Icon(icon),
      label: Text(label),
    );
  }

  // =========================
  // BILLING
  // =========================

  Widget _billing() {
    return Row(
      children: [
        // MENU SIDE
        Expanded(
          flex: 3,
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              const Text(
                'Menu',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              ...menuItems.map(
                (item) => Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        item.name[0],
                      ),
                    ),

                    title: Text(
                      item.name,
                    ),

                    subtitle: Text(
                      item.category,
                    ),

                    trailing: FilledButton(
                      onPressed: () {
                        addToCart(item);
                      },
                      child: Text(
                        '₹${item.price.toStringAsFixed(0)}',
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // ORDER SIDE
        Expanded(
          flex: 2,
          child: Card(
            margin: const EdgeInsets.all(12),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(14),
                  child: Text(
                    'Current Order',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const Divider(
                  height: 1,
                ),

                Expanded(
                  child: cart.isEmpty
                      ? const Center(
                          child: Text(
                            'Add items to start a bill',
                          ),
                        )
                      : ListView.builder(
                          itemCount: cart.length,
                          itemBuilder:
                              (context, index) {
                            final order =
                                cart[index];

                            return ListTile(
                              title: Text(
                                order.item.name,
                              ),

                              subtitle: Text(
                                '₹${order.item.price.toStringAsFixed(0)} × ${order.qty}',
                              ),

                              trailing: Row(
                                mainAxisSize:
                                    MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      changeQty(
                                        order,
                                        -1,
                                      );
                                    },
                                    icon: const Icon(
                                      Icons
                                          .remove_circle_outline,
                                    ),
                                  ),

                                  Text(
                                    '${order.qty}',
                                  ),

                                  IconButton(
                                    onPressed: () {
                                      changeQty(
                                        order,
                                        1,
                                      );
                                    },
                                    icon: const Icon(
                                      Icons
                                          .add_circle_outline,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),

                const Divider(
                  height: 1,
                ),

                Padding(
                  padding:
                      const EdgeInsets.all(14),
                  child: Row(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),

                      Text(
                        '₹${cartTotal.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // =========================
  // KOT
  // =========================

  Widget _kot() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _sectionTitle(
          'Kitchen Order Tickets',
        ),

        const SizedBox(
          height: 10,
        ),

        _kotCard(
          'KOT #104',
          'Table 4',
          'Chicken Fry × 2 • Garlic Naan × 3',
          'Preparing',
        ),

        _kotCard(
          'KOT #105',
         
