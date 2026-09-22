import 'package:flutter/material.dart';
void main()=>runApp(const KGNApp());

class Item{String name;double price;String cat;String emoji;Item(this.name,this.price,this.cat,this.emoji);}
class CartItem{Item item;int qty;CartItem(this.item,this.qty);}
class Order{String id;String table;List<CartItem> items;String type;String status;DateTime time;Order(this.id,this.table,this.items,this.type,this.status,this.time);}

class KGNApp extends StatelessWidget{
  const KGNApp({super.key});
  @override Widget build(BuildContext context){
    return MaterialApp(debugShowCheckedModeBanner:false,title:'KGN TAWA FRY',theme:ThemeData(useMaterial3:true,colorScheme:ColorScheme.fromSeed(seedColor:Colors.blue)),home:const HomePage());
  }
}

class HomePage extends StatefulWidget{const HomePage({super.key});@override State<HomePage> createState()=>_HomePageState();}

class _HomePageState extends State<HomePage>{
int idx=0;
List<Item> menu=[Item("Chicken Biryani Half",80,"CHICKEN","🍚"),Item("Chicken Masala Half",120,"CHICKEN","🍛"),Item("Butter Chicken Half",170,"CHICKEN","🍗"),Item("Kheema Half",130,"MUTTON","🥘"),Item("Fish Fry Full",160,"FISH","🐟"),Item("Zinga Rice Half",170,"PRAWNS","🍤"),Item("Chapati Roti",7,"ROTI","🫓"),Item("Plain Rice",30,"RICE","🍚"),Item("Dal Fry Full",100,"DAL","🍲"),];
List<String> tables=List.generate(12,(i)=>"T-${i+1}");
Map<String,String> tableStatus={};
List<Order> orders=[];
List<CartItem> cart=[];
String selectedTable="T-1";
double todaySale=49;int todayOrders=1;

@override Widget build(BuildContext context){
 return Scaffold(
  backgroundColor:const Color(0xFFF5F6FA),
  body:getBody(),
  bottomNavigationBar:NavigationBar(
    selectedIndex:idx,
    onDestinationSelected:(i){setState(()=>idx=i);},
    destinations:const[
      NavigationDestination(icon:Icon(Icons.home_outlined),selectedIcon:Icon(Icons.home),label:"Home"),
      NavigationDestination(icon:Icon(Icons.table_restaurant_outlined),selectedIcon:Icon(Icons.table_restaurant),label:"Tables"),
      NavigationDestination(icon:Icon(Icons.receipt_long_outlined),selectedIcon:Icon(Icons.receipt_long),label:"Orders"),
      NavigationDestination(icon:Icon(Icons.restaurant_menu),selectedIcon:Icon(Icons.restaurant_menu),label:"Menu"),
      NavigationDestination(icon:Icon(Icons.more_horiz),label:"More"),
    ]),
  floatingActionButton:FloatingActionButton(onPressed:(){setState(()=>idx=1);},backgroundColor:Colors.blue,child:const Icon(Icons.add,color:Colors.white)),
 );
}

Widget getBody(){
 if(idx==0) return buildHome();
 if(idx==1) return buildTables();
 if(idx==2) return buildOrders();
 if(idx==3) return buildMenu();
 return buildMore();
}

Widget buildHome(){
 return SafeArea(child:SingleChildScrollView(padding:const EdgeInsets.all(16),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[
  const Text("KGN TAWA FRY",style:TextStyle(fontWeight:FontWeight.bold,fontSize:18)),
  const SizedBox(height:20),
  Row(mainAxisAlignment:MainAxisAlignment.spaceAround,children:[
    qItem(Icons.check_circle,"Closed","${orders.where((o)=>o.status=='closed').length}",(){setState(()=>idx=2);}),
    qItem(Icons.access_time,"On Hold","${orders.where((o)=>o.status=='hold').length}",(){setState(()=>idx=2);}),
    qItem(Icons.restaurant_menu,"Items","${menu.length}",(){setState(()=>idx=3);}),
  ]),
  const SizedBox(height:20),
  Container(padding:const EdgeInsets.all(16),decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(12)),child:Column(children:[
    Row(children:[
      Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Text("Today's sales",style:TextStyle(fontSize:12,color:Colors.grey)),Text("Rs $todaySale",style:const TextStyle(fontWeight:FontWeight.bold,fontSize:20,color:Colors.red))])),
      Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Text("Today's orders",style:TextStyle(fontSize:12,color:Colors.grey)),Text("$todayOrders",style:const TextStyle(fontWeight:FontWeight.bold,fontSize:20))])),
    ]),
    const SizedBox(height:10),
    InkWell(onTap:(){setState(()=>idx=2);},child:const Row(children:[Text("Top selling items & more insights!",style:TextStyle(color:Colors.blue,fontSize:12)),Spacer(),Icon(Icons.arrow_forward_ios,size:12,color:Colors.blue)])),
  ])),
 ])));
}

Widget qItem(IconData ic,String t,String c,VoidCallback tap){
 return InkWell(
  onTap:tap,
  borderRadius:BorderRadius.circular(20),
  child:Padding(padding:const EdgeInsets.all(8),child:Column(children:[
    Container(padding:const EdgeInsets.all(12),decoration:const BoxDecoration(color:Colors.blue,shape:BoxShape.circle),child:Icon(ic,color:Colors.white,size:20)),
    const SizedBox(height:5),
    Text(t,style:const TextStyle(fontSize:11)),
    Text(c,style:const TextStyle(fontSize:10,color:Colors.grey))
  ])));
}

Widget buildTables(){return SafeArea(child:Column(children:[const Padding(padding:EdgeInsets.all(16),child:Text("Table Management - Table pe Click Karo",style:TextStyle(fontWeight:FontWeight.bold,fontSize:16))),Expanded(child:GridView.builder(padding:const EdgeInsets.all(12),gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3,childAspectRatio:1.1,crossAxisSpacing:10,mainAxisSpacing:10),itemCount:tables.length,itemBuilder:(_,i){String t=tables[i];String st=tableStatus[t]??"empty";Color col=st=="empty"?Colors.green:Colors.orange;return InkWell(onTap:(){selectedTable=t;showBilling();},child:Container(decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(12),border:Border.all(color:col,width:2)),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(Icons.table_restaurant,color:col),const SizedBox(height:5),Text(t,style:TextStyle(fontWeight:FontWeight.bold,color:col)),Text(st.toUpperCase(),style:TextStyle(fontSize:9,color:col))])));})),]));}
Widget buildOrders(){if(orders.isEmpty){return const SafeArea(child:Center(child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(Icons.receipt_long,size:50,color:Colors.grey),SizedBox(height:10),Text("No Orders - Abhi Orders yahan ayenge")]))) ;}return SafeArea(child:ListView.builder(padding:const EdgeInsets.all(10),itemCount:orders.length,itemBuilder:(_,i){var o=orders[i];double tot=0;for(var e in o.items){tot+=e.item.price*e.qty;}return Card(child:ListTile(title:Text("${o.table} - ${o.type}"),subtitle:Text("Rs $tot - ${o.status}")));}));}
Widget buildMenu(){return SafeArea(child:ListView.builder(itemCount:menu.length,itemBuilder:(_,i){var m=menu[i];return Card(margin:const EdgeInsets.symmetric(horizontal:10,vertical:4),child:ListTile(leading:Text(m.emoji,style:const TextStyle(fontSize:24)),title:Text(m.name,style:const TextStyle(fontSize:13,fontWeight:FontWeight.bold)),subtitle:Text("Rs ${m.price}")));}));}
Widget buildMore(){return const SafeArea(child:Center(child:Text("More - Settings & Printer")));}

void showBilling(){cart=[];showModalBottomSheet(context:context,isScrollControlled:true,backgroundColor:Colors.white,shape:const RoundedRectangleBorder(borderRadius:BorderRadius.vertical(top:Radius.circular(16))),builder:(ctx){return StatefulBuilder(builder:(ctx,setM){double total=0;for(var e in cart){total+=e.item.price*e.qty;}return SizedBox(height:MediaQuery.of(context).size.height*0.9,child:Column(children:[Padding(padding:const EdgeInsets.all(16),child:Row(children:[Text("Order - $selectedTable",style:const TextStyle(fontWeight:FontWeight.bold)),const Spacer(),IconButton(onPressed:()=>Navigator.pop(ctx),icon:const Icon(Icons.close))])),Expanded(child:GridView.builder(padding:const EdgeInsets.all(10),gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3,childAspectRatio:0.75,crossAxisSpacing:8,mainAxisSpacing:8),itemCount:menu.length,itemBuilder:(_,i){var m=menu[i];int qty=0;for(var c in cart){if(c.item.name==m.name) qty=c.qty;}return Container(decoration:BoxDecoration(border:Border.all(color:Colors.grey.shade300),borderRadius:BorderRadius.circular(10)),child:Column(children:[Expanded(child:Center(child:Text(m.emoji,style:const TextStyle(fontSize:32)))),Padding(padding:const EdgeInsets.all(6),child:Column(children:[Text(m.name,maxLines:2,overflow:TextOverflow.ellipsis,style:const TextStyle(fontSize:10,fontWeight:FontWeight.bold),textAlign:TextAlign.center),Text("Rs ${m.price}",style:const TextStyle(fontSize:10,color:Colors.grey)),const SizedBox(height:4),qty==0?InkWell(onTap:(){setM(()=>cart.add(CartItem(m,1)));setState((){});},child:Container(padding:const EdgeInsets.symmetric(horizontal:12,vertical:3),decoration:BoxDecoration(border:Border.all(color:Colors.blue),borderRadius:BorderRadius.circular(5)),child:const Text("+ Add",style:TextStyle(color:Colors.blue,fontSize:10)))):Container(decoration:BoxDecoration(color:Colors.blue,borderRadius:BorderRadius.circular(5)),child:Row(mainAxisAlignment:MainAxisAlignment.spaceAround,children:[InkWell(onTap:(){setM((){var it=cart.firstWhere((c)=>c.item.name==m.name);it.qty--;if(it.qty<=0) cart.remove(it);});setState((){});},child:const Padding(padding:EdgeInsets.all(4),child:Icon(Icons.remove,size:14,color:Colors.white))),Text("$qty",style:const TextStyle(color:Colors.white,fontSize:11)),InkWell(onTap:(){setM(()=>cart.firstWhere((c)=>c.item.name==m.name).qty++);setState((){});},child:const Padding(padding:EdgeInsets.all(4),child:Icon(Icons.add,size:14,color:Colors.white))),]))])));})),if(cart.isNotEmpty)Container(padding:const EdgeInsets.all(12),child:Row(children:[Text("Rs $total",style:const TextStyle(fontWeight:FontWeight.bold)),const Spacer(),ElevatedButton(onPressed:(){var o=Order(DateTime.now().millisecondsSinceEpoch.toString(),selectedTable,List.from(cart),"Dine-in","closed",DateTime.now());setState(()=>orders.add(o));setState(()=>todaySale+=total);Navigator.pop(ctx);cart.clear();},child:const Text("Bill"))]))]));});});}
import 'package:flutter/material.dart';
void main()=>runApp(const KGNApp());
class Item{String name;double price;String cat;String emoji;Item(this.name,this.price,this.cat,this.emoji);}
class CartItem{Item item;int qty;CartItem(this.item,this.qty);}
class Order{String id;String table;List<CartItem> items;String type;String status;DateTime time;Order(this.id,this.table,this.items,this.type,this.status,this.time);}
class KGNApp extends StatelessWidget{const KGNApp({super.key});@override Widget build(BuildContext context){return MaterialApp(debugShowCheckedModeBanner:false,title:'KGN TAWA FRY',theme:ThemeData(useMaterial3:true,colorScheme:ColorScheme.fromSeed(seedColor:Colors.blue)),home:const HomePage());}}
class HomePage extends StatefulWidget{const HomePage({super.key});@override State<HomePage> createState()=>_HomePageState();}
class _HomePageState extends State<HomePage>{
int idx=0;List<Item> menu=[Item("Chicken Biryani Half",80,"CHICKEN","🍚"),Item("Chicken Masala Half",120,"CHICKEN","🍛"),Item("Butter Chicken Half",170,"CHICKEN","🍗"),Item("Kheema Half",130,"MUTTON","🥘"),Item("Fish Fry Full",160,"FISH","🐟"),Item("Zinga Rice Half",170,"PRAWNS","🍤"),Item("Chapati Roti",7,"ROTI","🫓"),Item("Plain Rice",30,"RICE","🍚"),Item("Dal Fry Full",100,"DAL","🍲"),];List<String> tables=List.generate(12,(i)=>"T-${i+1}");Map<String,String> tableStatus={};List<Order> orders=[];List<CartItem> cart=[];String selectedTable="T-1";double todaySale=49;int todayOrders=1;
@override Widget build(BuildContext context){return Scaffold(backgroundColor:const Color(0xFFF5F6FA),body:getBody(),bottomNavigationBar:NavigationBar(selectedIndex:idx,onDestinationSelected:(i){setState(()=>idx=i);},destinations:const[NavigationDestination(icon:Icon(Icons.home_outlined),selectedIcon:Icon(Icons.home),label:"Home"),NavigationDestination(icon:Icon(Icons.table_restaurant_outlined),selectedIcon:Icon(Icons.table_restaurant),label:"Tables"),NavigationDestination(icon:Icon(Icons.receipt_long_outlined),selectedIcon:Icon(Icons.receipt_long),label:"Orders"),NavigationDestination(icon:Icon(Icons.restaurant_menu),selectedIcon:Icon(Icons.restaurant_menu),label:"Menu"),NavigationDestination(icon:Icon(Icons.more_horiz),label:"More"),]),floatingActionButton:FloatingActionButton(onPressed:(){setState(()=>idx=1);},backgroundColor:Colors.blue,child:const Icon(Icons.add,color:Colors.white)),);}
Widget getBody(){if(idx==0) return buildHome();if(idx==1) return buildTables();if(idx==2) return buildOrders();if(idx==3) return buildMenu();return buildMore();}
Widget buildHome(){return SafeArea(child:SingleChildScrollView(padding:const EdgeInsets.all(16),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Text("KGN TAWA FRY",style:TextStyle(fontWeight:FontWeight.bold,fontSize:18)),const SizedBox(height:20),Row(mainAxisAlignment:MainAxisAlignment.spaceAround,children:[qItem(Icons.check_circle,"Closed","${orders.where((o)=>o.status=='closed').length}",(){setState(()=>idx=2);}),qItem(Icons.access_time,"On Hold","${orders.where((o)=>o.status=='hold').length}",(){setState(()=>idx=2);}),qItem(Icons.restaurant_menu,"Items","${menu.length}",(){setState(()=>idx=3);}),]),const SizedBox(height:20),Container(padding:const EdgeInsets.all(16),decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(12)),child:Column(children:[Row(children:[Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Text("Today's sales",style:TextStyle(fontSize:12,color:Colors.grey)),Text("Rs $todaySale",style:const TextStyle(fontWeight:FontWeight.bold,fontSize:20,color:Colors.red))])),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Text("Today's orders",style:TextStyle(fontSize:12,color:Colors.grey)),Text("$todayOrders",style:const TextStyle(fontWeight:FontWeight.bold,fontSize:20))])),]),const SizedBox(height:10),InkWell(onTap:(){setState(()=>idx=2);},child:const Row(children:[Text("Top selling items & more insights!",style:TextStyle(color:Colors.blue,fontSize:12)),Spacer(),Icon(Icons.arrow_forward_ios,size:12,color:Colors.blue)])),])),])));}
Widget qItem(IconData ic,String t,String c,VoidCallback tap){return InkWell(onTap:tap,borderRadius:BorderRadius.circular(20),child:Padding(padding:const EdgeInsets.all(8),child:Column(children:[Container(padding:const EdgeInsets.all(12),decoration:const BoxDecoration(color:Colors.blue,shape:BoxShape.circle),child:Icon(ic,color:Colors.white,size:20)),const SizedBox(height:5),Text(t,style:const TextStyle(fontSize:11)),Text(c,style:const TextStyle(fontSize:10,color:Colors.grey))])));}
Widget buildTables(){return SafeArea(child:Column(children:[const Padding(padding:EdgeInsets.all(16),child:Text("Table Management - Table pe Click Karo",style:TextStyle(fontWeight:FontWeight.bold,fontSize:16))),Expanded(child:GridView.builder(padding:const EdgeInsets.all(12),gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3,childAspectRatio:1.1,crossAxisSpacing:10,mainAxisSpacing:10),itemCount:tables.length,itemBuilder:(_,i){String t=tables[i];String st=tableStatus[t]??"empty";Color col=st=="empty"?Colors.green:Colors.orange;return InkWell(onTap:(){selectedTable=t;showBilling();},child:Container(decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(12),border:Border.all(color:col,width:2)),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(Icons.table_restaurant,color:col),const SizedBox(height:5),Text(t,style:TextStyle(fontWeight:FontWeight.bold,color:col)),Text(st.toUpperCase(),style:TextStyle(fontSize:9,color:col))])));})),]));}
Widget buildOrders(){if(orders.isEmpty){return const SafeArea(child:Center(child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(Icons.receipt_long,size:50,color:Colors.grey),SizedBox(height:10),Text("No Orders")]))) ;}return SafeArea(child:ListView.builder(padding:const EdgeInsets.all(10),itemCount:orders.length,itemBuilder:(_,i){var o=orders[i];double tot=0;for(var e in o.items){tot+=e.item.price*e.qty;}return Card(child:ListTile(title:Text("${o.table} - ${o.type}"),subtitle:Text("Rs $tot - ${o.status}")));}));}
Widget buildMenu(){return SafeArea(child:ListView.builder(itemCount:menu.length,itemBuilder:(_,i){var m=menu[i];return Card(margin:const EdgeInsets.symmetric(horizontal:10,vertical:4),child:ListTile(leading:Text(m.emoji,style:const TextStyle(fontSize:24)),title:Text(m.name,style:const TextStyle(fontSize:13,fontWeight:FontWeight.bold)),subtitle:Text("Rs ${m.price}")));}));}
Widget buildMore(){return const SafeArea(child:Center(child:Text("More - Settings & Printer")));}
void showBilling(){cart=[];showModalBottomSheet(context:context,isScrollControlled:true,backgroundColor:Colors.white,shape:const RoundedRectangleBorder(borderRadius:BorderRadius.vertical(top:Radius.circular(16))),builder:(ctx){return StatefulBuilder(builder:(ctx,setM){double total=0;for(var e in cart){total+=e.item.price*e.qty;}return SizedBox(height:MediaQuery.of(context).size.height*0.9,child:Column(children:[Padding(padding:const EdgeInsets.all(16),child:Row(children:[Text("Order - $selectedTable",style:const TextStyle(fontWeight:FontWeight.bold)),const Spacer(),IconButton(onPressed:()=>Navigator.pop(ctx),icon:const Icon(Icons.close))])),Expanded(child:GridView.builder(padding:const EdgeInsets.all(10),gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3,childAspectRatio:0.75,crossAxisSpacing:8,mainAxisSpacing:8),itemCount:menu.length,itemBuilder:(_,i){var m=menu[i];int qty=0;for(var c in cart){if(c.item.name==m.name) qty=c.qty;}return Container(decoration:BoxDecoration(border:Border.all(color:Colors.grey.shade300),borderRadius:BorderRadius.circular(10)),child:Column(children:[Expanded(child:Center(child:Text(m.emoji,style:const TextStyle(fontSize:32)))),Padding(padding:const EdgeInsets.all(6),child:Column(children:[Text(m.name,maxLines:2,overflow:TextOverflow.ellipsis,style:const TextStyle(fontSize:10,fontWeight:FontWeight.bold),textAlign:TextAlign.center),Text("Rs ${m.price}",style:const TextStyle(fontSize:10,color:Colors.grey)),const SizedBox(height:4),qty==0?InkWell(onTap:(){setM(()=>cart.add(CartItem(m,1)));setState((){});},child:Container(padding:const EdgeInsets.symmetric(horizontal:12,vertical:3),decoration:BoxDecoration(border:Border.all(color:Colors.blue),borderRadius:BorderRadius.circular(5)),child:const Text("+ Add",style:TextStyle(color:Colors.blue,fontSize:10)))):Container(decoration:BoxDecoration(color:Colors.blue,borderRadius:BorderRadius.circular(5)),child:Row(mainAxisAlignment:MainAxisAlignment.spaceAround,children:[InkWell(onTap:(){setM((){var it=cart.firstWhere((c)=>c.item.name==m.name);it.qty--;if(it.qty<=0) cart.remove(it);});setState((){});},child:const Padding(padding:EdgeInsets.all(4),child:Icon(Icons.remove,size:14,color:Colors.white))),Text("$qty",style:const TextStyle(color:Colors.white,fontSize:11)),InkWell(onTap:(){setM(()=>cart.firstWhere((c)=>c.item.name==m.name).qty++);setState((){});},child:const Padding(padding:EdgeInsets.all(4),child:Icon(Icons.add,size:14,color:Colors.white))),]))])));})),if(cart.isNotEmpty)Container(padding:const EdgeInsets.all(12),child:Row(children:[Text("Rs $total",style:const TextStyle(fontWeight:FontWeight.bold)),const Spacer(),ElevatedButton(onPressed:(){var o=Order(DateTime.now().millisecondsSinceEpoch.toString(),selectedTable,List.from(cart),"Dine-in","closed",DateTime.now());setState(()=>orders.add(o));setState(()=>todaySale+=total);Navigator.pop(ctx);cart.clear();},child:const Text("Bill"))]))]));});});}
                                                                                                                                                                                                                                                                                                                                                                                                                               }                                                                                                                                                                                                                                                                                                                                                                                                                               }
