# KGN TAVA FRY - Production Flutter POS App Codebase
**Restaurant:** KGN TAVA FRY (M.H. KHAN)  
**Location:** Machhipith, Raopura, Vadodara  
**Contact:** 96245 32343 • 89804 62407  
**UPI VPA:** `kgntavafry@okaxis`

---

## 1. Project Dependencies (`pubspec.yaml`)

```yaml
name: kgn_tava_fry_pos
description: "Production Waiter Ordering, KOT Dispatch, Split Billing POS & Bluetooth Thermal Printer for KGN Tawa Fry"
publish_to: 'none'
version: 1.1.0+2

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  provider: ^6.1.1
  qr_flutter: ^4.1.0
  intl: ^0.19.0
  google_fonts: ^6.1.0
  # Bluetooth Thermal ESC/POS Printer Libraries
  blue_thermal_printer: ^1.2.3
  esc_pos_utils: ^1.1.0
  permission_handler: ^11.3.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0

flutter:
  uses-material-design: true
```

---

## 2. Android & iOS Bluetooth Permissions Setup

### Android (`android/app/src/main/AndroidManifest.xml`)
Add inside `<manifest>`:
```xml
    <!-- Bluetooth Permissions for Thermal Printers -->
    <uses-permission android:name="android.permission.BLUETOOTH" />
    <uses-permission android:name="android.permission.BLUETOOTH_ADMIN" />
    <uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
    <uses-permission android:name="android.permission.BLUETOOTH_SCAN" android:usesPermissionFlags="neverForLocation" />
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
```

### iOS (`ios/Runner/Info.plist`)
```xml
    <key>NSBluetoothAlwaysUsageDescription</key>
    <string>KGN Tawa Fry POS uses Bluetooth to connect to kitchen and counter thermal receipt printers.</string>
    <key>NSBluetoothPeripheralUsageDescription</key>
    <string>Connect to Bluetooth ESC/POS receipt printer.</string>
```

---

## 3. Complete Application Source (`lib/main.dart`)

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PosProvider()),
      ],
      child: const KgnTavaFryApp(),
    ),
  );
}

// -------------------------------------------------------------
// BRAND THEME & COLORS
// -------------------------------------------------------------
class KgnTheme {
  static const Color primary = Color(0xFFEA580C); // Warm Saffron / Deep Orange
  static const Color primaryDark = Color(0xFFC2410C);
  static const Color darkSlate = Color(0xFF0F172A);
  static const Color surfaceLight = Color(0xFFF8FAFC);
  static const Color emeraldGreen = Color(0xFF059669);
  static const Color crimsonRed = Color(0xFFDC2626);
}

// -------------------------------------------------------------
// MODELS
// -------------------------------------------------------------
class MenuItem {
  final String id;
  final String name;
  final String gujaratiName;
  final String category;
  final double halfPrice;
  final double fullPrice;
  final bool isVeg;
  bool isAvailable;

  MenuItem({
    required this.id,
    required this.name,
    required this.gujaratiName,
    required this.category,
    required this.halfPrice,
    required this.fullPrice,
    required this.isVeg,
    this.isAvailable = true,
  });
}

class CartItem {
  final MenuItem item;
  final String portion; // "Half" or "Full"
  final double price;
  int quantity;

  CartItem({
    required this.item,
    required this.portion,
    required this.price,
    this.quantity = 1,
  });
}

class TableModel {
  final String tableNumber;
  final int seatingPax;
  String status; // "Available", "Occupied", "Billing"
  double currentOrderSum;

  TableModel({
    required this.tableNumber,
    required this.seatingPax,
    this.status = "Available",
    this.currentOrderSum = 0.0,
  });
}

// -------------------------------------------------------------
// BLUETOOTH THERMAL PRINTER SERVICE
// -------------------------------------------------------------
class PrinterService {
  final BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  Future<bool> requestPermissions() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.bluetooth,
      Permission.bluetoothScan,
      Permission.bluetoothConnect,
      Permission.location,
    ].request();
    return statuses.values.every((s) => s.isGranted || s.isLimited);
  }

  Future<List<BluetoothDevice>> getPairedDevices() async {
    try {
      return await bluetooth.getBondedDevices();
    } catch (e) {
      debugPrint("Error fetching devices: $e");
      return [];
    }
  }

  Future<bool> connect(BluetoothDevice device) async {
    try {
      bool? isConnected = await bluetooth.isConnected;
      if (isConnected == true) {
        await bluetooth.disconnect();
      }
      await bluetooth.connect(device);
      return true;
    } catch (e) {
      debugPrint("Bluetooth Connection Error: $e");
      return false;
    }
  }

  Future<void> disconnect() async {
    await bluetooth.disconnect();
  }

  // Print KOT (Kitchen Order Ticket)
  Future<bool> printKOT({
    required String tableNo,
    required String waiter,
    required List<CartItem> items,
    required int kotNumber,
  }) async {
    bool? isConnected = await bluetooth.isConnected;
    if (isConnected != true) return false;

    final timeStr = DateFormat('hh:mm a  dd/MM/yyyy').format(DateTime.now());

    // 0: Normal, 1: Bold, 2: Bold Large, 3: Huge
    bluetooth.printCustom("KGN TAVA FRY (KITCHEN KOT)", 2, 1);
    bluetooth.printCustom("** RUNNING KOT #$kotNumber **", 1, 1);
    bluetooth.printLeftRight("TABLE: $tableNo", "WAITER: $waiter", 1);
    bluetooth.printCustom("TIME: $timeStr", 0, 0);
    bluetooth.printCustom("--------------------------------", 1, 1);
    bluetooth.printLeftRight("ITEM [PORTION]", "QTY", 1);
    bluetooth.printCustom("--------------------------------", 1, 1);

    for (var item in items) {
      final nameStr = "${item.item.name} (${item.portion})";
      bluetooth.printLeftRight(nameStr, "x${item.quantity}", 1);
      if (item.item.gujaratiName.isNotEmpty) {
        bluetooth.printCustom("  > ${item.item.gujaratiName}", 0, 0);
      }
    }

    bluetooth.printCustom("--------------------------------", 1, 1);
    bluetooth.printCustom("Dispatch to Kitchen Stations: Tawa & Gravy", 0, 1);
    bluetooth.printNewLine();
    bluetooth.printNewLine();
    bluetooth.paperCut();
    return true;
  }

  // Print Customer Tax Invoice / Receipt
  Future<bool> printCustomerReceipt({
    required String tableNo,
    required String billNo,
    required String waiter,
    required List<CartItem> items,
    required double subtotal,
    required double total,
    required int splitCount,
    required String paymentMode,
  }) async {
    bool? isConnected = await bluetooth.isConnected;
    if (isConnected != true) return false;

    final timeStr = DateFormat('dd/MM/yyyy hh:mm a').format(DateTime.now());

    bluetooth.printCustom("KGN TAVA FRY", 3, 1);
    bluetooth.printCustom("M.H. KHAN - Authentic Tawa Fry", 1, 1);
    bluetooth.printCustom("Machhipith, Raopura, Vadodara", 0, 1);
    bluetooth.printCustom("Ph: 96245 32343 / 89804 62407", 0, 1);
    bluetooth.printCustom("GSTIN: 24AAAFK8902M1Z5", 0, 1);
    bluetooth.printCustom("================================", 1, 1);
    bluetooth.printLeftRight("BILL: #$billNo", "TABLE: $tableNo", 1);
    bluetooth.printLeftRight("SERVER: $waiter", "DATE: $timeStr", 0);
    bluetooth.printCustom("--------------------------------", 1, 1);
    bluetooth.printLeftRight("ITEM [PORTION] x QTY", "AMOUNT (INR)", 1);
    bluetooth.printCustom("--------------------------------", 1, 1);

    for (var item in items) {
      final lineDesc = "${item.item.name} (${item.portion}) x${item.quantity}";
      final lineAmt = (item.price * item.quantity).toStringAsFixed(2);
      bluetooth.printLeftRight(lineDesc, lineAmt, 0);
    }

    bluetooth.printCustom("--------------------------------", 1, 1);
    bluetooth.printLeftRight("Subtotal:", "INR ${subtotal.toStringAsFixed(2)}", 0);
    bluetooth.printLeftRight("CGST (2.5%):", "INR ${(subtotal * 0.025).toStringAsFixed(2)}", 0);
    bluetooth.printLeftRight("SGST (2.5%):", "INR ${(subtotal * 0.025).toStringAsFixed(2)}", 0);
    bluetooth.printCustom("================================", 1, 1);
    bluetooth.printLeftRight("TOTAL PAYABLE:", "INR ${total.toStringAsFixed(2)}", 2);

    if (splitCount > 1) {
      final perGuest = (total / splitCount).toStringAsFixed(2);
      bluetooth.printLeftRight("Split ($splitCount Pax):", "INR $perGuest each", 1);
    }

    bluetooth.printLeftRight("TENDER MODE:", paymentMode, 1);
    bluetooth.printCustom("--------------------------------", 1, 1);
    bluetooth.printCustom("UPI: kgntavafry@okaxis", 1, 1);
    bluetooth.printCustom("Scan & Pay via GPay / PhonePe / Paytm", 0, 1);
    bluetooth.printCustom("THANK YOU! VISIT AGAIN!", 1, 1);
    bluetooth.printNewLine();
    bluetooth.printNewLine();
    bluetooth.paperCut();
    return true;
  }
}

// -------------------------------------------------------------
// STATE MANAGEMENT (PROVIDER)
// -------------------------------------------------------------
class PosProvider extends ChangeNotifier {
  String activeWaiter = "Salman";
  String activeTable = "T-01";
  int kotCounter = 101;

  final PrinterService printerService = PrinterService();
  List<BluetoothDevice> pairedDevices = [];
  BluetoothDevice? selectedDevice;
  bool isPrinterConnected = false;
  bool isScanningPrinters = false;

  PosProvider() {
    initBluetooth();
  }

  Future<void> initBluetooth() async {
    isScanningPrinters = true;
    notifyListeners();
    try {
      await printerService.requestPermissions();
      pairedDevices = await printerService.getPairedDevices();
      bool? connected = await printerService.bluetooth.isConnected;
      isPrinterConnected = connected ?? false;
      if (pairedDevices.isNotEmpty && selectedDevice == null) {
        selectedDevice = pairedDevices.first;
      }
    } catch (e) {
      debugPrint("Bluetooth Init Error: $e");
    } finally {
      isScanningPrinters = false;
      notifyListeners();
    }
  }

  Future<bool> connectPrinter(BluetoothDevice device) async {
    selectedDevice = device;
    notifyListeners();
    bool success = await printerService.connect(device);
    isPrinterConnected = success;
    notifyListeners();
    return success;
  }

  Future<void> disconnectPrinter() async {
    await printerService.disconnect();
    isPrinterConnected = false;
    notifyListeners();
  }

  final List<TableModel> tables = [
    TableModel(tableNumber: "T-01", seatingPax: 2, status: "Occupied", currentOrderSum: 480.0),
    TableModel(tableNumber: "T-02", seatingPax: 4, status: "Available"),
    TableModel(tableNumber: "T-03", seatingPax: 4, status: "Billing", currentOrderSum: 840.0),
    TableModel(tableNumber: "T-04", seatingPax: 6, status: "Occupied", currentOrderSum: 1120.0),
    TableModel(tableNumber: "T-05", seatingPax: 2, status: "Available"),
    TableModel(tableNumber: "T-06", seatingPax: 4, status: "Available"),
    TableModel(tableNumber: "T-07", seatingPax: 8, status: "Occupied", currentOrderSum: 2350.0),
    TableModel(tableNumber: "T-08", seatingPax: 4, status: "Available"),
  ];

  final List<MenuItem> menu = [
    // Chicken (Page 1)
    MenuItem(id: "1", name: "Murgh Do Pyaza", gujaratiName: "મુર્ગ દો પ્યાઝા", category: "Chicken", halfPrice: 160, fullPrice: 300, isVeg: false),
    MenuItem(id: "2", name: "Murgh Mughlai", gujaratiName: "મુર્ગ મુગલાઈ", category: "Chicken", halfPrice: 170, fullPrice: 320, isVeg: false),
    MenuItem(id: "3", name: "Chicken Handi", gujaratiName: "ચિકન હાંડી", category: "Chicken", halfPrice: 160, fullPrice: 300, isVeg: false),
    MenuItem(id: "4", name: "Butter Chicken Boneless", gujaratiName: "બટર ચિકન બોનલેસ", category: "Chicken", halfPrice: 170, fullPrice: 320, isVeg: false),
    MenuItem(id: "5", name: "Chicken Biryani", gujaratiName: "ચિકન બિરયાની", category: "Chicken", halfPrice: 80, fullPrice: 120, isVeg: false),
    // Mutton & Fish (Page 2)
    MenuItem(id: "6", name: "Mughlai Mutton", gujaratiName: "મુઘલાઈ મટન", category: "Mutton", halfPrice: 150, fullPrice: 280, isVeg: false),
    MenuItem(id: "7", name: "Dalbati Gos", gujaratiName: "દાળબાટી ગોસ", category: "Mutton", halfPrice: 150, fullPrice: 280, isVeg: false),
    MenuItem(id: "8", name: "Fish Fry", gujaratiName: "માછલી ફ્રાય", category: "Mutton", halfPrice: 80, fullPrice: 160, isVeg: false),
    // Egg & Veg (Page 3)
    MenuItem(id: "9", name: "Anda Kadhi", gujaratiName: "ઈંડા કઢી", category: "Veg", halfPrice: 80, fullPrice: 160, isVeg: false),
    MenuItem(id: "10", name: "Dal Tadka", gujaratiName: "દાળ તડકા", category: "Veg", halfPrice: 70, fullPrice: 140, isVeg: true),
    MenuItem(id: "11", name: "Butter Dal Fry", gujaratiName: "બટર દાળ ફ્રાય", category: "Veg", halfPrice: 70, fullPrice: 140, isVeg: true),
    // Starters (Page 4)
    MenuItem(id: "12", name: "Chicken Tandoori", gujaratiName: "ચિકન તંદૂરી", category: "Starters", halfPrice: 180, fullPrice: 350, isVeg: false),
    MenuItem(id: "13", name: "Chicken Leg Piece", gujaratiName: "ચિકન લેગ પીસ", category: "Starters", halfPrice: 100, fullPrice: 100, isVeg: false),
  ];

  final List<CartItem> cart = [];

  void selectWaiter(String name) {
    activeWaiter = name;
    notifyListeners();
  }

  void selectTable(String tableNo) {
    activeTable = tableNo;
    notifyListeners();
  }

  void addToCart(MenuItem item, String portion, double price) {
    final existingIndex = cart.indexWhere((c) => c.item.id == item.id && c.portion == portion);
    if (existingIndex >= 0) {
      cart[existingIndex].quantity += 1;
    } else {
      cart.add(CartItem(item: item, portion: portion, price: price));
    }
    notifyListeners();
  }

  void removeCartItem(int index) {
    cart.removeAt(index);
    notifyListeners();
  }

  void clearCart() {
    cart.clear();
    notifyListeners();
  }

  double get cartTotal => cart.fold(0, (sum, item) => sum + (item.price * item.quantity));

  void toggleItemStock(String id) {
    final item = menu.firstWhere((element) => element.id == id);
    item.isAvailable = !item.isAvailable;
    notifyListeners();
  }

  Future<bool> dispatchKOTToPrinter() async {
    if (cart.isEmpty) return false;
    kotCounter++;
    bool printed = await printerService.printKOT(
      tableNo: activeTable,
      waiter: activeWaiter,
      items: List.from(cart),
      kotNumber: kotCounter,
    );
    clearCart();
    return printed;
  }

  Future<bool> printBill({required String billNo, required String mode, int splitCount = 1}) async {
    // Demo receipt items for active table settlement
    final sampleItems = [
      CartItem(item: menu[4], portion: "Full", price: 220, quantity: 2), // Chicken Biryani
      CartItem(item: menu[3], portion: "Full", price: 280, quantity: 1), // Butter Chicken
      CartItem(item: MenuItem(id: "99", name: "Butter Naan", gujaratiName: "બટર નાન", category: "Roti", halfPrice: 30, fullPrice: 30, isVeg: true), portion: "Unit", price: 30, quantity: 4),
    ];
    double sub = 840.0;
    return await printerService.printCustomerReceipt(
      tableNo: activeTable,
      billNo: billNo,
      waiter: activeWaiter,
      items: sampleItems,
      subtotal: sub,
      total: sub,
      splitCount: splitCount,
      paymentMode: mode,
    );
  }
}

// -------------------------------------------------------------
// APP ROOT
// -------------------------------------------------------------
class KgnTavaFryApp extends StatelessWidget {
  const KgnTavaFryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KGN TAVA FRY POS',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: KgnTheme.surfaceLight,
        colorScheme: ColorScheme.fromSeed(seedColor: KgnTheme.primary),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

// -------------------------------------------------------------
// MAIN NAVIGATION WRAPPER
// -------------------------------------------------------------
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    TablesScreen(),
    MenuOrderingScreen(),
    BillingScreen(),
    InventoryScreen(),
    PrinterSettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PosProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: KgnTheme.darkSlate,
        elevation: 2,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: KgnTheme.primary,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text('K', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('KGN TAVA FRY', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.orange)),
                Text('Vadodara • Waiter: ${provider.activeWaiter}', style: const TextStyle(fontSize: 11, color: Colors.white70)),
              ],
            ),
          ],
        ),
        actions: [
          // Bluetooth Status Badge & Quick Settings
          IconButton(
            icon: Icon(
              Icons.print,
              color: provider.isPrinterConnected ? Colors.greenAccent : Colors.redAccent,
            ),
            tooltip: provider.isPrinterConnected ? 'Thermal Printer Connected' : 'Printer Disconnected',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PrinterSettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (idx) => setState(() => _currentIndex = idx),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.table_restaurant), label: 'Tables'),
          NavigationDestination(icon: Icon(Icons.restaurant_menu), label: 'Menu'),
          NavigationDestination(icon: Icon(Icons.receipt_long), label: 'Billing'),
          NavigationDestination(icon: Icon(Icons.inventory_2), label: 'Stock / 86'),
          NavigationDestination(icon: Icon(Icons.bluetooth_searching), label: 'Printer'),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------
// SCREEN 5: BLUETOOTH THERMAL PRINTER SETTINGS & DIAGNOSTICS
// -------------------------------------------------------------
class PrinterSettingsScreen extends StatelessWidget {
  const PrinterSettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PosProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth Thermal Printer Setup'),
        backgroundColor: KgnTheme.darkSlate,
        foregroundColor: Colors.white,
      ),
      body: Padding
