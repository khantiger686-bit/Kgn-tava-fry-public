import 'package:flutter/material.dart';
void main(){runApp(MaterialApp(debugShowCheckedModeBanner:false,home:LoginPage()));}
class LoginPage extends StatelessWidget{
LoginPage({super.key});
final c=TextEditingController();
@override Widget build(BuildContext context){return Scaffold(body:Center(child:Padding(padding:EdgeInsets.all(20),child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[
Icon(Icons.restaurant,size:80,color:Colors.orange),Text('KGN TAVA FRY',style:TextStyle(fontSize:24,fontWeight:FontWeight.bold)),SizedBox(height:20),
TextField(controller:c,decoration:InputDecoration(labelText:'Password (1234)',border:OutlineInputBorder())),SizedBox(height:20),
ElevatedButton(onPressed:(){if(c.text=='1234'){Navigator.pushReplacement(context,MaterialPageRoute(builder:(_)=>HomeScreen()));}},child:Text('LOGIN'),style:ElevatedButton.styleFrom(backgroundColor:Colors.orange,foregroundColor:Colors.white,minimumSize:Size(double.infinity,50)))
]))));}
}
class HomeScreen extends StatelessWidget{
HomeScreen({super.key});
final List<String> tables=['T-01','T-02','T-03','T-04','T-05','T-06','T-07','T-08'];
@override Widget build(BuildContext context){return Scaffold(appBar:AppBar(title:Text('KGN Tables'),backgroundColor:Colors.orange,foregroundColor:Colors.white),body:GridView.builder(padding:EdgeInsets.all(12),gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount:2,childAspectRatio:1.2,crossAxisSpacing:10,mainAxisSpacing:10),itemCount:8,itemBuilder:(c,i){return Card(child:InkWell(onTap:(){ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text('${tables[i]} selected')));},child:Column(mainAxisAlignment:MainAxisAlignment.center,children:[Icon(Icons.table_bar,size:40,color:Colors.orange),Text(tables[i],style:TextStyle(fontWeight:FontWeight.bold)),Text('Empty',style:TextStyle(color:Colors.grey))])));}),bottomNavigationBar:BottomNavigationBar(selectedItemColor:Colors.orange,items:[BottomNavigationBarItem(icon:Icon(Icons.table_restaurant),label:'Tables'),BottomNavigationBarItem(icon:Icon(Icons.receipt),label:'Bills'),BottomNavigationBarItem(icon:Icon(Icons.settings),label:'Menu')]),);}
}
