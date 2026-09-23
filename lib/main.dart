import 'package:flutter/material.dart';
void main()=>runApp(const MaterialApp(debugShowCheckedModeBanner:false,home:KGNApp()));
class KGNApp extends StatefulWidget{const KGNApp({super.key});@override State<KGNApp> createState()=>_KGNAppState();}
class _KGNAppState extends State<KGNApp>{
int nav=0;String orderType="Dine-in";String selTable="T-1";
List<String> tables=List.generate(20,(i)=>"T-${i+1}");
List<Map<String,dynamic>> cart=[];List<Map<String,dynamic>> orders=[];

List<Map<String,dynamic>> menu=[
{"name":"Anda Kadhi","price":80,"full":160,"cat":"ANDA","emoji":"🥚"},
{"name":"Anda Kheema","price":80,"full":160,"cat":"ANDA","emoji":"🥚"},
{"name":"Anda Bhurji","price":50,"full":100,"cat":"ANDA","emoji":"🥚"},
{"name":"Anda Pulav","price":60,"full":120,"cat":"ANDA","emoji":"🥚"},
{"name":"Dal Tadka","price":70,"full":140,"cat":"VEG","emoji":"🍲"},
{"name":"Dal Gotala","price":80,"full":160,"cat":"VEG","emoji":"🍲"},
{"name":"Butter Dal Fry","price":70,"full":140,"cat":"VEG","emoji":"🍲"},
{"name":"Dal Fry","price":50,"full":100,"cat":"VEG","emoji":"🍲"},
{"name":"Sabji Fry","price":50,"full":100,"cat":"VEG","emoji":"🥗"},
{"name":"Sev Tameta","price":50,"full":100,"cat":"VEG","emoji":"🍅"},
{"name":"Masala Rice","price":50,"full":100,"cat":"RICE","emoji":"🍚"},
{"name":"Biryani Rice","price":50,"full":100,"cat":"RICE","emoji":"🍚"},
{"name":"Jeera Rice","price":50,"full":100,"cat":"RICE","emoji":"🍚"},
{"name":"Kadhi Khichdi","price":30,"full":60,"cat":"RICE","emoji":"🍛"},
{"name":"Dal Pulav","price":50,"full":100,"cat":"RICE","emoji":"🍚"},
{"name":"Plain Rice","price":30,"full":60,"cat":"RICE","emoji":"🍚"},
{"name":"Special Roti","price":15,"full":15,"cat":"ROTI","emoji":"🫓"},
{"name":"Special Paratha","price":20,"full":20,"cat":"ROTI","emoji":"🫓"},
{"name":"Butter Roti","price":15,"full":15,"cat":"ROTI","emoji":"🫓"},
{"name":"Chapati Roti","price":7,"full":7,"cat":"ROTI","emoji":"🫓"},
{"name":"Papad Fry","price":10,"full":10,"cat":"ROTI","emoji":"🫓"},
{"name":"Murga Do Pyaza","price":170,"full":320,"cat":"CHICKEN","emoji":"🍗"},
{"name":"Murga Mogalai","price":160,"full":300,"cat":"CHICKEN","emoji":"🍗"},
{"name":"Chicken Handi","price":170,"full":320,"cat":"CHICKEN","emoji":"🍗"},
{"name":"Chicken Peshawari","price":170,"full":320,"cat":"CHICKEN","emoji":"🍗"},
{"name":"Murga Shahi Chicken","price":170,"full":320,"cat":"CHICKEN","emoji":"🍗"},
{"name":"Chicken Malai Tikka","price":170,"full":320,"cat":"CHICKEN","emoji":"🍗"},
{"name":"Chicken Tikka Masala","price":160,"full":300,"cat":"CHICKEN","emoji":"🍗"},
{"name":"Chicken Kadhai","price":160,"full":300,"cat":"CHICKEN","emoji":"🍗"},
{"name":"Chicken Garlic","price":250,"full":450,"cat":"CHICKEN","emoji":"🍗"},
{"name":"Chicken India","price":170,"full":320,"cat":"CHICKEN","emoji":"🍗"},
{"name":"Butter Chicken Boneless","price":180,"full":350,"cat":"CHICKEN","emoji":"🍗"},
{"name":"White Chicken","price":180,"full":350,"cat":"CHICKEN","emoji":"🍗"},
{"name":"Green Chicken","price":120,"full":220,"cat":"CHICKEN","emoji":"🍗"},
{"name":"Chicken Fry","price":120,"full":220,"cat":"CHICKEN","emoji":"🍗"},
{"name":"Chicken Masala","price":80,"full":120,"cat":"CHICKEN","emoji":"🍗"},
{"name":"Chicken Biryani","price":250,"full":480,"cat":"CHICKEN","emoji":"🍗"},
{"name":"Chicken Tandoori Masala","price":160,"full":300,"cat":"CHICKEN","emoji":"🍗"},
{"name":"Chicken Amdavadi Masala","price":160,"full":300,"cat":"CHICKEN","emoji":"🍗"},
{"name":"Chicken Tikka Rice","price":170,"full":320,"cat":"CHICKEN","emoji":"🍗"},
{"name":"Mogalai Mutton","price":150,"full":280,"cat":"MUTTON","emoji":"🍖"},
{"name":"Dal Bati Gos","price":150,"full":280,"cat":"MUTTON","emoji":"🍖"},
{"name":"White Mutton","price":160,"full":300,"cat":"MUTTON","emoji":"🍖"},
{"name":"Green Mutton","price":150,"full":280,"cat":"MUTTON","emoji":"🍖"},
{"name":"Mutton Kurma","price":160,"full":300,"cat":"MUTTON","emoji":"🍖"},
{"name":"Mutton Fry","price":120,"full":220,"cat":"MUTTON","emoji":"🍖"},
{"name":"Mutton Masala","price":120,"full":220,"cat":"MUTTON","emoji":"🍖"},
{"name":"Kaleji Masala","price":120,"full":220,"cat":"MUTTON","emoji":"🍖"},
{"name":"Bhaji Gos","price":130,"full":240,"cat":"MUTTON","emoji":"🍖"},
{"name":"Paya Fry","price":120,"full":220,"cat":"MUTTON","emoji":"🍖"},
{"name":"Champ Fry","price":120,"full":220,"cat":"MUTTON","emoji":"🍖"},
{"name":"Bheja Fry","price":130,"full":240,"cat":"MUTTON","emoji":"🧠"},
{"name":"Boti Masala","price":120,"full":220,"cat":"MUTTON","emoji":"🍖"},
{"name":"Kheema Fry","price":80,"full":160,"cat":"MUTTON","emoji":"🥘"},
{"name":"Kheema Pulav","price":100,"full":180,"cat":"MUTTON","emoji":"🍚"},
{"name":"Machhi Fry","price":80,"full":160,"cat":"FISH","emoji":"🐟"},
{"name":"Machhi Kadhi","price":100,"full":200,"cat":"FISH","emoji":"🐟"},
{"name":"Jinga Fry","price":130,"full":240,"cat":"PRAWNS","emoji":"🍤"},
{"name":"Jinga Rice","price":170,"full":320,"cat":"PRAWNS","emoji":"🍤"},
];

@override Widget build(BuildContext context){return Scaffold(backgroundColor:const Color(0xFFF5F6FA),body:getBody(),bottomNavigationBar:NavigationBar(selectedIndex:nav,onDestinationSelected:(i)=>setState(()=>nav=i),destinations:const[NavigationDestination(icon:Icon(Icons.home),label:"Home"),NavigationDestination(icon:Icon(Icons.table_bar),label:"Tables"),NavigationDestination(icon:Icon(Icons.receipt),label:"Orders"),NavigationDestination(icon:Icon(Icons.menu_book),label:"Menu"),NavigationDestination(icon:Icon(Icons.more_horiz),label:"More")]),floatingActionButton: nav==3? FloatingActionButton.extended(backgroundColor:Colors.green,onPressed: ()=>addNewItemDialog(),icon:const Icon(Icons.add,color:Colors.white),label:const Text("Add Item",style:TextStyle(color:Colors.white))) : FloatingActionButton.extended(backgroundColor:Colors.blue,onPressed: ()=>setState(()=>nav=1),icon:const Icon(Icons.add,color:Colors.white),label:Text("${menu.length} Items",style:const TextStyle(color:Colors.white))));}
Widget getBody(){if(nav==0) return homePage();if(nav==1) return tablePage();if(nav==2) return ordersPage();if(nav==3) return menuPage();return morePage();}
Widget topBtn(IconData ic,String t,String c,VoidCallback tap)=>InkWell(onTap:tap,child:Column(children:[CircleAvatar(radius:22,backgroundColor:Colors.blue,child:Icon(ic,color:Colors.white,size:18)),const SizedBox(height:4),Text(t,style:const TextStyle(fontSize:11,fontWeight:FontWeight.bold)),Text(c,style:const TextStyle(fontSize:10,color:Colors.grey))]));
Widget homePage(){double sale=0;for(var o in orders) sale+=o['total'];return SafeArea(child:SingleChildScrollView(padding:const EdgeInsets.all(16),child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[Text("KGN TAWA FRY - ${menu.length} ITEMS",style:const TextStyle(fontWeight:FontWeight.bold,fontSize:20)),const Text("Add/Edit Feature ON ✅",style:TextStyle(fontSize:11,color:Colors.green,fontWeight:FontWeight.bold)),const SizedBox(height:16),Row(mainAxisAlignment:MainAxisAlignment.spaceAround,children:[topBtn(Icons.check_circle,"Closed","${orders.length}",()=>setState(()=>nav=2)),topBtn(Icons.edit,"Edit","Price",()=>setState(()=>nav=3)),topBtn(Icons.fastfood,"Items","${menu.length}",()=>setState(()=>nav=3)),topBtn(Icons.table_bar,"Tables","${tables.length}",()=>setState(()=>nav=1))]),const SizedBox(height:16),Container(padding:const EdgeInsets.all(16),decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(12)),child:Row(children:[Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Text("Today's sales",style:TextStyle(fontSize:11,color:Colors.grey)),Text("Rs $sale",style:const TextStyle(fontWeight:FontWeight.bold,fontSize:20,color:Colors.red))])),Expanded(child:Column(crossAxisAlignment:CrossAxisAlignment.start,children:[const Text("Today's orders",style:TextStyle(fontSize:11,color:Colors.grey)),Text("${orders.length}",style:const TextStyle(fontWeight:FontWeight.bold,fontSize:20))]))]))] )));}
Widget tablePage()=>SafeArea(child:Column(children:[const Padding(padding:EdgeInsets.all(16),child:Text("Tables - Click to Order",style:TextStyle(fontWeight:FontWeight.bold))),Expanded(child:GridView.builder(padding:const EdgeInsets.all(12),gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3,childAspectRatio:1,crossAxisSpacing:10,mainAxisSpacing:10),itemCount:tables.length,itemBuilder:(c,i){String t=tables[i];return InkWell(onTap:(){selTable=t;cart=[];openBill();},child:Container(decoration:BoxDecoration(color:Colors.white,borderRadius:BorderRadius.circular(12),border:Border.all(color:Colors.green,width:2)),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[const Icon(Icons.table_restaurant,color:Colors.green),Text(t,style:const TextStyle(fontWeight:FontWeight.bold,color:Colors.green)),const Text("EMPTY",style:TextStyle(fontSize:9,color:Colors.green))])));}))]));
Widget ordersPage(){if(orders.isEmpty) return const SafeArea(child:Center(child:Text("No Orders")));return SafeArea(child:ListView.builder(itemCount:orders.length,itemBuilder:(c,i){var o=orders[i];return Card(child:ListTile(title:Text("${o['table']} - ${o['type']}"),subtitle:Text("Rs ${o['total']}"),trailing:Text(o['payMode']))); }));}
Widget menuPage(){return SafeArea(child:Column(children:[Padding(padding:const EdgeInsets.all(8),child:Column(children:[Text("Full Menu - ${menu.length} Items",style:const TextStyle(fontWeight:FontWeight.bold,fontSize:13)),const Text("Long Press = Edit Price | + Button = New Item Add",style:TextStyle(fontSize:10,color:Colors.blue))])),Expanded(child:ListView.builder(itemCount:menu.length,itemBuilder:(c,i){var m=menu[i];return Card(margin:const EdgeInsets.symmetric(horizontal:8,vertical:2),child:ListTile(dense:true,leading:Text(m['emoji'],style:const TextStyle(fontSize:20)),title:Text(m['name'],style:const TextStyle(fontSize:11,fontWeight:FontWeight.bold)),subtitle:Text("${m['cat']} | H:${m['price']} F:${m['full']}",style:const TextStyle(fontSize:9)),trailing:Row(mainAxisSize:MainAxisSize.min,children:[IconButton(icon:const Icon(Icons.edit,size:16,color:Colors.orange), onPressed:()=>editPriceDialog(i)),IconButton(icon:const Icon(Icons.delete,size:16,color:Colors.red), onPressed:()=>deleteItem(i)),Container(padding:const EdgeInsets.symmetric(horizontal:6,vertical:3),decoration:BoxDecoration(color:Colors.blue,borderRadius:BorderRadius.circular(4)),child:const Text("+",style:TextStyle(color:Colors.white,fontSize:10))) ]),onLongPress: ()=>editPriceDialog(i)));}))]));}
Widget morePage()=>SafeArea(child:ListView(padding:const EdgeInsets.all(16),children:[Text("KGN - ${menu.length} Items | Edit/Add ON",style:const TextStyle(fontWeight:FontWeight.bold)),const SizedBox(height:10),ElevatedButton.icon(onPressed: ()=>addNewItemDialog(), icon:const Icon(Icons.add), label:const Text("Add New Starter / Item")),const SizedBox(height:10),const Text("Features:\n✅ Long Press = Edit Price (+/-)\n✅ Add Button = New Item\n✅ Delete Button = Remove Item\n✅ Jeera Rice 50/100")]));

// EDIT PRICE
void editPriceDialog(int index){
int halfPrice = menu[index]['price']; int fullPrice = menu[index]['full'];
TextEditingController halfCtrl = TextEditingController(text: halfPrice.toString());
TextEditingController fullCtrl = TextEditingController(text: fullPrice.toString());
showDialog(context: context, builder: (ctx){return StatefulBuilder(builder: (ctx,setD){return AlertDialog(title: Text("Edit - ${menu[index]['name']}",style:const TextStyle(fontSize:13)),content: Column(mainAxisSize: MainAxisSize.min, children: [Row(children: [const Text("Half: "),IconButton(onPressed: (){if(halfPrice>0){setD(()=>halfPrice--); halfCtrl.text=halfPrice.toString();}}, icon:const Icon(Icons.remove_circle,size:20)),Expanded(child: TextField(controller: halfCtrl, keyboardType: TextInputType.number, textAlign: TextAlign.center, onChanged: (v)=>halfPrice=int.tryParse(v)??halfPrice, decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true))),IconButton(onPressed: (){setD(()=>halfPrice++); halfCtrl.text=halfPrice.toString();}, icon:const Icon(Icons.add_circle,size:20,color:Colors.blue)),]),const SizedBox(height: 10),Row(children: [const Text("Full: "),IconButton(onPressed: (){if(fullPrice>0){setD(()=>fullPrice--); fullCtrl.text=fullPrice.toString();}}, icon:const Icon(Icons.remove_circle,size:20)),Expanded(child: TextField(controller: fullCtrl, keyboardType: TextInputType.number, textAlign: TextAlign.center, onChanged: (v)=>fullPrice=int.tryParse(v)??fullPrice, decoration: const InputDecoration(border: OutlineInputBorder(), isDense: true))),IconButton(onPressed: (){setD(()=>fullPrice++); fullCtrl.text=fullPrice.toString();}, icon:const Icon(Icons.add_circle,size:20,color:Colors.blue)),])]),actions: [TextButton(onPressed: ()=>Navigator.pop(ctx), child: const Text("Cancel")),ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green),onPressed: (){setState((){menu[index]['price']=halfPrice; menu[index]['full']=fullPrice;});Navigator.pop(ctx);ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Updated: H:$halfPrice F:$fullPrice"), backgroundColor: Colors.green));},child: const Text("SAVE",style: TextStyle(color: Colors.white)))],);});});}

// ADD NEW ITEM - STARTER JAISA KUCH BHI
void addNewItemDialog(){
TextEditingController nameCtrl = TextEditingController();
TextEditingController halfCtrl = TextEditingController(text: "100");
TextEditingController fullCtrl = TextEditingController(text: "200");
String selCat="STARTER"; String selEmoji="🍢";
List<String> cats=["STARTER","CHICKEN","MUTTON","VEG","RICE","ROTI","FISH","PRAWNS","ANDA","CHINESE","DRINKS"];
showDialog(context: context, builder: (ctx){return StatefulBuilder(builder: (ctx,setD){return AlertDialog(title: const Text("Add New Item - Starter",style:TextStyle(fontSize:14,fontWeight:FontWeight.bold)),content: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, children: [TextField(controller: nameCtrl, decoration: const InputDecoration(labelText: "Item Name (e.g. Paneer Tikka Starter)", border: OutlineInputBorder(), isDense: true)),const SizedBox(height:10),DropdownButtonFormField(value: selCat, items: cats.map((c)=>DropdownMenuItem(value:c,child:Text(c,style:const TextStyle(fontSize:12)))).toList(), onChanged: (v){setD(()=>selCat=v!);}, decoration: const InputDecoration(labelText: "Category", border: OutlineInputBorder(), isDense: true)),const SizedBox(height:10),Row(children: [Expanded(child: TextField(controller: halfCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Half Price", border: OutlineInputBorder(), isDense: true))),const SizedBox(width:10),Expanded(child: TextField(controller: fullCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: "Full Price", border: OutlineInputBorder(), isDense: true)))]),const SizedBox(height:10),const Text("Tip: Starter ke liye Half=Single, Full=Double rakh sakte ho",style:TextStyle(fontSize:9,color:Colors.grey))])),actions: [TextButton(onPressed: ()=>Navigator.pop(ctx), child: const Text("Cancel")),ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.green),onPressed: (){if(nameCtrl.text.isEmpty){ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Name likho!"))); return;}setState((){menu.add({"name":nameCtrl.text.trim(),"price":int.tryParse(halfCtrl.text)??100,"full":int.tryParse(fullCtrl.text)??200,"cat":selCat,"emoji":selEmoji});});Navigator.pop(ctx);ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${nameCtrl.text} Added! Total ${menu.length}"), backgroundColor: Colors.green));},child: const Text("ADD ITEM",style: TextStyle(color: Colors.white)))],);});});}

// DELETE ITEM
void deleteItem(int index){
showDialog(context: context, builder: (ctx)=>AlertDialog(title: const Text("Delete Item?"),content: Text("Kya ${menu[index]['name']} delete karna hai?"),actions: [TextButton(onPressed: ()=>Navigator.pop(ctx), child: const Text("No")),ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.red),onPressed: (){setState(()=>menu.removeAt(index));Navigator.pop(ctx);},child: const Text("Delete",style: TextStyle(color: Colors.white)))],));
}

void openBill(){showModalBottomSheet(context:context,isScrollControlled:true,backgroundColor:Colors.white,shape:const RoundedRectangleBorder(borderRadius:BorderRadius.vertical(top:Radius.circular(16))),builder:(ctx){return StatefulBuilder(builder:(ctx,setM){double tot=0;for(var e in cart) tot+=e['price']*e['qty'];return SizedBox(height:MediaQuery.of(context).size.height*0.9,child:Column(children:[Padding(padding:const EdgeInsets.all(16),child:Row(children:[Text("Order - $selTable | ${menu.length} Items",style:const TextStyle(fontWeight:FontWeight.bold,fontSize:13)),const Spacer(),IconButton(onPressed:()=>Navigator.pop(ctx),icon:const Icon(Icons.close))])),Expanded(child:GridView.builder(padding:const EdgeInsets.all(8),gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:3,childAspectRatio:0.70,crossAxisSpacing:6,mainAxisSpacing:6),itemCount:menu.length,itemBuilder:(c,i){var m=menu[i];int qty=0;int idx=cart.indexWhere((e)=>e['name']==m['name']);if(idx!=-1) qty=cart[idx]['qty'];return Container(decoration:BoxDecoration(border:Border.all(color:Colors.grey.shade300),borderRadius:BorderRadius.circular(8)),child:Column(children:[Expanded(child:Center(child:Text(m['emoji'],style:const TextStyle(fontSize:22)))),Padding(padding:const EdgeInsets.all(3),child:Column(children:[Text(m['name'],maxLines:2,textAlign:TextAlign.center,style:const TextStyle(fontSize:8,fontWeight:FontWeight.bold)),Text("H:${m['price']} F:${m['full']}",style:const TextStyle(fontSize:7,color:Colors.grey)),const SizedBox(height:2),qty==0?InkWell(onTap:(){setM(()=>cart.add({"name":m['name'],"price":m['price'],"qty":1}));setState((){});},child:Container(padding:const EdgeInsets.symmetric(horizontal:8,vertical:2),decoration:BoxDecoration(border:Border.all(color:Colors.blue),borderRadius:BorderRadius.circular(3)),child:const Text("+ Add",style:TextStyle(color:Colors.blue,fontSize:8)))):Container(decoration:BoxDecoration(color:Colors.blue,borderRadius:BorderRadius.circular(3)),child:Row(mainAxisAlignment:MainAxisAlignment.spaceAround,children:[InkWell(onTap:(){setM((){if(cart[idx]['qty']>1) cart[idx]['qty']--;else cart.removeAt(idx);});setState((){});},child:const Padding(padding:EdgeInsets.all(2),child:Icon(Icons.remove,size:10,color:Colors.white))),Text("$qty",style:const TextStyle(color:Colors.white,fontSize:9)),InkWell(onTap:(){setM(()=>cart[idx]['qty']++);setState((){});},child:const Padding(padding:EdgeInsets.all(2),child:Icon(Icons.add,size:10,color:Colors.white)))]))]))]));})),if(cart.isNotEmpty)Container(padding:const EdgeInsets.all(10),child:Row(children:[Text("Rs $tot",style:const TextStyle(fontWeight:FontWeight.bold)),const Spacer(),ElevatedButton(onPressed:(){var o={"table":selTable,"items":List.from(cart),"total":tot,"type":orderType,"payMode":"CASH","time":DateTime.now().toString().substring(11,16)};setState(()=>orders.add(o));Navigator.pop(ctx);cart=[];},style:ElevatedButton.styleFrom(backgroundColor:Colors.blue),child:const Text("BILL",style:TextStyle(color:Colors.white,fontSize:11)))]))])));});});}
}
