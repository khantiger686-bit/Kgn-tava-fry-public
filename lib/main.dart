import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const TableByKgnApp());
}

class TableByKgnApp extends StatelessWidget {
  const TableByKgnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Table by Kgn',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        useMaterial3: true,
      ),
      home: const BillingPOSScreen(),
    );
  }
}

// Item Model
class MenuItem {
  final String id;
  final String name;
  final double price;
  final String category;

  MenuItem({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
  });
}

// Cart Item Model
class CartItem {
  final MenuItem item;
  int quantity;

  CartItem({required this.item, this.quantity = 1});

  double get total => item.price * quantity;
}

class BillingPOSScreen extends StatefulWidget {
  const BillingPOSScreen({super.key});

  @override
  State<BillingPOSScreen> createState() => _BillingPOSScreenState();
}

class _BillingPOSScreenState extends State<BillingPOSScreen> {
  // Sample Tables Data
  final List<String> tables = ['T-01', 'T-02', 'T-03', 'T-04', 'T-05', 'Takeaway'];
  String selectedTable = 'T-01';

  // Sample Menu Data
  final List<MenuItem> menuItems = [
    MenuItem(id: '1', name: 'Paneer Butter Masala', price: 260.0, category: 'Main Course'),
    MenuItem(id: '2', name: 'Butter Naan', price: 40.0, category: 'Breads'),
    MenuItem(id: '3', name: 'Chicken Biryani', price: 290.0, category: 'Main Course'),
    MenuItem(id: '4', name: 'Veg Fried Rice', price: 180.0, category: 'Chinese'),
    MenuItem(id: '5', name: 'Cold Coffee', price: 120.0, category: 'Beverages'),
    MenuItem(id: '6', name: 'Gulab Jamun (2 Pcs)', price: 80.0, category: 'Desserts'),
  ];

  // Cart & Order State
  List<CartItem> cart = [];
  double discountPercentage = 0.0;

  // Calculation Logic
  double get subtotal => cart.fold(0, (sum, item) => sum + item.total);
  double get discountAmount => (subtotal * discountPercentage) / 100;
  double get finalTotal => subtotal - discountAmount;

  void addToCart(MenuItem item) {
    setState(() {
      int index = cart.indexWhere((c) => c.item.id == item.id);
      if (index != -1) {
        cart[index].quantity++;
      } else {
        cart.add(CartItem(item: item));
      }
    });
  }

  void updateQuantity(int index, int delta) {
    setState(() {
      cart[index].quantity += delta;
      if (cart[index].quantity <= 0) {
        cart.removeAt(index);
      }
    });
  }

  void printReceipt() {
    if (cart.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cart is empty! Add items first.')),
      );
      return;
    }

    final dateStr = DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.now());

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Receipt Preview (ESC/POS)'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Text(
                  'TABLE BY KGN\nRestaurant & Cafe',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const Divider(),
              Text('Table: $selectedTable'),
              Text('Date: $dateStr'),
              const Divider(),
              ...cart.map((i) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('${i.item.name} x${i.quantity}'),
                      Text('₹${i.total.toStringAsFixed(0)}'),
                    ],
                  )),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Subtotal:'),
                  Text('₹${subtotal.toStringAsFixed(0)}'),
                ],
              ),
              if (discountPercentage > 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Discount (${discountPercentage.toStringAsFixed(0)}%):'),
                    Text('-₹${discountAmount.toStringAsFixed(0)}'),
                  ],
                ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('GRAND TOTAL:', style: TextStyle(fontWeight: FontWeight.bold)),
                  Text('₹${finalTotal.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const Divider(),
              const Center(child: Text('Thank You! Visit Again.')),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              setState(() => cart.clear());
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Bill Sent to Thermal Printer!')),
              );
            },
            child: const Text('Print Bill'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Table by Kgn — POS Billing'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Row(
        children: [
          // LEFT SIDE: Menu & Tables Panel
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAlignment.start,
                children: [
                  // Table Selector
                  const Text('Select Table:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 45,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: tables.length,
                      itemBuilder: (context, index) {
                        final isSelected = selectedTable == tables[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ChoiceChip(
                            label: Text(tables[index]),
                            selected: isSelected,
                            selectedColor: Colors.deepOrange,
                            labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
                            onSelected: (val) {
                              setState(() => selectedTable = tables[index]);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const Divider(height: 25),
                  // Menu Grid
                  const Text('Menu Items:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 8),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1.2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: menuItems.length,
                      itemBuilder: (context, index) {
                        final item = menuItems[index];
                        return InkWell(
                          onTap: () => addToCart(item),
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.deepOrange.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.deepOrange.shade200),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  item.name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  '₹${item.price.toStringAsFixed(0)}',
                                  style: TextStyle(color: Colors.deepOrange.shade900, fontWeight: FontWeight.w600),
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
            ),
          ),

          const VerticalDivider(width: 1),

          // RIGHT SIDE: Order Cart & Billing Summary
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.grey.shade50,
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Current Order ($selectedTable)', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      TextButton(
                        onPressed: () => setState(() => cart.clear()),
                        child: const Text('Clear', style: TextStyle(color: Colors.red)),
                      )
                    ],
                  ),
                  const Divider(),
                  // Cart Item List
                  Expanded(
                    child: cart.isEmpty
                        ? const Center(child: Text('No items added to cart'))
                        : ListView.builder(
                            itemCount: cart.length,
                            itemBuilder: (context, index) {
                              final item = cart[index];
                              return Card(
                                elevation: 0,
                                color: Colors.white,
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAlignment.start,
                                          children: [
                                            Text(item.item.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                                            Text('₹${item.item.price.toStringAsFixed(0)} each'),
                                          ],
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.remove_circle_outline, size: 20),
                                            onPressed: () => updateQuantity(index, -1),
                                          ),
                                          Text('${item.quantity}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                          IconButton(
                                            icon: const Icon(Icons.add_circle_outline, size: 20),
                                            onPressed: () => updateQuantity(index, 1),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 50,
                                        child: Text(
                                          '₹${item.total.toStringAsFixed(0)}',
                                          textAlign: TextAlign.right,
                                          style: const TextStyle(fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  const Divider(),
                  // Discount Slider / Input
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Discount (%):'),
                      DropdownButton<double>(
                        value: discountPercentage,
                        items: [0.0, 5.0, 10.0, 15.0, 20.0].map((double val) {
                          return DropdownMenuItem<double>(
                            value: val,
                            child: Text('${val.toStringAsFixed(0)}%'),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) setState(() => discountPercentage = val);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Bill Summary
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Subtotal:'),
                      Text('₹${subtotal.toStringAsFixed(0)}'),
                    ],
                  ),
                  if (discountPercentage > 0)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Discount Amount:'),
                        Text('-₹${discountAmount.toStringAsFixed(0)}', style: const TextStyle(color: Colors.green)),
                      ],
                    ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Bill:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                      Text(
                        '₹${finalTotal.toStringAsFixed(0)}',
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.deepOrange),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: printReceipt,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepOrange,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: const Text('PRINT BILL', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
