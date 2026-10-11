import 'package:flutter/material.dart';

void main() => runApp(const BurhaniApp());

class BurhaniApp extends StatelessWidget {
  const BurhaniApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Burhani Waiter',
      theme: ThemeData(primarySwatch: Colors.orange, useMaterial3: true),
      home: const LoginPage(),
    );
  }
}

// ===== LOGIN =====
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  String selectedUser = 'Salman';
  final passController = TextEditingController();
  final users = {
    'Salman': '1234',
    'Aslam': '1234',
    'Admin': 'admin123',
  };
  void login() {
    if (passController.text == users[selectedUser]) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage(waiterName: selectedUser)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Wrong Password!')));
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Icon(Icons.restaurant, size: 80, color: Colors.orange),
            const SizedBox(height: 10),
            const Text('BURHANI RESTAURANT', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Text('Waiter Login', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 30),
            DropdownButtonFormField(value: selectedUser, items: users.keys.map((u) => DropdownMenuItem(value: u, child: Text(u))).toList(), onChanged: (v)=> setState(()=> selectedUser = v!), decoration: const InputDecoration(labelText: 'Select Waiter', border: OutlineInputBorder())),
            const SizedBox(height: 15),
            TextField(controller: passController, obscureText: true, decoration: const InputDecoration(labelText: 'Password', border: OutlineInputBorder()), onSubmitted: (_)=> login()),
            const SizedBox(height: 20),
            SizedBox(width: double.infinity, height: 50, child: ElevatedButton(onPressed: login, style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white), child: const Text('LOGIN', style: TextStyle(fontSize: 18)))),
            const SizedBox(height: 10),
            const Text('Salman: 1234 | Aslam: 1234 | Admin: admin123', style: TextStyle(fontSize: 11, color: Colors.grey))
          ]),
        ),
      ),
    );
  }
}

// ===== DATA =====
class MenuItem {
  final String name; final int halfPrice; final int fullPrice; final String category;
  MenuItem(this.name, this.halfPrice, this.fullPrice, this.category);
}
final List<MenuItem> menu = [
  MenuItem('Chicken Biryani', 120, 220, 'Biryani'),
  MenuItem('Mutton Biryani', 180, 320, 'Biryani'),
  MenuItem('Veg Biryani', 100, 180, 'Biryani'),
  MenuItem('Chicken Curry', 150, 260, 'Main Course'),
  MenuItem('Butter Chicken', 160, 280, 'Main Course'),
  MenuItem('Dal Fry', 80, 140, 'Main Course'),
  MenuItem('Tandoori Roti', 20, 20, 'Roti'),
  MenuItem('Naan', 30, 30, 'Roti'),
  MenuItem('Cold Drink', 30, 50, 'Drinks'),
];

class OrderItem {
  MenuItem item; bool isFull; int qty;
  OrderItem(this.item, this.isFull, this.qty);
  int get price => isFull? item.fullPrice : item.halfPrice;
  int get total => price * qty;
}

class TableOrder {
  int tableNo; List<OrderItem> items = []; bool isPaid = false;
  String waiter = ''; DateTime time = DateTime.now();
  TableOrder(this.tableNo);
  int get total => items.fold(0, (s, e) => s + e.total);
}

// ===== HOME PAGE =====
class HomePage extends StatefulWidget {
  final String waiterName;
  const HomePage({super.key, required this.waiterName});
  @override State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  List<TableOrder> tables = List.generate(8, (i) => TableOrder(i+1));
  List<TableOrder> billHistory = [];

  void openTable(int index) async {
    final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => OrderPage(table: tables[index], waiterName: widget.waiterName)));
    if (result!= null && result is TableOrder) {
      setState(() {
        if (result.isPaid && result.items.isNotEmpty) {
          billHistory.add(result);
          tables[index] = TableOrder(index+1);
        } else {
          tables[index] = result;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome ${widget.waiterName}'), backgroundColor: Colors.orange, foregroundColor: Colors.white, actions: [
        IconButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (_)=> BillsPage(history: billHistory)));}, icon: const Icon(Icons.receipt_long)),
        IconButton(onPressed: ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const LoginPage())), icon: const Icon(Icons.logout))
      ]),
      body: GridView.builder(padding: const EdgeInsets.all(12), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 1.3, crossAxisSpacing: 12, mainAxisSpacing: 12), itemCount: 8, itemBuilder: (c,i){
        final t = tables[i];
        final isBusy = t.items.isNotEmpty;
        return InkWell(onTap: ()=> openTable(i), child: Card(color: isBusy? Colors.orange.shade100 : Colors.white, elevation: 3, child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Icon(Icons.table_restaurant, size: 40, color: isBusy? Colors.orange : Colors.grey),
          Text('TABLE ${t.tableNo}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 5),
          Text(isBusy? 'Rs. ${t.total}\n${t.items.length} items' : 'Empty', textAlign: TextAlign.center, style: TextStyle(color: isBusy? Colors.orange.shade800 : Colors.grey)),
          if(isBusy) Text('by ${t.waiter}', style: const TextStyle(fontSize: 10))
        ])));
      }),
      bottomNavigationBar: Container(padding: const EdgeInsets.all(12), color: Colors.grey.shade100, child: Text('Total Bills Today: ${billHistory.length} | Total Sale: Rs. ${billHistory.fold(0, (s, e) => s + e.total)}', textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold))),
    );
  }
}

// ===== ORDER PAGE =====
class OrderPage extends StatefulWidget {
  final TableOrder table; final String waiterName;
  const OrderPage({super.key, required this.table, required this.waiterName});
  @override State<OrderPage> createState() => _OrderPageState();
}
class _OrderPageState extends State<OrderPage> {
  late TableOrder currentTable;
  String selectedCategory = 'All';
  @override void initState(){ super.initState(); currentTable = widget.table; if(currentTable.waiter.isEmpty) currentTable.waiter = widget.waiterName; }
  List<String> get categories => ['All',...{...menu.map((e)=> e.category)}];
  List<MenuItem> get filtered => selectedCategory=='All'? menu : menu.where((m)=> m.category==selectedCategory).toList();

  void addItem(MenuItem mi, bool isFull){
    setState(() {
      final idx = currentTable.items.indexWhere((e)=> e.item.name==mi.name && e.isFull==isFull);
      if(idx>=0) currentTable.items[idx].qty++; else currentTable.items.add(OrderItem(mi, isFull, 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Table ${currentTable.tableNo} - ${currentTable.waiter}'), backgroundColor: Colors.orange, foregroundColor: Colors.white),
      body: Column(children: [
        SizedBox(height: 45, child: ListView(scrollDirection: Axis.horizontal, padding: const EdgeInsets.all(8), children: categories.map((c)=> Padding(padding: const EdgeInsets.only(right: 8), child: ChoiceChip(label: Text(c), selected: selectedCategory==c, onSelected: (_)=> setState(()=> selectedCategory=c)))).toList())),
        Expanded(child: Row(children: [
          Expanded(flex: 3, child: ListView.builder(itemCount: filtered.length, itemBuilder: (c,i){
            final m = filtered[i];
            return Card(child: ListTile(title: Text(m.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)), subtitle: Text('H: Rs.${m.halfPrice} | F: Rs.${m.fullPrice}'), trailing: Row(mainAxisSize: MainAxisSize.min, children: [
              ElevatedButton(onPressed: ()=> addItem(m,false), style: ElevatedButton.styleFrom(minimumSize: const Size(45,35)), child: const Text('H')),
              const SizedBox(width: 5),
              ElevatedButton(onPressed: ()=> addItem(m,true), style: ElevatedButton.styleFrom(minimumSize: const Size(45,35), backgroundColor: Colors.orange), child: const Text('F', style: TextStyle(color: Colors.white))),
            ])));
          })),
          Expanded(flex: 2, child: Container(color: Colors.grey.shade100, child: Column(children: [
            Container(padding: const EdgeInsets.all(10), color: Colors.orange, child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('KOT', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)), Text('Rs. ${currentTable.total}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))])),
            Expanded(child: ListView.builder(itemCount: currentTable.items.length, itemBuilder: (c,i){
              final o = currentTable.items[i];
              return ListTile(dense: true, title: Text('${o.item.name} (${o.isFull?'F':'H'})', style: const TextStyle(fontSize: 12)), subtitle: Text('Rs.${o.price} x ${o.qty} = Rs.${o.total}', style: const TextStyle(fontSize: 11)), trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                InkWell(onTap: ()=> setState(()=> o.qty>1? o.qty-- : currentTable.items.removeAt(i)), child: const Icon(Icons.remove_circle, size: 20)),
                Padding(padding: const EdgeInsets.symmetric(horizontal: 6), child: Text('${o.qty}')),
                InkWell(onTap: ()=> setState(()=> o.qty++), child: const Icon(Icons.add_circle, size: 20)),
              ]));
            })),
            Padding(padding: const EdgeInsets.all(8), child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('TOTAL:', style: TextStyle(fontWeight: FontWeight.bold)), Text('Rs. ${currentTable.total}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))]),
              const SizedBox(height: 8),
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: currentTable.items.isEmpty? null : ()=> Navigator.pop(context, currentTable), style: ElevatedButton.styleFrom(backgroundColor: Colors.blue, foregroundColor: Colors.white), child: const Text('SAVE KOT'))),
              SizedBox(width: double.infinity, child: ElevatedButton(onPressed: currentTable.items.isEmpty? null : ()=> setState(()=> currentTable.isPaid=true), style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white), child: const Text('PAID & CLOSE'))),
            ]))
          ])))
        ]))
      ]),
    );
  }
}

class BillsPage extends StatelessWidget {
  final List<TableOrder> history;
  const BillsPage({super.key, required this.history});
  @override Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Day Bills'), backgroundColor: Colors.orange, foregroundColor: Colors.white),
      body: ListView.builder(itemCount: history.length, itemBuilder: (c,i){
        final b = history[i];
        return Card(margin: const EdgeInsets.all(8), child: ListTile(title: Text('Table ${b.tableNo} - Rs. ${b.total}'), subtitle: Text('${b.items.length} items | by ${b.waiter} | ${b.time.hour}:${b.time.minute}'), trailing: const Icon(Icons.check_circle, color: Colors.green)));
      }),
    );
  }
}
