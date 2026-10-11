import 'package:flutter/material.dart';

void main() => runApp(const KGNApp());
class KGNApp extends StatelessWidget {
  const KGNApp({super.key});
  @override Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, theme: ThemeData(useMaterial3: true, scaffoldBackgroundColor: const Color(0xFFF6F7FB), colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFD95A00))), home: const TablesOverview());
  }
}

// MODELS
class Dish { String name; String cat; int half; int full; String station; bool veg; bool active; Dish(this.name,this.cat,this.half,this.full,this.station,{this.veg=false,this.active=true});}
class OrderLine { Dish dish; bool isFull; int qty; OrderLine(this.dish,this.isFull,this.qty); int get rate => isFull? dish.full : dish.half; int get total => rate*qty; }
class TableData { int no; String pax; bool occupied; int mins; int amount; String waiter; String status; List<OrderLine> kot; TableData(this.no,this.pax,this.occupied,this.mins,this.amount,this.waiter,this.status,this.kot);}

List<Dish> dishes = [
 Dish('Chicken Biryani','Biryani',120,220,'KOT 1 TANDOOR & RICE', veg:false),
 Dish('Mutton Biryani','Biryani',180,320,'KOT 1', veg:false),
 Dish('Veg Biryani','Biryani',100,180,'KOT 1', veg:true),
 Dish('Chicken Curry','Main Course',150,260,'KOT 2', veg:false),
 Dish('Butter Chicken','Main Course',160,280,'KOT 2', veg:false),
 Dish('Dal Fry','Main Course',80,140,'KOT 2', veg:true),
 Dish('Tandoori Roti','Roti',20,20,'KOT 1', veg:true),
 Dish('Butter Naan','Roti',30,30,'KOT 1', veg:true),
 Dish('Cold Drink','Drinks',30,50,'KOT 3', veg:true),
];
List<TableData> tables = [
 TableData(1,'4 Pax',true,24,440,'Salman','Occupied',[OrderLine(dishes[0],true,2)]),
 TableData(2,'2-4 Pax',false,0,0,'','Vacant',[]),
 TableData(3,'6 Pax',true,12,820,'Aslam','Occupied',[OrderLine(dishes[1],true,2), OrderLine(dishes[4],true,1)]),
 TableData(4,'4 Pax',false,0,0,'','Vacant',[]),
 TableData(5,'2 Pax',true,8,280,'Salman','Occupied',[OrderLine(dishes[3],true,1)]),
 TableData(6,'4 Pax',false,0,0,'','Vacant',[]),
 TableData(7,'2 Pax',false,0,0,'','Vacant',[]),
 TableData(8,'8 Pax',false,0,0,'','Vacant',[]),
];

// TABLES OVERVIEW - EXACT LIKE PHOTO 6
class TablesOverview extends StatefulWidget { const TablesOverview({super.key}); @override State<TablesOverview> createState()=> _TablesOverviewState();}
class _TablesOverviewState extends State<TablesOverview> {
 int selectedBottom = 0;
 @override Widget build(BuildContext context) {
   int busy = tables.where((t)=> t.occupied).length;
   return Scaffold(
     backgroundColor: const Color(0xFFF6F7FB),
     appBar: AppBar(toolbarHeight: 70, backgroundColor: Colors.white, title: Row(children: [Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: const Color(0xFFD95A00), borderRadius: BorderRadius.circular(8)), child: const Icon(Icons.restaurant_menu, color: Colors.white)), const SizedBox(width:10), const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Burhani Restaur...', style: TextStyle(fontSize:13,fontWeight:FontWeight.bold)), Text('TABLES OVERVIEW', style: TextStyle(fontSize:14,fontWeight:FontWeight.w900, color: Color(0xFF7A3B00)))] )]), actions: [Container(padding: const EdgeInsets.symmetric(horizontal:10,vertical:4), decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(20)), child: Row(children: [Container(width:8,height:8,decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)), const SizedBox(width:5), const Text('Salman', style: TextStyle(fontSize:12))])), const SizedBox(width:8), const CircleAvatar(backgroundImage: NetworkImage('https://i.pravatar.cc/100')), const SizedBox(width:8)]),
     body: SingleChildScrollView(padding: const EdgeInsets.all(12), child: Column(children: [
       Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)), child: Column(children: [
         Row(children: [const Icon(Icons.restaurant, size:18), const SizedBox(width:6), const Text('Shift Active • Main Floor', style: TextStyle(fontSize:12, color: Colors.grey)), const Spacer(), Container(padding: const EdgeInsets.symmetric(horizontal:8,vertical:2), decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(12)), child: const Text('• LIVE FLOOR', style: TextStyle(fontSize:10, fontWeight: FontWeight.bold)))]),
         const SizedBox(height:6), Row(children: [const Text('Welcome, Salman', style: TextStyle(fontSize:20, fontWeight: FontWeight.bold)), const Text(' 👋', style: TextStyle(fontSize:20))]),
         const SizedBox(height:12),
         Row(children: [
           Expanded(child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: const Color(0xFFFFF0E8), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.orange.shade100)), child: Row(children: [const Icon(Icons.table_bar, size:16, color: Color(0xFF7A3B00)), const SizedBox(width:6), Text('$busy Busy', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF7A3B00))), const Spacer(), Text('${(busy/8*100).round()}%', style: const TextStyle(fontWeight: FontWeight.bold))]))),
           const SizedBox(width:8),
           Expanded(child: Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: const Color(0xFFF0F4FF), borderRadius: BorderRadius.circular(12)), child: Row(children: [const Icon(Icons.check_circle_outline, size:16), const SizedBox(width:6), Text('${8-busy} Vacant', style: const TextStyle(fontWeight: FontWeight.bold)), const Spacer(), Text('${((8-busy)/8*100).round()}%')])))
         ])
       ])),
       const SizedBox(height:12),
       Row(children: [Container(padding: const EdgeInsets.symmetric(horizontal:12,vertical:6), decoration: BoxDecoration(color: const Color(0xFF7A3B00), borderRadius: BorderRadius.circular(20)), child: Text('All Tables ${tables.length}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize:12))), const SizedBox(width:8), Text('● Occupied $busy', style: const TextStyle(fontSize:12)), const SizedBox(width:8), Text('● Vacant ${8-busy}', style: const TextStyle(fontSize:12, color: Colors.grey))]),
       const SizedBox(height:12),
       GridView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: 8, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2, childAspectRatio:0.85, crossAxisSpacing:10, mainAxisSpacing:10), itemBuilder: (c,i){
         final t = tables[i];
         return Container(decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), border: Border.all(color: t.occupied? const Color(0xFFD95A00).withOpacity(0.3) : Colors.grey.shade200)), child: Padding(padding: const EdgeInsets.all(10), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
           Row(children: [Container(width:32,height:32, alignment: Alignment.center, decoration: BoxDecoration(color: t.occupied? const Color(0xFF7A3B00): const Color(0xFFE3EBFF), borderRadius: BorderRadius.circular(8)), child: Text('${t.no}', style: TextStyle(fontWeight: FontWeight.bold, color: t.occupied? Colors.white: Colors.black))), const SizedBox(width:6), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('T-0${t.no}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize:12)), Text(t.pax, style: const TextStyle(fontSize:11, color: Colors.grey))]), const Spacer(), Container(padding: const EdgeInsets.symmetric(horizontal:6,vertical:2), decoration: BoxDecoration(color: t.occupied? const Color(0xFFFFE5D1): const Color(0xFFF0F4FF), borderRadius: BorderRadius.circular(10)), child: Text(t.occupied? '${t.mins}m ago':'Vacant', style: const TextStyle(fontSize:9, fontWeight: FontWeight.bold)))]),
           const SizedBox(height:12),
           if(t.occupied)...[Text('Rs. ${t.amount}', style: const TextStyle(color: Color(0xFFD95A00), fontWeight: FontWeight.bold, fontSize:14)), Text('${t.kot.length} items: ${t.kot.isNotEmpty? t.kot.first.dish.name:''}...', style: const TextStyle(fontSize:11, color: Colors.grey)), Text('by ${t.waiter}', style: const TextStyle(fontSize:11, color: Colors.grey)), const Spacer(), SizedBox(width: double.infinity, child: ElevatedButton.icon(onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> TableOrderScreen(table: t))), icon: const Icon(Icons.receipt, size:14), label: const Text('View KOT', style: TextStyle(fontSize:12)), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF7A3B00), foregroundColor: Colors.white)))]
           else...[const Spacer(), const Center(child: Icon(Icons.table_restaurant, size:32, color: Colors.grey)), const SizedBox(height:6), const Center(child: Text('Empty Table', style: TextStyle(fontWeight: FontWeight.bold, fontSize:12))), const Center(child: Text('Ready for guests', style: TextStyle(fontSize:10, color: Colors.grey))), const Spacer(), SizedBox(width: double.infinity, child: ElevatedButton.icon(onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> TableOrderScreen(table: t))), icon: const Icon(Icons.add, size:14), label: const Text('Take Order', style: TextStyle(fontSize:12)), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE3EBFF), foregroundColor: Colors.black)))]
         ]))));
       }),
       const SizedBox(height:12),
       Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)), child: Row(children: [const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Icon(Icons.circle, size:10, color: Colors.green), SizedBox(width:5), Text("Today's Performance", style: TextStyle(fontSize:12, fontWeight: FontWeight.bold))]), SizedBox(height:6), Text('Bills Settled', style: TextStyle(fontSize:11, color: Colors.grey)), Text('14 Bills', style: TextStyle(fontSize:18, fontWeight: FontWeight.bold))]), const Spacer(), Column(crossAxisAlignment: CrossAxisAlignment.end, children: [TextButton(onPressed: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> const BillSplitScreen())), child: const Text('View Day Report →', style: TextStyle(fontSize:12, color: Color(0xFF7A3B00)))), const Text('Total Gross Sale', style: TextStyle(fontSize:11, color: Colors.grey)), const Text('Rs. 8,920', style: TextStyle(fontSize:18, fontWeight: FontWeight.bold, color: Color(0xFF7A3B00)))] )]))
     ])),
     bottomNavigationBar: BottomNavigationBar(currentIndex: selectedBottom, selectedItemColor: const Color(0xFF7A3B00), onTap: (i){ if(i==1) Navigator.push(context, MaterialPageRoute(builder: (_)=> const MenuManageScreen())); if(i==2) Navigator.push(context, MaterialPageRoute(builder: (_)=> const BillSplitScreen()));}, items: const [BottomNavigationBarItem(icon: Icon(Icons.table_restaurant), label: 'Tables'), BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'KOTs'), BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: 'Bills'), BottomNavigationBarItem(icon: Icon(Icons.inventory), label: 'Shift')]),
   );
 }
}

// ORDER ENTRY - LIKE PHOTO 8
class TableOrderScreen extends StatefulWidget { final TableData table; const TableOrderScreen({super.key, required this.table}); @override State<TableOrderScreen> createState()=> _TableOrderScreenState();}
class _TableOrderScreenState extends State<TableOrderScreen> {
 String cat = 'ALL ITEMS'; List<OrderLine> current = [];
 @override void initState(){ super.initState(); current = List.from(widget.table.kot);}
 int get total => current.fold(0, (s,e)=> s+e.total);
 @override Widget build(BuildContext context) {
   final filtered = cat=='ALL ITEMS'? dishes : dishes.where((d)=> d.cat.toUpperCase()==cat).toList();
   return Scaffold(
     appBar: AppBar(backgroundColor: Colors.white, title: Row(children: [Container(padding: const EdgeInsets.symmetric(horizontal:6,vertical:4), decoration: BoxDecoration(color: const Color(0xFF7A3B00), borderRadius: BorderRadius.circular(6)), child: Text('T${widget.table.no}', style: const TextStyle(color: Colors.white, fontSize:12, fontWeight: FontWeight.bold))), const SizedBox(width:8), Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('Table 0${widget.table.no}', style: const TextStyle(fontSize:14, fontWeight: FontWeight.bold)), Text('Guest: Walk-in • 4 Pax • Serve...', style: const TextStyle(fontSize:10, color: Colors.grey))])]), actions: [Column(children: [const Text('RUNNING TOTAL', style: TextStyle(fontSize:9)), Text('Rs. $total', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFD95A00)))]), const SizedBox(width:12)]),
     body: Column(children: [
       Padding(padding: const EdgeInsets.all(8), child: TextField(decoration: InputDecoration(prefixIcon: const Icon(Icons.search), hintText: 'Search menu items...', filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none)), suffixIcon: IconButton(icon: const Icon(Icons.qr_code_scanner), onPressed: (){})))),
       SingleChildScrollView(scrollDirection: Axis.horizontal, padding: const EdgeInsets.symmetric(horizontal:8), child: Row(children: ['ALL ITEMS','BIRYANI (3)','MAIN COURSE (3)','ROTI & BREAD'].map((c)=> Padding(padding: const EdgeInsets.only(right:6), child: ChoiceChip(label: Text(c, style: const TextStyle(fontSize:11)), selected: cat==c || (c.contains('BIRYANI') && cat=='BIRYANI'), onSelected: (_)=> setState(()=> cat=c.contains('BIRYANI')? 'BIRYANI': c.contains('MAIN')? 'MAIN COURSE': c.contains('ROTI')? 'ROTI': 'ALL ITEMS'), selectedColor: const Color(0xFF7A3B00), labelStyle: TextStyle(color: (cat==c || (c.contains('BIRYANI') && cat=='BIRYANI'))? Colors.white: Colors.black)))).toList())),
       Expanded(child: ListView.builder(itemCount: filtered.length, itemBuilder: (c,i){
         final d = filtered[i];
         return Container(margin: const EdgeInsets.symmetric(horizontal:8,vertical:4), padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)), child: Row(children: [
           Container(width:48,height:48, decoration: BoxDecoration(color: d.veg? Colors.green.shade50: Colors.red.shade50, borderRadius: BorderRadius.circular(8)), child: Icon(d.veg? Icons.eco: Icons.circle, color: d.veg? Colors.green: Colors.red, size:20)),
           const SizedBox(width:10),
           Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Row(children: [Container(width:8,height:8, decoration: BoxDecoration(color: d.veg? Colors.green: Colors.red, shape: BoxShape.circle)), const SizedBox(width:4), Expanded(child: Text(d.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize:13), overflow: TextOverflow.ellipsis))]), Text('${d.cat} • H: Rs.${d.half} • F: Rs.${d.full}', style: const TextStyle(fontSize:11, color: Colors.grey))]) ),
           const SizedBox(width:6),
           ElevatedButton(onPressed: ()=> setState(()=> current.add(OrderLine(d,false,1))), style: ElevatedButton.styleFrom(minimumSize: const Size(60,32), backgroundColor: Colors.white, side: const BorderSide(color: Colors.grey)), child: Text('H (${d.half})', style: const TextStyle(fontSize:11, color: Colors.black))),
           const SizedBox(width:4),
           ElevatedButton(onPressed: ()=> setState(()=> current.add(OrderLine(d,true,1))), style: ElevatedButton.styleFrom(minimumSize: const Size(65,32), backgroundColor: const Color(0xFF7A3B00), foregroundColor: Colors.white), child: Text('+ F (${d.full})', style: const TextStyle(fontSize:11)))
         ]));
       })),
       if(current.isNotEmpty) Container(color: Colors.white, padding: const EdgeInsets.all(10), child: Column(children: [
         Row(children: [Container(padding: const EdgeInsets.symmetric(horizontal:8,vertical:2), decoration: BoxDecoration(color: const Color(0xFF7A3B00), borderRadius: BorderRadius.circular(4)), child: Text('TABLE ${widget.table.no} KOT', style: const TextStyle(color: Colors.white, fontSize:10))), const SizedBox(width:6), const Text('Active Slip #04', style: TextStyle(fontSize:11)), const Spacer(), const Icon(Icons.circle, color: Colors.green, size:10), const SizedBox(width:4), const Text('Kitchen Ready', style: TextStyle(fontSize:10))]),
         const SizedBox(height:8),
        ...current.map((e)=> Row(children: [Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('${e.dish.name.substring(0,5)}...', style: const TextStyle(fontWeight: FontWeight.bold, fontSize:12)), Text('Rs. ${e.rate} each', style: const TextStyle(fontSize:10, color: Colors.grey))])), Container(padding: const EdgeInsets.symmetric(horizontal:4), decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(4)), child: Text(e.isFull? 'Full':'Half', style: const TextStyle(fontSize:9))), IconButton(onPressed: ()=> setState(()=> e.qty>1? e.qty--: current.remove(e)), icon: const Icon(Icons.remove, size:16)), Text('${e.qty}', style: const TextStyle(fontWeight: FontWeight.bold)), IconButton(onPressed: ()=> setState(()=> e.qty++), icon: const Icon(Icons.add, size:16)), SizedBox(width:70, child: Text('Rs. ${e.total}', textAlign: TextAlign.right, style: const TextStyle(fontWeight: FontWeight.bold, fontSize:12))), IconButton(onPressed: ()=> setState(()=> current.remove(e)), icon: const Icon(Icons.delete, size:16, color: Colors.grey))]) ).toList(),
         const Divider(),
         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Items Subtotal (3 types)', style: TextStyle(fontSize:11, color: Colors.grey)), Text('Rs. $total', style: const TextStyle(fontSize:11))]),
         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('GST (5% Inclusive)', style: TextStyle(fontSize:11, color: Colors.grey)), Text('Rs. ${(total*0.05).round()}', style: const TextStyle(fontSize:11))]),
         const SizedBox(height:4),
         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('Final Bill Amount', style: TextStyle(fontWeight: FontWeight.bold)), Text('Rs. $total', style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFD95A00)))]),
       ])),
       Container(padding: const EdgeInsets.all(8), color: Colors.white, child: Row(children: [
         Expanded(child: ElevatedButton.icon(onPressed: ()=> Navigator.pop(context), icon: const Icon(Icons.print, size:16), label: const Text('SAVE KOT'), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFE3EBFF)))),
         const SizedBox(width:8),
         Expanded(child: ElevatedButton.icon(onPressed: current.isEmpty? null: ()=> Navigator.push(context, MaterialPageRoute(builder: (_)=> const BillSplitScreen())), icon: const Icon(Icons.check_circle, size:16), label: const Text('PAID & CLOSE'), style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0F5D2F), foregroundColor: Colors.white))),
         const SizedBox(width:8),
         Text('Rs. $total', style: const TextStyle(fontWeight: FontWeight.bold))
       ]))
     ]),
   );
 }
}

// BILL SPLIT - EXACT LIKE PHOTO 1
class BillSplitScreen extends StatefulWidget { const BillSplitScreen({super.key}); @override State<BillSplitScreen> createState()=> _BillSplitScreenState();}
class _BillSplitScreenState extends State<BillSplitScreen> {
 int guests = 4; int collected = 420;
 @override Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(backgroundColor: Colors.white, leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: ()=> Navigator.pop(context)), title: Row(children: [Container(padding: const EdgeInsets.symmetric(horizontal:8,vertical:4), decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(6)), child: const Text('T-03', style: TextStyle(fontWeight: FontWeight.bold))), const SizedBox(width:8), const Column
