import 'package:flutter/material.dart';

void main() => runApp(const KGNTableApp());

// MODELS
class MenuItem { String id, name, category, kitchen; double price; int stock; String emoji; MenuItem({required this.id, required this.name, required this.category, required this.kitchen, required this.price, this.stock=100, required this.emoji}); }
class TableModel { String id, name; String status; String? currentOrderId; TableModel({required this.id, required this.name, this.status='empty', this.currentOrderId}); }
class OrderItem { MenuItem item; int qty; String note; OrderItem({required this.item, required this.qty, this.note=''}); }
class Order { String id; String tableId; String type; String status; List<OrderItem> items; double discount; DateTime time; bool kotSent; Order({required this.id, required this.tableId, required this.type, required this.status, required this.items, this.discount=0, required this.time, this.kotSent=false}); double get total => items.fold(0,(s,i)=>s+i.item.price*i.qty) - discount; }

// MAIN APP
class KGNTableApp extends StatelessWidget {
  const KGNTableApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Table by KGN TAWA FRY',
      theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue), scaffoldBackgroundColor: const Color(0xFFF6F7FB)),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget { const MainScreen({super.key}); @override State<MainScreen> createState()=>_MainScreenState(); }

class _MainScreenState extends State<MainScreen> {
  int navIndex = 0;
  // DATA
  List<MenuItem> menu = [
    MenuItem(id:'1', name:'Chicken Biryani Half', category:'CHICKEN', kitchen:'Main', price:80, emoji:'🍚'),
    MenuItem(id:'2', name:'Chicken Masala Half', category:'CHICKEN', kitchen:'Main', price:120, emoji:'🍛'),
    MenuItem(id:'3', name:'Butter Chicken Boneless Half', category:'CHICKEN', kitchen:'Tandoor', price:170, emoji:'🍗'),
    MenuItem(id:'4', name:'Kheema Masala Half', category:'MUTTON', kitchen:'Main', price:130, emoji:'🥘'),
    MenuItem(id:'5', name:'Bheja Masala Half', category:'MUTTON', kitchen:'Main', price:130, emoji:'🍲'),
    MenuItem(id:'6', name:'Fish Fry Full', category:'FISH', kitchen:'Fry', price:160, emoji:'🐟'),
    MenuItem(id:'7', name:'Zinga Rice Half', category:'PRAWNS', kitchen:'Main', price:170, emoji:'🍤'),
    MenuItem(id:'8', name:'Chapati Roti', category:'ROTI', kitchen:'Tandoor', price:7, stock:500, emoji:'🫓'),
    MenuItem(id:'9', name:'Plain Rice', category:'RICE', kitchen:'Main', price:30, emoji:'🍚'),
    MenuItem(id:'10', name:'Dal Fry Full', category:'DAL', kitchen:'Main', price:100, emoji:'🍲'),
  ];
  List<TableModel> tables = List.generate(12, (i)=> TableModel(id:'T${i+1}', name:'T-${i+1}'));
  List<Order> orders = [];
  double todaysSale = 49;
  int todaysOrderCount = 1;
  List<OrderItem> currentCart = [];
  String currentTableId = 'Takeaway';
  String currentOrderType = 'Dine-in';

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: _getPage(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: navIndex,
        onDestinationSelected: (i)=>setState(()=>navIndex=i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label:'Home'),
          NavigationDestination(icon: Icon(Icons.table_restaurant_outlined), selectedIcon: Icon(Icons.table_restaurant), label:'Tables'),
          NavigationDestination(icon: Icon(Icons.receipt_long_outlined), selectedIcon: Icon(Icons.receipt_long), label:'Orders'),
          NavigationDestination(icon: Icon(Icons.restaurant_menu_outlined), selectedIcon: Icon(Icons.restaurant_menu), label:'Menu'),
          NavigationDestination(icon: Icon(Icons.menu), label:'More'),
        ],
      ),
      floatingActionButton: navIndex==1? FloatingActionButton.extended(onPressed: _addTable, icon: const Icon(Icons.add), label: const Text("Add Table")) :
      FloatingActionButton(onPressed: ()=>setState(()=>navIndex=1), backgroundColor: Colors.blue, child: const Icon(Icons.add, color: Colors.white)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _getPage(){
    switch(navIndex){
      case 0: return _homePage();
      case 1: return _tablesPage();
      case 2: return _ordersPage();
      case 3: return _menuPage();
      default: return _morePage();
    }
  }

  // HOME PAGE - EXACT VIDEO JAI SA
  Widget _homePage(){
    return SafeArea(child: SingleChildScrollView(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [const Text("KGN TAWA FRY ▼", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), const Spacer(), IconButton(onPressed: (){}, icon: const Icon(Icons.notifications_none))]),
      const SizedBox(height:16),
      const Text("Quick Actions", style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height:12),
      Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        _quick(Icons.check_circle, "Closed Orders", "${orders.where((o)=>o.status=='closed').length}"),
        _quick(Icons.access_time, "On Hold Orders", "${orders.where((o)=>o.status=='hold').length}"),
        _quick(Icons.restaurant_menu, "Add Items", "${menu.length}"),
      ]),
      const SizedBox(height:20),
      const Text("Business Overview", style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height:10),
      Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
        child: Column(children: [
          Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text("Today's sales", style: TextStyle(color: Colors.grey, fontSize: 12)), Text("₹ $todaysSale", style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20)), Text("₹ 1579.0 (Yesterday's)", style: TextStyle(fontSize: 11, color: Colors.grey[600]))])),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [const Text("Today's orders", style: TextStyle(color: Colors.grey, fontSize: 12)), Text("$todaysOrderCount", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)), Text("4 (Yesterday's)", style: TextStyle(fontSize: 11, color: Colors.grey[600]))])),
          ]),
          const SizedBox(height:12),
          const Divider(),
          InkWell(onTap: ()=>setState(()=>navIndex=2), child: const Row(children: [Text("Top selling items & more insights!", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w500, fontSize: 13)), Spacer(), Icon(Icons.arrow_forward_ios, size:14, color: Colors.blue)])),
        ]),
      ),
      const SizedBox(height:20),
      const Text("FEATURES FOR YOU", style: TextStyle(fontSize: 11, letterSpacing: 1, color: Colors.grey, fontWeight: FontWeight.bold)),
      const SizedBox(height:12),
      Row(children: [
        _featureCard("KOT View", "Kitchen Orders", Icons.soup_kitchen, Colors.orange),
        const SizedBox(width:12),
        _featureCard("Waiter App", "Take orders", Icons.person, Colors.green),
        const SizedBox(width:12),
        _featureCard("Inventory", "Stock track", Icons.inventory, Colors.purple),
      ]),
    ])));
  }

  Widget _quick(IconData ic, String title, String sub){
    return Column(children: [
      Container(padding: const EdgeInsets.all(14), decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle), child: Icon(ic, color: Colors.white, size: 22)),
      const SizedBox(height:6),
      Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
      Text(sub, style: const TextStyle(fontSize: 10, color: Colors.grey)),
    ]);
  }
  Widget _featureCard(String t, String s, IconData ic, Color c){
    return Expanded(child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [CircleAvatar(backgroundColor: c.withOpacity(0.15), child: Icon(ic, color: c, size:18)), const SizedBox(height:8), Text(t, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)), Text(s, style: const TextStyle(fontSize: 10, color: Colors.grey)) ])));
  }

  // TABLES PAGE
  Widget _tablesPage(){
    return SafeArea(child: Column(children: [
      Padding(padding: const EdgeInsets.all(16), child: Row(children: [const Text("Table Management", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)), const Spacer(), _statusDot(Colors.green, "Empty"), const SizedBox(width:8), _statusDot(Colors.orange, "Occupied"), const SizedBox(width:8), _statusDot(Colors.red, "Bill")])),
      Expanded(child: GridView.builder(padding: const EdgeInsets.all(12), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 1.2, crossAxisSpacing: 10, mainAxisSpacing: 10), itemCount: tables.length, itemBuilder: (_,i){
        var t = tables[i];
        Color col = t.status=='empty'? Colors.green : t.status=='occupied'? Colors.orange : Colors.red;
        return InkWell(onTap: ()=>_openTableBilling(t), child: Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: col.withOpacity(0.5), width:2)), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.table_restaurant, color: col), const SizedBox(height:6), Text(t.name, style: TextStyle(fontWeight: FontWeight.bold, color: col)), Text(t.status.toUpperCase(), style: TextStyle(fontSize: 10, color: col))])));
      })),
    ]));
  }
  Widget _statusDot(Color c, String l)=> Row(children: [Container(width:10,height:10,decoration: BoxDecoration(color: c, shape: BoxShape.circle)), const SizedBox(width:4), Text(l, style: const TextStyle(fontSize: 10))]);
  void _addTable(){ setState(()=>tables.add(TableModel(id:'T${tables.length+1}', name:'T-${tables.length+1}'))); }

  // BILLING FOR TABLE
  void _openTableBilling(TableModel table){
    currentTableId = table.name;
    currentOrderType = 'Dine-in';
    currentCart = [];
    setState(()=>navIndex=4); // go to billing sheet actually we show modal
    showModalBottomSheet(context: context, isScrollControlled: true, backgroundColor: Colors.white, shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))), builder: (_)=> _billingSheet(table));
  }

  Widget _billingSheet(TableModel? table){
    return StatefulBuilder(builder: (context, setModal){
      double total = currentCart.fold(0,(s,i)=>s+i.item.price*i.qty);
      return DraggableScrollableSheet(expand: false, initialChildSize: 0.9, builder: (_,ctrl)=> Column(children: [
        Padding(padding: const EdgeInsets.all(16), child: Row(children: [Text("Add Order - ${table?.name?? currentTableId}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), const Spacer(), IconButton(onPressed: ()=>Navigator.pop(context), icon: const Icon(Icons.close))])),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: Row(children: [
          ChoiceChip(label: const Text("Dine-in"), selected: currentOrderType=='Dine-in', onSelected: (_){ setModal(()=>currentOrderType='Dine-in'); setState(()=>currentOrderType='Dine-in'); }),
          const SizedBox(width:8),
          ChoiceChip(label: const Text("Takeaway"), selected: currentOrderType=='Takeaway', onSelected: (_){ setModal(()=>currentOrderType='Takeaway'); setState(()=>currentOrderType='Takeaway'); }),
          const SizedBox(width:8),
          ChoiceChip(label: const Text("Delivery"), selected: currentOrderType=='Delivery', onSelected: (_){ setModal(()=>currentOrderType='Delivery'); setState(()=>currentOrderType='Delivery'); }),
        ])),
        const SizedBox(height:8),
        // MENU GRID
        Expanded(child: GridView.builder(controller: ctrl, padding: const EdgeInsets.all(10), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: 0.75, crossAxisSpacing: 8, mainAxisSpacing: 8), itemCount: menu.length, itemBuilder: (_,i){
          var m = menu[i];
          var existing = currentCart.where((c)=>c.item.id==m.id).toList();
          int qty = existing.isEmpty?0:existing.first.qty;
          return Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)), child: Column(children: [
            Expanded(child: Container(decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: const BorderRadius.vertical(top: Radius.circular(12))), child: Center(child: Text(m.emoji, style: const TextStyle(fontSize: 36))))),
            Padding(padding: const EdgeInsets.all(6), child: Column(children: [
              Text(m.name, maxLines:2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
              Text("₹${m.price}", style: const TextStyle(fontSize: 11, color: Colors.grey)),
              const SizedBox(height:4),
              qty==0? InkWell(onTap:(){ setModal(()=>currentCart.add(OrderItem(item:m, qty:1))); setState((){}); }, child: Container(padding: const EdgeInsets.symmetric(horizontal:16, vertical:4), decoration: BoxDecoration(border: Border.all(color: Colors.blue), borderRadius: BorderRadius.circular(6)), child: const Text("+ Add", style: TextStyle(color: Colors.blue, fontSize: 11)))) :
              Container(decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(6)), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                InkWell(onTap:(){ setModal((){ var f=currentCart.firstWhere((c)=>c.item.id==m.id); f.qty--; if(f.qty<=0) currentCart.remove(f); }); setState((){}); }, child: const Padding(padding: EdgeInsets.all(6), child: Icon(Icons.remove, size:14, color: Colors.white))),
                Text("$qty", style: const TextStyle(color: Colors.white, fontSize: 12)),
                InkWell(onTap:(){ setModal(()=>currentCart.firstWhere((c)=>c.item.id==m.id).qty++); setState((){}); }, child: const Padding(padding: EdgeInsets.all(6), child: Icon(Icons.add, size:14, color: Colors.white))),
              ])),
            ])),
          ]));
        })),
        if(currentCart.isNotEmpty) Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)]), child: Column(children: [
          Row(children: [const Icon(Icons.shopping_cart, size:18), const SizedBox(width:8), Text("${currentCart.length} Items ₹$total", style: const TextStyle(fontWeight: FontWeight.bold)), const Spacer(), TextButton(onPressed: (){ setModal(()=>currentCart.clear()); setState(()=>currentCart.clear()); }, child: const Text("Clear"))]),
          const SizedBox(height:8),
          Row(children: [
            Expanded(child: OutlinedButton(onPressed: (){
              var order = Order(id:'${DateTime.now().millisecondsSinceEpoch}', tableId: currentTableId, type: currentOrderType, status:'hold', items: List.from(currentCart), time: DateTime.now(), kotSent: false);
              setState(()=> orders.add(order));
              if(table!=null) { table.status='occupied'; table.currentOrderId=order.id; }
              currentCart.clear();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Order On Hold - KOT Pending")));
            }, child: const Text("Save & Hold"))),
            const SizedBox(width:10),
            Expanded(child: OutlinedButton(style: OutlinedButton.styleFrom(backgroundColor: Colors.orange.shade50), onPressed: (){
              // KOT
              var order = Order(id:'${DateTime.now().millisecondsSinceEpoch}', tableId: currentTableId, type: currentOrderType, status:'kot', items: List.from(currentCart), time: DateTime.now(), kotSent: true);
              setState(()=> orders.add(order));
              if(table!=null) table.status='occupied';
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("KOT Sent to Kitchen - ${order.items.length} items")));
            }, child: const Text("Send KOT"))),
            const SizedBox(width:10),
            Expanded(child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.blue), onPressed: (){
              var order = Order(id:'${DateTime.now().millisecondsSinceEpoch}', tableId: currentTableId, type: currentOrderType, status:'closed', items: List.from(currentCart), time: DateTime.now(), kotSent: true);
              setState(()=>{ orders.add(order); todaysSale+=total; todaysOrderCount++; if(table!=null){ table.status='empty'; table.currentOrderId=null; } });
              Navigator.pop(context);
              _showBill(order);
              currentCart.clear();
            }, child: const Text("Save & Bill", style: TextStyle(color: Colors.white)))),
          ]),
        ])),
      ]));
    });
  }

  void _showBill(Order order){
    showDialog(context: context, builder: (_)=> AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Column(children: [const Text("KGN TAWA FRY", style: TextStyle(fontWeight: FontWeight.bold)), Text("+91 7016742863", style: TextStyle(fontSize: 11, color: Colors.grey[600])), const Divider(), Text("Bill of Supply - ${order.type}", style: const TextStyle(fontSize: 12)), Text("Table: ${order.tableId} | ${order.time.hour}:${order.time.minute}", style: const TextStyle(fontSize: 10, color: Colors.grey))]),
      content: Column(mainAxisSize: MainAxisSize.min, children: [
       ...order.items.map((e)=> Padding(padding: const EdgeInsets.symmetric(vertical:2), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Expanded(child: Text("${e.item.name} x${e.qty}", style: const TextStyle(fontSize: 12))), Text("₹${e.item.price*e.qty}", style: const TextStyle(fontSize: 12))]))),
        const Divider(),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text("Total", style: TextStyle(fontWeight: FontWeight.bold)), Text("₹${order.total}", style: const TextStyle(fontWeight: FontWeight.bold))]),
        const SizedBox(height:10),
        const Text("No GST - Thank you!", style: TextStyle(fontSize: 10, color: Colors.grey)),
      ]),
      actions: [TextButton(onPressed: ()=>Navigator.pop(context), child: const Text("Close")), ElevatedButton(onPressed: (){Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Printed to Thermal Printer 🖨️")));}, child: const Text("Print & Close"))],
    ));
  }

  // ORDERS PAGE WITH KOT
  Widget _ordersPage(){
    return DefaultTabController(length: 4, child: SafeArea(child: Column(children: [
      AppBar(title: const Text("Orders & KOT"), backgroundColor: Colors.white, bottom: const TabBar(tabs: [Tab(text:"All"), Tab(text:"KOT"), Tab(text:"On Hold"), Tab(text:"Closed")])),
      Expanded(child: TabBarView(children: [
        _orderList(orders),
        _orderList(orders.where((o)=>o.status=='kot').toList(), isKOT:true),
        _orderList(orders.where((o)=>o.status=='hold').toList()),
        _orderList(orders.where((o)=>o.status=='closed').toList()),
      ])),
    ])));
  }
  Widget _orderList(List<Order> list, {bool isKOT=false}){
    if(list.isEmpty) return Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.receipt_long, size:60, color: Colors.grey.shade300), const SizedBox(height:10), Text(isKOT? "No KOT Pending" : "No Orders", 
