import 'package:flutter/material.dart';
void main()=>runApp(KGNApp());
class KGNApp extends StatelessWidget{
@override Widget build(BuildContext context){return MaterialApp(debugShowCheckedModeBanner:false,title:'KGN TAWA FRY',theme:ThemeData(primarySwatch:Colors.red),home:TableScreen());}
}
class MenuItem{String name;double price;bool isVeg;MenuItem(this.name,this.price,this.isVeg);}
class OrderItem{MenuItem item;int qty;OrderItem(this.item,this.qty);}
class TableData{int id;bool isBusy;List<OrderItem> orders;TableData(this.id,{this.isBusy=false,List<OrderItem>? orders}):orders=orders??[];double get total=>orders.fold(0,(s,o)=>s+o.item.price*o.qty);}
List<MenuItem> menu=[MenuItem("Chicken Tawa Fry",250,false),MenuItem("Chicken Tandoori",300,false),MenuItem("Egg Tawa Fry",150,false),MenuItem("Chicken Biryani",200,false),MenuItem("Veg Pulao",120,true),MenuItem("Butter Naan",30,true),MenuItem("Cold Drink",40,true),];
List<TableData> tables=List.generate(6,(i)=>TableData(i+1));
class TableScreen extends StatefulWidget{@override _TableScreenState createState()=>_TableScreenState();}
class _TableScreenState extends State<TableScreen>{
@override Widget build(BuildContext context){
return Scaffold(appBar:AppBar(backgroundColor:Color(0xFFD32F2F),title:Text("KGN TAWA FRY",style:TextStyle(fontWeight:FontWeight.bold,color:Colors.white)),centerTitle:true),
body:Column(children:[
Container(width:double.infinity,color:Color(0xFFFFF8E1),padding:EdgeInsets.all(12),child:Text("6 Tables - Green=Free, Red=Busy",textAlign:TextAlign.center,style:TextStyle(fontWeight:FontWeight.w600))),
Expanded(child:GridView.builder(padding:EdgeInsets.all(16),gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,childAspectRatio:1.2,crossAxisSpacing:16,mainAxisSpacing:16),itemCount:tables.length,itemBuilder:(c,i){var t=tables[i];return GestureDetector(onTap:()async{await Navigator.push(context,MaterialPageRoute(builder:(_)=>OrderScreen(table:t)));setState((){});},child:Container(decoration:BoxDecoration(color:t.isBusy?Color(0xFFFFCDD2):Color(0xFFC8E6C9),borderRadius:BorderRadius.circular(16),border:Border.all(color:t.isBusy?Colors.red:Colors.green,width:2)),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(Icons.table_restaurant,size:40,color:t.isBusy?Colors.red:Colors.green),SizedBox(height:8),Text("TABLE ${t.id}",style:TextStyle(fontSize:18,fontWeight:FontWeight.bold)),Text(t.isBusy?"BUSY - Rs.${t.total.toInt()}":"FREE",style:TextStyle(color:t.isBusy?Colors.red[800]:Colors.green[800])),if(t.isBusy)Text("${t.orders.length} items",style:TextStyle(fontSize:12))])));}),),
Container(padding:EdgeInsets.all(12),color:Colors.black87,child:Row(mainAxisAlignment:MainAxisAlignment.spaceAround,children:[Text("Today: Rs.${tables.fold(0.0,(s,t)=>s+t.total).toInt()}",style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold)),Text("Busy: ${tables.where((t)=>t.isBusy).length}/6",style:TextStyle(color:Colors.white)),]),)
]),);
}
}
class OrderScreen extends StatefulWidget{final TableData table;OrderScreen({required this.table});@override _OrderScreenState createState()=>_OrderScreenState();}
class _OrderScreenState extends State<OrderScreen>{
void addItem(MenuItem m){setState((){widget.table.isBusy=true;var ex=widget.table.orders.where((e)=>e.item.name==m.name);if(ex.isNotEmpty)ex.first.qty++;else widget.table.orders.add(OrderItem(m,1));});}
@override Widget build(BuildContext context){
return Scaffold(appBar:AppBar(backgroundColor:Color(0xFFD32F2F),title:Text("TABLE ${widget.table.id} - Rs.${widget.table.total.toInt()}",style:TextStyle(color:Colors.white)),iconTheme:IconThemeData(color:Colors.white)),
body:Column(children:[
Expanded(child:ListView.builder(itemCount:menu.length,itemBuilder:(c,i){var m=menu[i];return Card(margin:EdgeInsets.symmetric(horizontal:8,vertical:4),child:ListTile(leading:Icon(m.isVeg?Icons.eco:Icons.restaurant,color:m.isVeg?Colors.green:Colors.red),title:Text(m.name,style:TextStyle(fontWeight:FontWeight.bold)),subtitle:Text("Rs. ${m.price}"),trailing:ElevatedButton(style:ElevatedButton.styleFrom(backgroundColor:Color(0xFFD32F2F),shape:RoundedRectangleBorder(borderRadius:BorderRadius.circular(20))),onPressed:()=>addItem(m),child:Text("ADD",style:TextStyle(color:Colors.white))),));})),
if(widget.table.orders.isNotEmpty)Container(padding:EdgeInsets.all(12),decoration:BoxDecoration(color:Colors.white,boxShadow:[BoxShadow(color:Colors.black26,blurRadius:10)]),child:Column(children:[...widget.table.orders.map((o)=>Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[Text("${o.item.name} x${o.qty}"),Row(children:[Text("Rs.${(o.item.price*o.qty).toInt()} "),GestureDetector(onTap:(){setState((){o.qty--;if(o.qty==0)widget.table.orders.remove(o);if(widget.table.orders.isEmpty)widget.table.isBusy=false;});},child:Icon(Icons.remove_circle,color:Colors.red,size:20)),]),])).toList(),Divider(),Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[Text("TOTAL",style:TextStyle(fontWeight:FontWeight.bold,fontSize:18)),Text("Rs.${widget.table.total.toInt()}",style:TextStyle(fontWeight:FontWeight.bold,fontSize:18)),]),SizedBox(height:8),Row(children:[Expanded(child:ElevatedButton.icon(onPressed:(){ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("KOT Sent to Kitchen for Table ${widget.table.id}!")));},icon:Icon(Icons.kitchen),label:Text("KOT SEND"),style:ElevatedButton.styleFrom(backgroundColor:Colors.orange))),SizedBox(width:8),Expanded(child:ElevatedButton.icon(onPressed:(){showDialog(context:context,builder:(_)=>AlertDialog(title:Text("Bill - Table ${widget.table.id}"),content:Text("Total: Rs.${widget.table.total.toInt()}\n\nItems:\n${widget.table.orders.map((e)=>"${e.item.name} x${e.qty}").join("\n")}"),actions:[TextButton(onPressed:(){setState((){widget.table.orders.clear();widget.table.isBusy=false;});Navigator.pop(context);Navigator.pop(context);},child:Text("PAID & CLEAR TABLE"))]));},icon:Icon(Icons.receipt),label:Text("BILL"),style:ElevatedButton.styleFrom(backgroundColor:Colors.green))),])]))],),);
}
}
