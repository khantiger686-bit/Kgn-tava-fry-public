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
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('KOT Sent for $selectedTable - ${cart.length} items')));
  }

  void printReceipt() {
    if(cart.isEmpty) return;
    final dateStr = DateFormat('dd-MM-yyyy hh:mm a').format(DateTime.now());
    final upiId = "kgnrestaurant@upi"; // Yahan apna UPI ID daalo
    final upiString = "upi://pay?pa=$upiId&pn=TableByKgn&am=$finalTotal&cu=INR";

    showDialog(context: context, builder: (ctx) => AlertDialog(
      title: const Text('Final Bill + UPI QR'),
      content: SingleChildScrollView(
        child: Column(children: [
          const Text('TABLE BY KGN\nRestaurant & Cafe', textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
          const Divider(),
          Text('Table: $selectedTable | $dateStr'),
          const Divider(),
        ...cart.map((i) => Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('${i.item.name} x${i.quantity}'), Text('₹${i.total.toStringAsFixed(0)}')])),
          const Divider(),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('TOTAL:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)), Text('₹${finalTotal.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.deepOrange))]),
          const SizedBox(height: 15),
          QrImageView(data: upiString, version: QrVersions.auto, size: 160),
          const Text('Scan & Pay via UPI', style: TextStyle(fontSize: 12)),
        ]),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Close')),
        ElevatedButton(onPressed: () {
          setState(() { todaySale += finalTotal; cart.clear(); });
          Navigator.pop(ctx);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bill Printed Successfully!')));
        }, child: const Text('PRINT BILL')),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PRO - Sale: ₹${todaySale.toStringAsFixed(0)}'),
        backgroundColor: Colors.deepOrange, foregroundColor: Colors.white,
        actions: [IconButton(onPressed: () => showDialog(context: context, builder: (_) => AlertDialog(title: const Text('Daily Report'), content: Text('Today Sale: ₹$todaySale'))), icon: const Icon(Icons.bar_chart))],
      ),
      body: Row(children: [
        Expanded(flex: 3, child: Padding(padding: const EdgeInsets.all(12), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Select Table:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 45, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: tables.length, itemBuilder: (c,i) => Padding(padding: const EdgeInsets.only(right: 8), child: ChoiceChip(label: Text(tables[i]), selected: selectedTable==tables[i], onSelected: (v) => setState(() => selectedTable=tables[i])))))),
          const Divider(),
          SizedBox(height: 40, child: ListView.builder(scrollDirection: Axis.horizontal, itemCount: categories.length, itemBuilder: (c,i) => Padding(padding: const EdgeInsets.only(right: 8), child: FilterChip(label: Text(categories[i]), selected: selectedCategory==categories[i], onSelected: (v) => setState(() => selectedCategory=categories[i]))))),
          const SizedBox(height: 8),
          Expanded(child: GridView.builder(gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1.2, crossAxisSpacing: 10, mainAxisSpacing: 10), itemCount: filteredMenu.length, itemBuilder: (c,i) {
            final item = filteredMenu[i];
            return InkWell(onTap: () => addToCart(item), child: Container(decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(8), border: Border.all(color: Colors.orange.shade200)), padding: const EdgeInsets.all(8), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text(item.name, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)), Text('₹${item.price.toStringAsFixed(0)}', style: const TextStyle(color: Colors.deepOrange))])));
          })),
        ]))),
        const VerticalDivider(),
        Expanded(flex: 2, child: Container(color: Colors.grey.shade50, padding: const EdgeInsets.all(12), child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text('Order ($selectedTable)', style: const TextStyle(fontWeight: FontWeight.bold)), TextButton(onPressed: () => setState(() => cart.clear()), child: const Text('Clear', style: TextStyle(color: Colors.red)))]),
          Expanded(child: ListView.builder(itemCount: cart.length, itemBuilder: (c,i) => Card(child: ListTile(title: Text(cart[i].item.name), subtitle: Text('₹${cart[i].item.price} x ${cart[i].quantity}'), trailing: Row(mainAxisSize: MainAxisSize.min, children: [IconButton(icon: const Icon(Icons.remove), onPressed: () => updateQuantity(i, -1)), Text('${cart[i].quantity}'), IconButton(icon: const Icon(Icons.add), onPressed: () => updateQuantity(i, 1))]))))),
          DropdownButton<double>(value: discountPercentage, isExpanded: true, items: [0.0, 5.0, 10.0, 15.0, 20.0].map((v) => DropdownMenuItem(value: v, child: Text('Discount ${v.toStringAsFixed(0)}%'))).toList(), onChanged: (v) => setState(() => discountPercentage=v!)),
          Text('Total: ₹${finalTotal.toStringAsFixed(0)}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
          const SizedBox(height: 8),
          Row(children: [
            Expanded(child: OutlinedButton(onPressed: printKOT, child: const Text('KOT'))),
            const SizedBox(width: 8),
            Expanded(child: ElevatedButton(onPressed: printReceipt, style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange, foregroundColor: Colors.white), child: const Text('PRINT BILL'))),
          ])
        ])))
      ]),
    );
  }
}
