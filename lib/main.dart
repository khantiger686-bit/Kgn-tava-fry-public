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
        primarySwatch: Colors.deepOrange,
        scaffoldBackgroundColor: const Color(0xFFFFF8F2),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String selectedWaiter = 'Salman';

  final List<String> waiters = [
    'Salman',
    'Aslam',
    'Imran',
    'Admin',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Icon(
                  Icons.restaurant,
                  size: 70,
                  color: Colors.deepOrange,
                ),
                const SizedBox(height: 15),
                const Text(
                  'KGN TAWA FRY',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepOrange,
                  ),
                ),
                const SizedBox(height: 5),
                const Text(
                  'PRO NO GST',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 35),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Text(
                          'Select Waiter',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        ...waiters.map(
                          (waiter) => RadioListTile<String>(
                            title: Text(waiter),
                            value: waiter,
                            groupValue: selectedWaiter,
                            onChanged: (value) {
                              setState(() {
                                selectedWaiter = value!;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => HomePage(
                                    waiter: selectedWaiter,
                                  ),
                                ),
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(14),
                              child: Text(
                                'START ORDER',
                                style: TextStyle(fontSize: 17),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final String waiter;

  const HomePage({
    super.key,
    required this.waiter,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> tables = List.generate(
    12,
    (index) => {
      'id': index + 1,
      'status': 'Empty',
    },
  );

  final List<Map<String, dynamic>> history = [];

  final List<Map<String, dynamic>> menu = [
    {'name': 'Murg Do Pyaza', 'price': 300, 'category': 'Chicken'},
    {'name': 'Mughlai', 'price': 320, 'category': 'Chicken'},
    {'name': 'Handi', 'price': 300, 'category': 'Chicken'},
    {'name': 'Malai Tikka', 'price': 350, 'category': 'Chicken'},
    {'name': 'Butter Chicken', 'price': 320, 'category': 'Chicken'},
    {'name': 'Chicken Fry', 'price': 220, 'category': 'Chicken'},
    {'name': 'Chicken Biryani', 'price': 120, 'category': 'Biryani'},
    {'name': 'Mutton Fry', 'price': 220, 'category': 'Mutton'},
    {'name': 'Fish Fry', 'price': 160, 'category': 'Fish'},
    {'name': 'Dal Fry', 'price': 100, 'category': 'Veg'},
    {'name': 'Jeera Rice', 'price': 100, 'category': 'Rice'},
    {'name': 'Roti', 'price': 7, 'category': 'Roti'},
  ];

  void openTable(int tableId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => OrderPage(
          tableId: tableId,
          menu: menu,
          onOrderComplete: () {
            setState(() {
              tables[tableId - 1]['status'] = 'Occupied';
            });
          },
        ),
      ),
    );
  }

  void clearTable(int tableId) {
    setState(() {
      tables[tableId - 1]['status'] = 'Empty';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('KGN TAWA FRY - ${widget.waiter}'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(15),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Tables',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.15,
              ),
              itemCount: tables.length,
              itemBuilder: (context, index) {
                final table = tables[index];
                final id = table['id'] as int;
                final occupied = table['status'] == 'Occupied';

                return Card(
                  child: InkWell(
                    onTap: () => openTable(id),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.table_restaurant,
                            size: 45,
                            color: occupied
                                ? Colors.red
                                : Colors.green,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Table $id',
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            table['status'],
                            style: TextStyle(
                              color: occupied
                                  ? Colors.red
                                  : Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          if (occupied)
                            TextButton(
                              onPressed: () => clearTable(id),
                              child: const Text('Clear'),
                            ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class OrderPage extends StatefulWidget {
  final int tableId;
  final List<Map<String, dynamic>> menu;
  final VoidCallback onOrderComplete;

  const OrderPage({
    super.key,
    required this.tableId,
    required this.menu,
    required this.onOrderComplete,
  });

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  final Map<String, int> cart = {};

  void addItem(String name) {
    setState(() {
      cart[name] = (cart[name] ?? 0) + 1;
    });
  }

  void removeItem(String name) {
    setState(() {
      if (!cart.containsKey(name)) return;

      if (cart[name]! > 1) {
        cart[name] = cart[name]! - 1;
      } else {
        cart.remove(name);
      }
    });
  }

  int get total {
    int amount = 0;

    for (final item in widget.menu) {
      final name = item['name'] as String;
      final price = item['price'] as int;
      final quantity = cart[name] ?? 0;
      amount += price * quantity;
    }

    return amount;
  }

  void placeOrder() {
    if (cart.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add items first'),
        ),
      );
      return;
    }

    widget.onOrderComplete();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Order Saved'),
        content: Text(
          'Table ${widget.tableId}\n'
          'Total: ₹$total',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table ${widget.tableId} Order'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: widget.menu.length,
              itemBuilder: (context, index) {
                final item = widget.menu[index];
                final name = item['name'] as String;
                final price = item['price'] as int;
                final quantity = cart[name] ?? 0;

                return Card(
                  child: ListTile(
                    title: Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      '${item['category']}  •  ₹$price',
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: quantity == 0
                              ? null
                              : () => removeItem(name),
                          icon: const Icon(Icons.remove),
                        ),
                        Text(
                          '$quantity',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () => addItem(name),
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: Colors.black12,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Total: ₹$total',
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: placeOrder,
                  icon: const Icon(Icons.check),
                  label: const Text('SAVE ORDER'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
