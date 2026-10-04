import 'package:flutter/material.dart';

void main() {
  runApp(const KgnTawaFryApp());
}

class KgnTawaFryApp extends StatelessWidget {
  const KgnTawaFryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KGN TAWA FRY',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.deepOrange,
        scaffoldBackgroundColor: const Color(0xFFFFF8F0),
      ),
      home: const LoginPage(),
    );
  }
}

// ================= MENU DATA =================

class FoodItem {
  final String name;
  final double half;
  final double full;

  const FoodItem(this.name, this.half, this.full);
}

const List<FoodItem> chickenItems = [
  FoodItem('Murgh Do Pyaza', 160, 300),
  FoodItem('Murgh Mughlai', 170, 320),
  FoodItem('Chicken Handi', 160, 300),
  FoodItem('Chicken Peshawar', 170, 320),
  FoodItem('Shahi Chicken', 170, 320),
  FoodItem('Malai Tikka', 180, 350),
  FoodItem('Tikka Masala', 170, 320),
  FoodItem('Karahi', 160, 300),
  FoodItem('Garlic Chicken', 160, 300),
  FoodItem('Chicken India', 250, 450),
  FoodItem('Butter Chicken Boneless', 170, 320),
  FoodItem('White Chicken', 180, 350),
  FoodItem('Green Chicken', 180, 350),
  FoodItem('Chicken Fry', 120, 220),
  FoodItem('Chicken Masala', 120, 220),
  FoodItem('Biryani', 80, 120),
  FoodItem('Tandoori Masala', 250, 480),
  FoodItem('Ahmedabad Masala', 160, 320),
  FoodItem('Tikka Rice', 170, 320),
];

const List<FoodItem> muttonItems = [
  FoodItem('Mughlai Mutton', 150, 280),
  FoodItem('Dalbati Gos', 150, 280),
  FoodItem('White Mutton', 160, 300),
  FoodItem('Green Mutton', 150, 280),
  FoodItem('Mutton Kurma', 160, 300),
  FoodItem('Mutton Fry', 120, 220),
  FoodItem('Mutton Masala', 120, 220),
  FoodItem('Kaleji Masala', 120, 220),
  FoodItem('Bhaji Gos', 130, 240),
  FoodItem('Paya Fry', 120, 220),
];

const List<FoodItem> fishItems = [
  FoodItem('Chaap Fry', 120, 220),
  FoodItem('Bheja Fry', 130, 240),
  FoodItem('Boti Masala', 120, 220),
  FoodItem('Kheema Fry', 80, 160),
  FoodItem('Kheema Pulao', 100, 180),
  FoodItem('Fish Fry', 80, 160),
  FoodItem('Fish Kadhi', 100, 200),
  FoodItem('Zinga Fry', 130, 240),
  FoodItem('Zinga Rice', 170, 320),
];

const List<FoodItem> vegItems = [
  FoodItem('Dal Tadka', 70, 140),
  FoodItem('Dal Gotala', 80, 160),
  FoodItem('Butter Dal Fry', 70, 140),
  FoodItem('Dal Fry', 50, 100),
  FoodItem('Sabji Fry', 50, 100),
  FoodItem('Sev Tomato', 50, 100),
  FoodItem('Masala Rice', 50, 100),
  FoodItem('Jeera Rice', 50, 100),
  FoodItem('Kadhi Khichdi', 30, 60),
  FoodItem('Dal Palak', 50, 100),
  FoodItem('Plain Rice', 50, 100),
];

const List<FoodItem> eggItems = [
  FoodItem('Anda Kadhi', 80, 160),
  FoodItem('Anda Kheema', 80, 160),
  FoodItem('Anda Bhurji', 50, 100),
  FoodItem('Anda Pulao', 60, 120),
];

const List<FoodItem> breadItems = [
  FoodItem('Special Roti', 15, 15),
  FoodItem('Special Paratha', 20, 20),
  FoodItem('Butter Roti', 15, 15),
  FoodItem('Chapati Roti', 7, 7),
  FoodItem('Papad Fry', 10, 10),
];

const List<FoodItem> starterItems = [
  FoodItem('Chicken Tandoori', 180, 350),
  FoodItem('Chicken Leg Piece', 100, 100),
  FoodItem('Chicken Lollipop', 50, 50),
  FoodItem('Chicken Tikka Stick', 10, 10),
  FoodItem('Chicken Crispy', 20, 20),
  FoodItem('Chicken Hyderabadi', 20, 20),
  FoodItem('Chicken Cutlets', 10, 10),
  FoodItem('Chicken Egg Kabab', 10, 10),
  FoodItem('Mutton Seekh Kabab', 10, 10),
  FoodItem('Mutton Boti Kabab', 10, 10),
  FoodItem('Chicken Dana Small', 50, 50),
  FoodItem('Chicken Dana Large', 100, 100),
];

// ================= LOGIN =================

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userController = TextEditingController(text: 'Admin');
  final passwordController = TextEditingController();

  void login() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const DashboardPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Card(
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Icon(
                    Icons.restaurant,
                    size: 75,
                    color: Colors.deepOrange,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'KGN TAWA FRY',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Smart Restaurant Billing',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: userController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: login,
                      icon: const Icon(Icons.login),
                      label: const Text('LOGIN'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ================= DASHBOARD =================

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  void open(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KGN TAWA FRY'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: [
          menuCard(
            context,
            'Billing',
            Icons.receipt_long,
            Colors.orange,
            const BillingPage(),
          ),
          menuCard(
            context,
            'KOT',
            Icons.soup_kitchen,
            Colors.red,
            const KotPage(),
          ),
          menuCard(
            context,
            'Tables',
            Icons.table_restaurant,
            Colors.blue,
            const TablesPage(),
          ),
          menuCard(
            context,
            'Menu',
            Icons.restaurant_menu,
            Colors
