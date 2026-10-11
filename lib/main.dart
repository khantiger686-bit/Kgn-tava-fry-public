import 'package:flutter/material.dart';
void main()=>runApp(const MyApp());
class MyApp extends StatelessWidget{const MyApp({super.key});@override Widget build(BuildContext c)=>MaterialApp(debugShowCheckedModeBanner:false,theme:ThemeData(primarySwatch:Colors.orange,useMaterial3:true),home:const LoginPage());}

class LoginPage extends StatefulWidget{const LoginPage({super.key});@override State<LoginPage> createState()=>_LoginPageState();}
class _LoginPageState extends State<LoginPage>{
String u='Salman';final p=TextEditingController();
Map<String,String> users={'Salman':'1234','Aslam':'1234','Admin':'admin123'};
@override Widget build(BuildContext context)=>Scaffold(body:Center(child:Padding(padding:const EdgeInsets.all(24),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[
const Icon(Icons.restaurant,size:80,color:Colors.orange),const Text('KGN TAVA FRY',style:TextStyle(fontSize:22,fontWeight:FontWeight.bold)),const Text('Waiter App'),const SizedBox(height:30),
DropdownButtonFormField(value:u,items:users.keys.map((e)=>DropdownMenuItem(value:e,child:Text(e))).toList(),onChanged:(v)=>setState(()=>u=v!),decoration:const InputDecoration(border:OutlineInputBorder(),labelText:'Waiter')),
const SizedBox(height:12),TextField(controller:p,obscureText:true,decoration:const InputDecoration(border:OutlineInputBorder(),labelText:'Password'),onSubmitted:(_)=>_login()),
const SizedBox(height:20),SizedBox(width:double.infinity,height:50,child:ElevatedButton(onPressed:_login,style:ElevatedButton.styleFrom(backgroundColor:Colors.orange,foregroundColor:Colors.white),child:const Text('LOGIN'))),
const SizedBox(height:10),const Text('Salman:1234 Aslam:1234 Admin:admin123',style:TextStyle(fontSize:10,color:Colors.grey))
]))));
void _login(){if(p.text==users[u]){Navigator.pushReplacement(context,MaterialPageRoute(builder:(_)=>HomePage(name:u)));}else{ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Text('Wrong Password')));}}
}

class MenuItem{String n;int h,f;String c;MenuItem(this.n,this.h,this.f,this.c);}
List<MenuItem> menu=[MenuItem('Chicken Biryani',120,220,'Biryani'),MenuItem('Mutton Biryani',180,320,'Biryani'),MenuItem('Veg Biryani',100,180,'Biryani'),MenuItem('Chicken Curry',150,260,'Main'),MenuItem('Butter Chicken',160,280,'Main'),MenuItem('Dal Fry',80,140,'Main'),MenuItem('Tandoori Roti',20,20,'Roti'),MenuItem('Naan',30,30,'Roti'),MenuItem('Cold Drink',30,50,'Drinks')];
class OrderItem{MenuItem i;bool full;int q;OrderItem(this.i,this.full,this.q);int get price=>full?i.f:i.h;int get tot=>price*q;}
class Tbl{int no;List<OrderItem> its=[];String w='';int get tot=>its.fold(0,(s,e)=>s+e.tot);Tbl(this.no);}

class HomePage extends StatefulWidget{final String name;const HomePage({super.key,required this.name});@override State<HomePage> createState()=>_HomePageState();}
class _HomePageState extends State<HomePage>{
List<Tbl> tbls=List.generate(8,(i)=>Tbl(i+1));
void open(int idx)async{
final t=tbls[idx];
final res=await Navigator.push(context,MaterialPageRoute(builder:(_)=>OrderPage(tbl:t,name:widget.name)));
if(res!=null)setState(()=>tbls[idx]=res);
}
@override Widget build(BuildContext c)=>Scaffold(
appBar:AppBar(title:Text('Hi ${widget.name} - Tables'),backgroundColor:Colors.orange,foregroundColor:Colors.white,actions:[IconButton(onPressed:()=>Navigator.pushReplacement(c,MaterialPageRoute(builder:(_)=>const LoginPage())),icon:const Icon(Icons.logout))]),
body:GridView.builder(padding:const EdgeInsets.all(12),gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,childAspectRatio:1.2,crossAxisSpacing:12,mainAxisSpacing:12),itemCount:8,itemBuilder:(c,i){
final t=tbls[i];final busy=t.its.isNotEmpty;
return InkWell(onTap:()=>open(i),child:Card(color:busy?Colors.orange.shade100:Colors.white,elevation:3,child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[
Icon(Icons.table_restaurant,size:40,color:busy?Colors.orange:Colors.grey),Text('T-0${t.no}',style:const TextStyle(fontWeight:FontWeight.bold)),Text(busy?'Rs.${t.tot} - ${t.its.length} items':'Empty',textAlign:TextAlign.center,style:TextStyle(color:busy?Colors.orange.shade800:Colors.grey)),if(busy)Text('by ${t.w}',style:const TextStyle(fontSize:10))
])));
}),
);
}

class OrderPage extends StatefulWidget{final Tbl tbl;final String name;const OrderPage({super.key,required this.tbl,required this.name});@override State<OrderPage> createState()=>_OrderPageState();}
class _OrderPageState extends State<OrderPage>{
late Tbl cur;@override void initState(){super.initState();cur=widget.tbl;if(cur.w.isEmpty)cur.w=widget.name;}
void add(MenuItem m,bool f){setState((){final i=cur.its.indexWhere((e)=>e.i.n==m.n&&e.full==f);if(i>=0)cur.its[i].q++;else cur.its.add(OrderItem(m,f,1));});}
@override Widget build(BuildContext c)=>Scaffold(
appBar:AppBar(title:Text('Table ${cur.no}'),backgroundColor:Colors.orange,foregroundColor:Colors.white),
body:Column(children:[
Expanded(child:Row(children:[
Expanded(child:ListView.builder(itemCount:menu.length,itemBuilder:(c,i){final m=menu[i];return Card(child:ListTile(title:Text(m.n,style:const TextStyle(fontSize:13,fontWeight:FontWeight.bold)),subtitle:Text('H:${m.h} F:${m.f}'),trailing:Row(mainAxisSize:MainAxisSize.min,children:[ElevatedButton(onPressed:()=>add(m,false),child:const Text('H')),const SizedBox(width:5),ElevatedButton(onPressed:()=>add(m,true),style:ElevatedButton.styleFrom(backgroundColor:Colors.orange,foregroundColor:Colors.white),child:const Text('F'))]))); })),
Expanded(child:Container(color:Colors.grey.shade100,child:Column(children:[
Container(color:Colors.orange,padding:const EdgeInsets.all(10),child:Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[const Text('KOT',style:TextStyle(color:Colors.white,fontWeight:FontWeight.bold)),Text('Rs.${cur.tot}',style:const TextStyle(color:Colors.white,fontWeight:FontWeight.bold))])),
Expanded(child:ListView.builder(itemCount:cur.its.length,itemBuilder:(c,i){final o=cur.its[i];return ListTile(dense:true,title:Text('${o.i.n} ${o.full?'F':'H'}',style:const TextStyle(fontSize:12)),subtitle:Text('Rs.${o.price}x${o.q}=${o.tot}'),trailing:Row(mainAxisSize:MainAxisSize.min,children:[InkWell(onTap:()=>setState(()=>o.q>1?o.q--:cur.its.removeAt(i)),child:const Icon(Icons.remove_circle,size:18)),Text(' ${o.q} '),InkWell(onTap:()=>setState(()=>o.q++),child:const Icon(Icons.add_circle,size:18))]));})),
Padding(padding:const EdgeInsets.all(8),child:Column(children:[Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,children:[const Text('TOTAL',style:TextStyle(fontWeight:FontWeight.bold)),Text('Rs.${cur.tot}',style:const TextStyle(fontWeight:FontWeight.bold))]),const SizedBox(height:8),SizedBox(width:double.infinity,child:ElevatedButton(onPressed:cur.its.isEmpty?null:(){Navigator.pop(context,cur);},style:ElevatedButton.styleFrom(backgroundColor:Colors.green,foregroundColor:Colors.white),child:const Text('SAVE & CLOSE')))]))
]))]))]),
);
  }
