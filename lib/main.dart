import React, { useState } from 'react';
import {
  StyleSheet,
  Text,
  View,
  TouchableOpacity,
  FlatList,
  ScrollView,
  SafeAreaView,
  TextInput,
  Alert,
  Modal
} from 'react-native';
// Sample Menu Data
const MENU_ITEMS = [
  { id: '1', name: 'Paneer Butter Masala', price: 240, category: 'Main Course' },
  { id: '2', name: 'Butter Naan', price: 40, category: 'Bread' },
  { id: '3', name: 'Dal Makhani', price: 180, category: 'Main Course' },
  { id: '4', name: 'Veg Biryani', price: 210, category: 'Rice' },
  { id: '5', name: 'Masala Dosa', price: 120, category: 'South Indian' },
  { id: '6', name: 'Cold Drink (500ml)', price: 50, category: 'Beverage' },
];
export default function App() {
  // States
  const [tables, setTables] = useState([
    { id: 'T1', name: 'Table 1', status: 'Available', order: [] },
    { id: 'T2', name: 'Table 2', status: 'Available', order: [] },
    { id: 'T3', name: 'Table 3', status: 'Available', order: [] },
    { id: 'T4', name: 'Table 4', status: 'Available', order: [] },
    { id: 'T5', name: 'Table 5', status: 'Available', order: [] },
    { id: 'T6', name: 'Table 6', status: 'Available', order: [] },
  ]);
  const [selectedTable, setSelectedTable] = useState(null);
  const [currentOrder, setCurrentOrder] = useState([]);
  const [discount, setDiscount] = useState('0');
  const [searchQuery, setSearchQuery] = useState('');
  const [isBillModalVisible, setIsBillModalVisible] = useState(false);
  const [completedOrders, setCompletedOrders] = useState([]);
  // Open Table Order Window
  const handleSelectTable = (table) => {
    setSelectedTable(table);
    setCurrentOrder(table.order || []);
  };
  // Add Item to Order
  const addToOrder = (item) => {
    const existing = currentOrder.find((o) => o.id === item.id);
    if (existing) {
      setCurrentOrder(
        currentOrder.map((o) =>
          o.id === item.id ? { ...o, qty: o.qty + 1 } : o
    } else {
      setCurrentOrder([...currentOrder, { ...item, qty: 1 }]);
  // Remove / Decrease Item Quantity
  const removeFromOrder = (item) => {
    const existing = currentOrder.find((o) => o.id === item.id);
    if (existing.qty === 1) {
      setCurrentOrder(currentOrder.filter((o) => o.id !== item.id));
    } else {
      setCurrentOrder(
        currentOrder.map((o) =>
          o.id === item.id ? { ...o, qty: o.qty - 1 } : o
  // Send Order to Kitchen (KOT)
  const sendKOT = () => {
    if (currentOrder.length === 0) {
      Alert.alert('Khali Order', 'KOT bhejne ke liye kam se kam 1 item add karein.');
      return;
    const updatedTables = tables.map((t) =>
      t.id === selectedTable.id
        ? { ...t, status: 'Occupied', order: currentOrder }
        : t
    );
    setTables(updatedTables);
    Alert.alert('KOT Sent!', `${selectedTable.name} ka KOT Kitchen me bhej diya gaya hai.`);
  // Calculate Totals
  const subTotal = currentOrder.reduce((sum, item) => sum + item.price * item.qty, 0);
  const gst = Math.round(subTotal * 0.05); // 5% GST
  const discountVal = parseFloat(discount) || 0;
  const grandTotal = Math.max(0, subTotal + gst - discountVal);

  // Finalize & Clear Bill
  const completePayment = (paymentMethod) => {
    const newBill = {
      id: Date.now().toString(),
      tableName: selectedTable.name,
      items: currentOrder,
      total: grandTotal,
      method: paymentMethod,
      time: new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }),
    };

    setCompletedOrders([newBill, ...completedOrders]);

    // Reset Table State
    const updatedTables = tables.map((t) =>
      t.id === selectedTable.id ? { ...t, status: 'Available', order: [] } : t
    );
    setTables(updatedTables);
    setIsBillModalVisible(false);
    setSelectedTable(null);
    setCurrentOrder([]);
    setDiscount('0');
Alert.alert('Success', `Bill Complete ho gaya! Payment Method: ${paymentMethod}`);
  // Filter Menu Items by Search
  const filteredMenu = MENU_ITEMS.filter((item) =>
    item.name.toLowerCase().includes(searchQuery.toLowerCase())
  return
    <SafeAreaView style={styles.container}>
      {/* HEADER */}
      <View style={styles.header}>
        <Text style={styles.headerTitle}>🍽️ Restaurant POS & Billing</Text>
      </View>
{!selectedTable ?
        /* TABLE SELECTION SCREEN */
        <View style={styles.content}>
          <Text style={styles.sectionTitle}>Select a Table</Text>
          <FlatList
            data={tables}
            numColumns={2}
            keyExtractor={(item) => item.id}
            renderItem={({ item }) => (
              <TouchableOpacity
                style={[
                  styles.tableCard,
                  item.status === 'Occupied' ? styles.tableOccupied : styles.tableAvailable,
                onPress={() => handleSelectTable(item)}
                <Text style={styles.tableName}>{item.name}</Text>
                <Text style={styles.tableStatus}>{item.status}</Text>
                {item.order.length > 0 && (
                  <Text style={styles.itemCount}>
                    {item.order.reduce((a, b) => a + b.qty, 0)} Items
                  </Text>
              </TouchableOpacity>
        </View>
      /* ORDERING & BILLING SCREEN */
        <View style={styles.orderContainer}>
          {/* Top Bar */}
          <View style={styles.topBar}>
            <TouchableOpacity onPress={() => setSelectedTable(null)} style={styles.backBtn}>
              <Text style={styles.backBtnText}>← Back</Text>
            </TouchableOpacity>
            <Text style={styles.selectedTableTitle}>{selectedTable.name}</Text>
          </View>
          <View style={styles.mainWorkArea}>
            {/* Left/Top: Menu Selection */}
            <View style={styles.menuSection}>
              <TextInput
                style={styles.searchInput}
                placeholder="Search Food Item..."
                value={searchQuery}
                onChangeText={setSearchQuery}
              <FlatList
                data={filteredMenu}
                keyExtractor={(item) => item.id}
                renderItem={({ item }) => (
                  <TouchableOpacity style={styles.menuItem} onPress={() => addToOrder(item)}>
                    <View>
                      <Text style={styles.menuItemName}>{item.name}</Text>
                      <Text style={styles.menuItemPrice}>₹{item.price}</Text>
                    </View>
                    <Text style={styles.addBtnText}>+ ADD</Text>
                  </TouchableOpacity>
            </View>
{/* Right/Bottom: Order Summary */}
            <View style={styles.cartSection}>
              <Text style={styles.cartTitle}>Current Order</Text>
              <ScrollView style={styles.cartList}>
                {currentOrder.length === 0 ? 
                  <Text style={styles.emptyText}>Koi item add nahi kiya hai</Text>(
                  currentOrder.map((item) =>
                    <View key={item.id} style={styles.cartItem}>
                      <View style={{ flex: 1 }}>
                        <Text style={styles.cartItemName}>{item.name}</Text>
                        <Text style={styles.cartItemPrice}>₹{item.price * item.qty}</Text>
                      </View>
                      <View style={styles.qtyContainer}>
                        <TouchableOpacity onPress={() => removeFromOrder(item)} style={styles.qtyBtn}>
                          <Text style={styles.qtyBtnText}>-</Text>
                        </TouchableOpacity>
                        <Text style={styles.qtyText}>{item.qty}</Text>
                        <TouchableOpacity onPress={() => addToOrder(item)} style={styles.qtyBtn}>
                          <Text style={styles.qtyBtnText}>+</Text>
                        </TouchableOpacity>
                      </View>
                    </View>
              </ScrollView>
        {/* Action Buttons */}
              <View style={styles.actionRow}>
                <TouchableOpacity style={styles.kotBtn} onPress={sendKOT}>
                  <Text style={styles.btnText}>Print KOT</Text>
                </TouchableOpacity>
                <TouchableOpacity
                  style={[styles.billBtn, currentOrder.length === 0 && { backgroundColor: '#ccc' }]}
                  disabled={currentOrder.length === 0}
                  onPress={() => setIsBillModalVisible(true)}
                <Text style={styles.btnText}>Generate Bill</Text>
                </TouchableOpacity>
              </View>
            </View>
          </View>
        </View>
      {/* FINAL BILL MODAL */}
      <Modal visible={isBillModalVisible} animationType="slide" transparent={true}>
        <View style={styles.modalOverlay}>
          <View style={styles.modalContent}>
            <Text style={styles.modalTitle}>🧾 Final Invoice</Text>
              <View style={styles.billDetailRow}>
              <Text style={styles.billText}>Subtotal:</Text>
              <Text style={styles.billText}>₹{subTotal}</Text>
            </View>
            <View style={styles.billDetailRow}>
              <Text style={styles.billText}>GST (5%):</Text>
              <Text style={styles.billText}>₹{gst}</Text>
            </View>
              <View style={styles.discountRow}>
              <Text style={styles.billText}>Discount (₹):</Text>
              <TextInput
                style={styles.discountInput}
                keyboardType="numeric"
                value={discount}
                onChangeText={setDiscount
            </View>
              <View style={[styles.billDetailRow, styles.totalRow]}>
              <Text style={styles.totalText}>Grand Total:</Text>
              <Text style={styles.totalText}>₹{grandTotal}</Text>
            </View>
            <Text style={styles.payMethodTitle}>Select Payment Method:</Text>
            <View style={styles.payBtnGroup}>
              <TouchableOpacity style={styles.payBtn} onPress={() => completePayment('Cash')}>
                <Text style={styles.payBtnText}>💵 Cash</Text>
              </TouchableOpacity>
              <TouchableOpacity style={styles.payBtn} onPress={() => completePayment('UPI / QR')}>
                <Text style={styles.payBtnText}>📱 UPI</Text>
              </TouchableOpacity>
              <TouchableOpacity style={styles.payBtn} onPress={() => completePayment('Card')}>
                <Text style={styles.payBtnText}>💳 Card</Text>
              </TouchableOpacity>
            </View>
            <TouchableOpacity
              style={styles.closeModalBtn}
              onPress={() => setIsBillModalVisible(false)}
              <Text style={{ color: 'red', fontWeight: 'bold' }}>Cancel</Text>
            </TouchableOpacity>
          </View>
        </View>
      </Modal>
    </SafeAreaView>
// STYLES
const styles = StyleSheet.create({
  container: { flex: 1, backgroundColor: '#f4f6f8' },
  header: { backgroundColor: '#1e293b', padding: 16, alignItems: 'center' },
  headerTitle: { color: '#fff', fontSize: 20, fontWeight: 'bold' },
  content: { padding: 16, flex: 1 },
  sectionTitle: { fontSize: 18, fontWeight: 'bold', marginBottom: 12, color: '#333' },
  tableCard: {
    flex: 1,
    margin: 8,
    height: 110,
    borderRadius: 12,
    padding: 12,
    justifyContent: 'center',
    alignItems: 'center',
    elevation: 3,},
  tableAvailable: { backgroundColor: '#e2f5ea', borderColor: '#2ecc71', borderWidth: 1.5 },
  tableOccupied: { backgroundColor: '#fde8e8', borderColor: '#e74c3c', borderWidth: 1.5 },
  tableName: { fontSize: 18, fontWeight: 'bold', color: '#2c3e50' },
  tableStatus: { fontSize: 14, color: '#7f8c8d', marginTop: 4 },
  itemCount: { fontSize: 12, color: '#e74c3c', fontWeight: 'bold', marginTop: 4 },
  orderContainer: { flex: 1 },
  topBar: {
    flexDirection: 'row',
    alignItems: 'center',
    padding: 12,
    backgroundColor: '#fff',
    borderBottomWidth: 1,
    borderBottomColor: '#ddd',},
  backBtn: { padding: 8 },
  backBtnText: { color: '#007AFF', fontSize: 16, fontWeight: 'bold' },
  selectedTableTitle: { fontSize: 18, fontWeight: 'bold', marginLeft: 16 },
  mainWorkArea: { flex: 1, flexDirection: 'column' },
  menuSection: { flex: 1, padding: 12, backgroundColor: '#fff' },
  searchInput: {
    backgroundColor: '#f1f5f9',
    padding: 10,
    borderRadius: 8,
    marginBottom: 10,
    fontSize: 15,},
  menuItem: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    paddingVertical: 12,
    borderBottomWidth: 1,
    borderBottomColor: '#f1f1f1',},
  menuItemName: { fontSize: 16, fontWeight: '600', color: '#333' },
  menuItemPrice: { fontSize: 14, color: '#666', marginTop: 2 },
  addBtnText: { color: '#27ae60', fontWeight: 'bold', fontSize: 14 },
  cartSection: { flex: 1, padding: 12, backgroundColor: '#f8fafc', borderTopWidth: 1, borderColor: '#e2e8f0' },
  cartTitle: { fontSize: 16, fontWeight: 'bold', marginBottom: 8 },
  cartList: { flex: 1 },
  emptyText: { textAlign: 'center', color: '#94a3b8', marginTop: 20 },
  cartItem: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    backgroundColor: '#fff',
    padding: 10,
    borderRadius: 8,
    marginBottom: 6,},
  cartItemName: { fontSize: 14, fontWeight: '600' },
  cartItemPrice: { fontSize: 12, color: '#64748b' },
  qtyContainer: { flexDirection: 'row', alignItems: 'center' },
  qtyBtn: { backgroundColor: '#e2e8f0', width: 28, height: 28, borderRadius: 14, justifyContent: 'center', alignItems: 'center' },
  qtyBtnText: { fontSize: 16, fontWeight: 'bold' },
  qtyText: { marginHorizontal: 10, fontWeight: 'bold' },
  actionRow: { flexDirection: 'row', marginTop: 10, gap: 10 },
  kotBtn: { flex: 1, backgroundColor: '#f39c12', padding: 12, borderRadius: 8, alignItems: 'center' },
  billBtn: { flex: 1, backgroundColor: '#27ae60', padding: 12, borderRadius: 8, alignItems: 'center' },
  btnText: { color: '#fff', fontWeight: 'bold', fontSize: 15 },modalOverlay: { flex: 1, backgroundColor: 'rgba(0,0,0,0.5)', justifyContent: 'center', padding: 20 },
  modalContent: { backgroundColor: '#fff', padding: 20, borderRadius: 12 },
  modalTitle: { fontSize: 20, fontWeight: 'bold', marginBottom: 16, textAlign: 'center' },
  billDetailRow: { flexDirection: 'row', justifyContent: 'space-between', marginVertical: 6 },
  billText: { fontSize: 16, color: '#475569' },
  discountRow: { flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center', marginVertical: 6 },
  discountInput: { borderWidth: 1, borderColor: '#cbd5e1', width: 80, padding: 4, borderRadius: 6, textAlign: 'right' },
  totalRow: { borderTopWidth: 1, borderColor: '#e2e8f0', paddingTop: 10, marginTop: 10 },
  totalText: { fontSize: 18, fontWeight: 'bold', color: '#0f172a' },
  payMethodTitle: { marginTop: 16, fontWeight: '600', marginBottom: 8 },
  payBtnGroup: { flexDirection: 'row', justifyContent: 'space-between', gap: 8 },
  payBtn: { flex: 1, backgroundColor: '#f1f5f9', padding: 10, borderRadius: 6, alignItems: 'center', borderWidth: 1, borderColor: '#cbd5e1' },
  payBtnText: { fontWeight: '600', fontSize: 13 },
  closeModalBtn: { marginTop: 16, alignItems: 'center' }
