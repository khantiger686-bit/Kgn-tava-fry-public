```react
import React, { useState, useEffect, useMemo } from 'react';
import { 
  Users, Utensils, Clock, CheckCircle2, AlertCircle, ShoppingBag, 
  CreditCard, DollarSign, Sparkles, Plus, Minus, Trash2, Search, 
  Send, ChefHat, Bell, Receipt, Grid, ArrowLeft, ChevronRight, 
  Check, Split, RefreshCw, X, ShieldAlert, Award, Coffee, Flame, 
  Layers, Edit3, Circle, Filter
} from 'lucide-react';

const SECTIONS = ['All', 'Main Dining', 'Patio', 'Bar', 'VIP Area'];

const INITIAL_TABLES = [
  { id: 'T1', name: 'Table 1', section: 'Main Dining', capacity: 4, status: 'occupied', guests: 3, timeSeated: '35m ago', server: 'John D.', orderId: 'ORD-101' },
  { id: 'T2', name: 'Table 2', section: 'Main Dining', capacity: 2, status: 'available', guests: 0, timeSeated: '-', server: '-', orderId: null },
  { id: 'T3', name: 'Table 3', section: 'Main Dining', capacity: 6, status: 'bill_requested', guests: 5, timeSeated: '1h 10m ago', server: 'John D.', orderId: 'ORD-098' },
  { id: 'T4', name: 'Table 4', section: 'Main Dining', capacity: 4, status: 'reserved', guests: 0, timeSeated: '-', server: 'Assigned (19:30)', orderId: null },
  { id: 'P1', name: 'Patio 1', section: 'Patio', capacity: 2, status: 'occupied', guests: 2, timeSeated: '15m ago', server: 'John D.', orderId: 'ORD-104' },
  { id: 'P2', name: 'Patio 2', section: 'Patio', capacity: 4, status: 'available', guests: 0, timeSeated: '-', server: '-', orderId: null },
  { id: 'B1', name: 'Bar 1', section: 'Bar', capacity: 1, status: 'occupied', guests: 1, timeSeated: '45m ago', server: 'John D.', orderId: 'ORD-102' },
  { id: 'B2', name: 'Bar 2', section: 'Bar', capacity: 1, status: 'available', guests: 0, timeSeated: '-', server: '-', orderId: null },
  { id: 'V1', name: 'VIP Booth', section: 'VIP Area', capacity: 8, status: 'occupied', guests: 7, timeSeated: '50m ago', server: 'John D.', orderId: 'ORD-099' },
];

const MENU_CATEGORIES = ['Appetizers', 'Mains', 'Steaks & Grills', 'Desserts', 'Drinks', 'Specials'];

const MENU_ITEMS = [
  { id: 'm1', name: 'Crispy Calamari', price: 14.50, category: 'Appetizers', prepTime: '10m', image: '🦑', popular: true, description: 'Lightly battered with spicy garlic aioli & lemon' },
  { id: 'm2', name: 'Truffle Mushroom Arancini', price: 12.00, category: 'Appetizers', prepTime: '12m', image: '🧆', description: 'Arborio rice balls, smoked mozzarella, truffle emulsion' },
  { id: 'm3', name: 'Artisan Caesar Salad', price: 11.50, category: 'Appetizers', prepTime: '8m', image: '🥗', description: 'Crisp romaine, sourdough croutons, shaved parmesan' },
  { id: 'm4', name: 'Prime Ribeye Steak 12oz', price: 38.00, category: 'Steaks & Grills', prepTime: '20m', image: '🥩', popular: true, description: 'USDA Prime, garlic herb butter, roasted asparagus' },
  { id: 'm5', name: 'Grilled Atlantic Salmon', price: 28.50, category: 'Mains', prepTime: '18m', image: '🐟', description: 'Lemon dill reduction, wild rice pilaf, charred zucchini' },
  { id: 'm6', name: 'Truffle Wild Mushroom Pasta', price: 24.00, category: 'Mains', prepTime: '15m', image: '🍝', description: 'Handmade fettuccine, cream sauce, fresh parmesan' },
  { id: 'm7', name: 'Smoked Bacon Wagyu Burger', price: 21.00, category: 'Mains', prepTime: '15m', image: '🍔', popular: true, description: 'Brioche bun, aged cheddar, caramelized onion, truffle fries' },
  { id: 'm8', name: 'Molten Lava Chocolate Cake', price: 10.50, category: 'Desserts', prepTime: '10m', image: '🌋', popular: true, description: 'Warm fudge center, Madagascar vanilla ice cream' },
  { id: 'm9', name: 'New York Cheesecake', price: 9.50, category: 'Desserts', prepTime: '5m', image: '🍰', description: 'Classic baked cheesecake with wild berry compote' },
  { id: 'm10', name: 'Craft IPA Beer', price: 7.50, category: 'Drinks', prepTime: '2m', image: '🍺', description: 'Local brewery citrus notes 6.8% ABV' },
  { id: 'm11', name: 'Signature Espresso Martini', price: 14.00, category: 'Drinks', prepTime: '4m', image: '🍸', popular: true, description: 'Vodka, fresh espresso, Kahlúa, vanilla bean' },
  { id: 'm12', name: 'Fresh Lemonade', price: 4.50, category: 'Drinks', prepTime: '3m', image: '🍋', description: 'Freshly squeezed lemons with mint syrup' },
  { id: 'm13', name: 'Chef Special Caviar Toast', price: 42.00, category: 'Specials', prepTime: '10m', image: '🥂', description: 'Brioche toast, creme fraiche, Ossetra caviar' },
];

const MODIFIER_OPTIONS = {
  cookingTemp: ['Rare', 'Medium Rare', 'Medium', 'Medium Well', 'Well Done'],
  addons: [
    { name: 'Extra Cheese', price: 2.00 },
    { name: 'Add Truffle Oil', price: 3.50 },
    { name: 'Sub Gluten-Free', price: 1.50 },
    { name: 'Add Grilled Shrimp', price: 7.00 },
  ],
  dietaryNotes: ['No Onions', 'No Nuts', 'Dressing on Side', 'Extra Spicy', 'Mild Sauce']
};

const INITIAL_ORDERS = {
  'ORD-101': {
    orderId: 'ORD-101',
    tableId: 'T1',
    timeStarted: '18:45',
    items: [
      { cartItemId: 'c1', id: 'm1', name: 'Crispy Calamari', price: 14.50, qty: 1, seat: 1, temp: '', notes: 'Extra lemon', status: 'Delivered' },
      { cartItemId: 'c2', id: 'm4', name: 'Prime Ribeye Steak 12oz', price: 38.00, qty: 2, seat: 2, temp: 'Medium Rare', notes: 'Butter on side', status: 'Cooking' },
      { cartItemId: 'c3', id: 'm10', name: 'Craft IPA Beer', price: 7.50, qty: 2, seat: 1, temp: '', notes: '', status: 'Delivered' }
    ]
  },
  'ORD-104': {
    orderId: 'ORD-104',
    tableId: 'P1',
    timeStarted: '19:10',
    items: [
      { cartItemId: 'c4', id: 'm7', name: 'Smoked Bacon Wagyu Burger', price: 21.00, qty: 1, seat: 1, temp: 'Medium', notes: 'No pickle', status: 'Ready' },
      { cartItemId: 'c5', id: 'm12', name: 'Fresh Lemonade', price: 4.50, qty: 2, seat: 2, temp: '', notes: 'Less ice', status: 'Delivered' }
    ]
  },
  'ORD-098': {
    orderId: 'ORD-098',
    tableId: 'T3',
    timeStarted: '18:15',
    items: [
      { cartItemId: 'c6', id: 'm4', name: 'Prime Ribeye Steak 12oz', price: 38.00, qty: 3, seat: 1, temp: 'Medium', notes: '', status: 'Delivered' },
      { cartItemId: 'c7', id: 'm5', name: 'Grilled Atlantic Salmon', price: 28.50, qty: 2, seat: 2, temp: '', notes: '', status: 'Delivered' },
      { cartItemId: 'c8', id: 'm8', name: 'Molten Lava Chocolate Cake', price: 10.50, qty: 3, seat: 3, temp: '', notes: 'Extra ice cream', status: 'Delivered' }
    ]
  },
  'ORD-102': {
    orderId: 'ORD-102',
    tableId: 'B1',
    timeStarted: '18:35',
    items: [
      { cartItemId: 'c9', id: 'm11', name: 'Signature Espresso Martini', price: 14.00, qty: 2, seat: 1, temp: '', notes: 'Strong espresso', status: 'Delivered' },
      { cartItemId: 'c10', id: 'm2', name: 'Truffle Mushroom Arancini', price: 12.00, qty: 1, seat: 1, temp: '', notes: '', status: 'Sent to Kitchen' }
    ]
  },
  'ORD-099': {
    orderId: 'ORD-099',
    tableId: 'V1',
    timeStarted: '18:25',
    items: [
      { cartItemId: 'c11', id: 'm13', name: 'Chef Special Caviar Toast', price: 42.00, qty: 2, seat: 1, temp: '', notes: '', status: 'Delivered' },
      { cartItemId: 'c12', id: 'm4', name: 'Prime Ribeye Steak 12oz', price: 38.00, qty: 4, seat: 2, temp: 'Medium Rare', notes: '', status: 'Cooking' },
      { cartItemId: 'c13', id: 'm11', name: 'Signature Espresso Martini', price: 14.00, qty: 5, seat: 3, temp: '', notes: '', status: 'Delivered' }
    ]
  }
};

export default function App() {
  // Navigation & View State
  const [activeTab, setActiveTab] = useState('tables'); // 'tables', 'pos', 'pipeline', 'checkout', 'dashboard'
  const [selectedSection, setSelectedSection] = useState('All');
  const [selectedTableId, setSelectedTableId] = useState('T1');
  
  // Data State
  const [tables, setTables] = useState(INITIAL_TABLES);
  const [orders, setOrders] = useState(INITIAL_ORDERS);
  const [notifications, setNotifications] = useState([
    { id: 1, text: 'Kitchen Alert: Table 1 Steak is Ready!', time: '2m ago', type: 'ready' },
    { id: 2, text: 'Call Bell: Table 3 requested the bill', time: '5m ago', type: 'bill' }
  ]);

  // Current Order Builder State (Cart)
  const [currentCart, setCurrentCart] = useState([]);
  const [selectedCategory, setSelectedCategory] = useState('Appetizers');
  const [searchQuery, setSearchQuery] = useState('');
  const [activeSeat, setActiveSeat] = useState(1);

  // Item Customization Modal State
  const [modifyingItem, setModifyingItem] = useState(null);
  const [selectedTemp, setSelectedTemp] = useState('');
  const [selectedAddons, setSelectedAddons] = useState([]);
  const [customNote, setCustomNote] = useState('');

  // Checkout State
  const [splitMethod, setSplitMethod] = useState('equal'); // 'equal', 'seat', 'item'
  const [splitCount, setSplitCount] = useState(2);
  const [tipPercentage, setTipPercentage] = useState(15);
  const [customTip, setCustomTip] = useState('');
  const [paymentSuccess, setPaymentSuccess] = useState(false);

  // Active Selected Table Object
  const currentTable = useMemo(() => {
    return tables.find(t => t.id === selectedTableId) || tables[0];
  }, [tables, selectedTableId]);

  // Sync Current Cart when switching active table
  useEffect(() => {
    if (currentTable && currentTable.orderId && orders[currentTable.orderId]) {
      setCurrentCart(orders[currentTable.orderId].items || []);
    } else {
      setCurrentCart([]);
    }
  }, [selectedTableId, orders, currentTable]);

  // Table Status Color Map
  const getStatusBadge = (status) => {
    switch (status) {
      case 'available':
        return { bg: 'bg-emerald-500/10 text-emerald-400 border-emerald-500/30', label: 'Available', dot: 'bg-emerald-500' };
      case 'occupied':
        return { bg: 'bg-rose-500/10 text-rose-400 border-rose-500/30', label: 'Occupied', dot: 'bg-rose-500' };
      case 'reserved':
        return { bg: 'bg-amber-500/10 text-amber-400 border-amber-500/30', label: 'Reserved', dot: 'bg-amber-500' };
      case 'bill_requested':
        return { bg: 'bg-purple-500/10 text-purple-400 border-purple-500/30', label: 'Bill Requested', dot: 'bg-purple-500' };
      default:
        return { bg: 'bg-slate-500/10 text-slate-400 border-slate-500/30', label: 'Unknown', dot: 'bg-slate-500' };
    }
  };

  // Add Item to POS Cart
  const handleAddToCart = (menuItem) => {
    // Open customization modal if steak or has options
    if (menuItem.category === 'Steaks & Grills' || menuItem.category === 'Mains') {
      setModifyingItem({ ...menuItem, seat: activeSeat });
      setSelectedTemp('Medium');
      setSelectedAddons([]);
      setCustomNote('');
      return;
    }

    const newItem = {
      cartItemId: 'item-' + Date.now(),
      id: menuItem.id,
      name: menuItem.name,
      price: menuItem.price,
      qty: 1,
      seat: activeSeat,
      temp: '',
      addons: [],
      notes: '',
      status: 'Sent to Kitchen'
    };

    const updated = [...currentCart, newItem];
    setCurrentCart(updated);
    saveOrderForTable(updated);
  };

  // Confirm Customization Modal
  const handleSaveCustomizedItem = () => {
    if (!modifyingItem) return;

    let extraPrice = 0;
    selectedAddons.forEach(a => extraPrice += a.price);

    const newItem = {
      cartItemId: 'item-' + Date.now(),
      id: modifyingItem.id,
      name: modifyingItem.name,
      price: modifyingItem.price + extraPrice,
      qty: 1,
      seat: activeSeat,
      temp: selectedTemp,
      addons: selectedAddons.map(a => a.name),
      notes: customNote,
      status: 'Sent to Kitchen'
    };

    const updated = [...currentCart, newItem];
    setCurrentCart(updated);
    saveOrderForTable(updated);
    setModifyingItem(null);
  };

  // Save Cart Changes to main state
  const saveOrderForTable = (updatedCart) => {
    let orderId = currentTable.orderId;
    
    if (!orderId) {
      orderId = 'ORD-' + Math.floor(100 + Math.random() * 900);
      // Update Table Status to occupied if not already
      setTables(prev => prev.map(t => {
        if (t.id === currentTable.id) {
          return { ...t, status: 'occupied', orderId, guests: t.guests || 2, timeSeated: 'Just now', server: 'John D.' };
        }
        return t;
      }));
    }

    setOrders(prev => ({
      ...prev,
      [orderId]: {
        orderId,
        tableId: currentTable.id,
        timeStarted: prev[orderId]?.timeStarted || new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' }),
        items: updatedCart
      }
    }));
  };

  // Modify Quantity in Cart
  const handleUpdateQty = (cartItemId, delta) => {
    const updated = currentCart.map(item => {
      if (item.cartItemId === cartItemId) {
        const newQty = item.qty + delta;
        return newQty > 0 ? { ...item, qty: newQty } : null;
      }
      return item;
    }).filter(Boolean);

    setCurrentCart(updated);
    saveOrderForTable(updated);
  };

  // Change Item Status in Kitchen Pipeline
  const handleItemStatusChange = (orderId, cartItemId, newStatus) => {
    setOrders(prev => {
      const order = prev[orderId];
      if (!order) return prev;

      const updatedItems = order.items.map(item => {
        if (item.cartItemId === cartItemId) {
          return { ...item, status: newStatus };
        }
        return item;
      });

      return {
        ...prev,
        [orderId]: { ...order, items: updatedItems }
      };
    });
  };

  // Seat/Unseat Table Action
  const handleToggleTableOccupancy = (table) => {
    if (table.status === 'available' || table.status === 'reserved') {
      const newOrderId = 'ORD-' + Math.floor(100 + Math.random() * 900);
      setTables(prev => prev.map(t => t.id === table.id ? {
        ...t, status: 'occupied', guests: 2, timeSeated: 'Just now', server: 'John D.', orderId: newOrderId
      } : t));
      setOrders(prev => ({
        ...prev,
        [newOrderId]: { orderId: newOrderId, tableId: table.id, timeStarted: 'Just now', items: [] }
      }));
    } else {
      // Clear Table / Checkout Reset
      setTables(prev => prev.map(t => t.id === table.id ? {
        ...t, status: 'available', guests: 0, timeSeated: '-', server: '-', orderId: null
      } : t));
    }
  };

  // Calculation Helpers
  const subtotal = currentCart.reduce((acc, i) => acc + (i.price * i.qty), 0);
  const tax = subtotal * 0.08; // 8% Tax
  const tipAmount = customTip ? parseFloat(customTip) || 0 : (subtotal * tipPercentage) / 100;
  const grandTotal = subtotal + tax + tipAmount;

  // Filtered Tables
  const filteredTables = tables.filter(t => {
    if (selectedSection !== 'All' && t.section !== selectedSection) return false;
    return true;
  });

  // Filtered Menu Items
  const filteredMenu = MENU_ITEMS.filter(item => {
    const matchesCategory = item.category === selectedCategory;
    const matchesSearch = item.name.toLowerCase().includes(searchQuery.toLowerCase()) || 
                          item.description.toLowerCase().includes(searchQuery.toLowerCase());
    return matchesCategory && matchesSearch;
  });

  return (
    <div className="flex h-screen w-full bg-slate-950 text-slate-100 font-sans overflow-hidden select-none">
      
      {}
      <aside className="w-20 md:w-24 bg-slate-900 border-r border-slate-800 flex flex-col items-center py-4 justify-between z-20">
        <div className="flex flex-col items-center gap-6 w-full">
          {/* Logo */}
          <div className="w-12 h-12 rounded-2xl bg-gradient-to-tr from-amber-500 to-amber-300 flex items-center justify-center text-slate-950 font-black shadow-lg shadow-amber-500/20">
            <Utensils className="w-6 h-6" />
          </div>

          {/* Nav Items */}
          <nav className="flex flex-col gap-3 w-full px-2">
            <button
              onClick={() => setActiveTab('tables')}
              className={`flex flex-col items-center justify-center py-3 px-2 rounded-xl text-xs font-medium transition-all ${
                activeTab === 'tables' 
                  ? 'bg-amber-500 text-slate-950 font-bold shadow-md shadow-amber-500/20' 
                  : 'text-slate-400 hover:bg-slate-800 hover:text-slate-200'
              }`}
            >
              <Grid className="w-5 h-5 mb-1" />
              Tables
            </button>

            <button
              onClick={() => setActiveTab('pos')}
              className={`flex flex-col items-center justify-center py-3 px-2 rounded-xl text-xs font-medium transition-all relative ${
                activeTab === 'pos' 
                  ? 'bg-amber-500 text-slate-950 font-bold shadow-md shadow-amber-500/20' 
                  : 'text-slate-400 hover:bg-slate-800 hover:text-slate-200'
              }`}
            >
              <ShoppingBag className="w-5 h-5 mb-1" />
              Order POS
              {currentCart.length > 0 && (
                <span className="absolute top-2 right-2 w-2 h-2 rounded-full bg-rose-500 animate-pulse" />
              )}
            </button>

            <button
              onClick={() => setActiveTab('pipeline')}
              className={`flex flex-col items-center justify-center py-3 px-2 rounded-xl text-xs font-medium transition-all ${
                activeTab === 'pipeline' 
                  ? 'bg-amber-500 text-slate-950 font-bold shadow-md shadow-amber-500/20' 
                  : 'text-slate-400 hover:bg-slate-800 hover:text-slate-200'
              }`}
            >
              <ChefHat className="w-5 h-5 mb-1" />
              Kitchen
            </button>

            <button
              onClick={() => setActiveTab('checkout')}
              className={`flex flex-col items-center justify-center py-3 px-2 rounded-xl text-xs font-medium transition-all ${
                activeTab === 'checkout' 
                  ? 'bg-amber-500 text-slate-950 font-bold shadow-md shadow-amber-500/20' 
                  : 'text-slate-400 hover:bg-slate-800 hover:text-slate-200'
              }`}
            >
              <Receipt className="w-5 h-5 mb-1" />
              Pay/Split
            </button>

            <button
              onClick={() => setActiveTab('dashboard')}
              className={`flex flex-col items-center justify-center py-3 px-2 rounded-xl text-xs font-medium transition-all ${
                activeTab === 'dashboard' 
                  ? 'bg-amber-500 text-slate-950 font-bold shadow-md shadow-amber-500/20' 
                  : 'text-slate-400 hover:bg-slate-800 hover:text-slate-200'
              }`}
            >
              <Award className="w-5 h-5 mb-1" />
              Shift
            </button>
          </nav>
        </div>

        {/* Server Info Profile */}
        <div className="flex flex-col items-center gap-2">
          <div className="relative">
            <div className="w-10 h-10 rounded-full bg-slate-800 border border-slate-700 flex items-center justify-center font-semibold text-amber-400 text-sm">
              JD
            </div>
            <span className="absolute bottom-0 right-0 w-3 h-3 rounded-full bg-emerald-500 border-2 border-slate-900" />
          </div>
          <span className="text-[10px] text-slate-400 font-medium">John D.</span>
        </div>
      </aside>

      {/* Main Workspace Area */}
      <main className="flex-1 flex flex-col min-w-0 bg-slate-950 overflow-hidden">
        
        {/* Top Header Bar */}
        <header className="h-16 border-b border-slate-800 bg-slate-900/50 backdrop-blur px-6 flex items-center justify-between">
          <div className="flex items-center gap-4">
            <h1 className="text-xl font-bold tracking-tight text-slate-100 flex items-center gap-2">
              {activeTab === 'tables' && 'Floor Plan & Table Management'}
              {activeTab === 'pos' && `Taking Order for ${currentTable.name}`}
              {activeTab === 'pipeline' && 'Live Kitchen Orders Status'}
              {activeTab === 'checkout' && `Bill Checkout - ${currentTable.name}`}
              {activeTab === 'dashboard' && 'Waiter Shift & Performance Summary'}
            </h1>
            {selectedTableId && ac
