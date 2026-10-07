/* Tablewise — restaurant waiter app */
(() => {
const API = 'port/8000'.startsWith('__') ? 'http://localhost:8000' : 'port/8000';
const $ = (s, el = document) => el.querySelector(s);
const esc = s => String(s ?? '').replace(/[&<>"']/g, c => ({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));
const uid = () => Math.random().toString(36).slice(2, 9) + Date.now().toString(36).slice(-3);
const money = n => '₹' + (Math.round(n * 100) / 100).toLocaleString('en-IN', {minimumFractionDigits: 0, maximumFractionDigits: 2});
const ago = t => { const m = Math.floor((Date.now() - t) / 60000); return m < 1 ? 'just now' : m < 60 ? m + ' min' : Math.floor(m/60) + 'h ' + (m%60) + 'm'; };
const dayKey = t => new Date(t).toLocaleDateString('en-CA');

/* ---------- Default data ---------- */
function seed() {
  const M = (name, price, cat, veg = true) => ({id: uid(), name, price, cat, veg, avail: true});
  return {
    settings: {name: 'My Restaurant', address: 'Ahmedabad, Gujarat', gstin: '', phone: '', tables: 12, gst: 5, service: 0, waiters: ['Ravi', 'Priya', 'Arjun']},
    categories: ['Starters', 'Main Course', 'Breads', 'Rice', 'Thali', 'Beverages', 'Desserts'],
    menu: [
      M('Paneer Tikka', 260, 'Starters'), M('Hara Bhara Kebab', 210, 'Starters'), M('Veg Manchurian', 220, 'Starters'),
      M('Chilli Paneer', 250, 'Starters'), M('Chicken Tikka', 320, 'Starters', false), M('Masala Papad', 60, 'Starters'),
      M('Paneer Butter Masala', 290, 'Main Course'), M('Dal Makhani', 240, 'Main Course'), M('Kaju Curry', 300, 'Main Course'),
      M('Veg Kolhapuri', 250, 'Main Course'), M('Sev Tameta', 180, 'Main Course'), M('Butter Chicken', 360, 'Main Course', false),
      M('Butter Roti', 35, 'Breads'), M('Plain Naan', 45, 'Breads'), M('Butter Naan', 55, 'Breads'), M('Garlic Naan', 70, 'Breads'), M('Lachha Paratha', 60, 'Breads'),
      M('Jeera Rice', 160, 'Rice'), M('Veg Biryani', 240, 'Rice'), M('Dal Khichdi', 190, 'Rice'), M('Chicken Biryani', 320, 'Rice', false),
      M('Gujarati Thali', 350, 'Thali'), M('Punjabi Thali', 380, 'Thali'), M('Mini Thali', 220, 'Thali'),
      M('Masala Chaas', 50, 'Beverages'), M('Sweet Lassi', 80, 'Beverages'), M('Fresh Lime Soda', 70, 'Beverages'), M('Masala Chai', 30, 'Beverages'), M('Mineral Water', 20, 'Beverages'),
      M('Gulab Jamun', 80, 'Desserts'), M('Rasmalai', 110, 'Desserts'), M('Kesar Pista Kulfi', 100, 'Desserts'),
    ],
    orders: {}, tableOrder: {}, kots: [], kotSeq: 0, billSeq: 0,
  };
}

/* ---------- State + sync ---------- */
let S = null, version = 0, online = false, queue = Promise.resolve();
const drafts = {};            // table -> [{mid, qty, note}] (local only until sent)
const ui = {tab: 'tables', table: null, cat: 'All', q: '', salesDay: dayKey(Date.now()), menuCat: 'All'};
let waiter = null;

function setSync(on) {
  online = on;
  $('#syncDot').className = 'dot ' + (on ? 'on' : 'off');
  $('#syncText').textContent = on ? 'Synced across devices' : 'Offline — this device only';
}
async function pull() {
  const r = await fetch(API + '/api/state', {credentials: 'same-origin'});
  if (!r.ok) throw new Error('pull');
  return r.json();
}
async function push() {
  const r = await fetch(API + '/api/state', {method: 'POST', credentials: 'same-origin', headers: {'Content-Type': 'application/json'}, body: JSON.stringify({state: S})});
  if (!r.ok) throw new Error('push');
  version = (await r.json()).version;
}
// Apply a change on top of the freshest shared state, then save.
function mutate(fn) {
  queue = queue.then(async () => {
    try { const d = await pull(); if (d.state && d.version > version) { S = d.state; version = d.version; } setSync(true); } catch { setSync(false); }
    fn(S);
    render();
    try { await push(); setSync(true); } catch { setSync(false); }
  });
  return queue;
}
async function poll() {
  try {
    const d = await pull(); setSync(true);
    if (d.state && d.version > version) {
      S = d.state; version = d.version;
      const typing = document.activeElement && /INPUT|TEXTAREA|SELECT/.test(document.activeElement.tagName);
      if (!typing && $('#sheet').hidden) render(); else renderBadges();
    }
  } catch { setSync(false); }
}

/* ---------- Helpers ---------- */
const orderOf = t => S.orders[S.tableOrder[t]];
const menuItem = id => S.menu.find(m => m.id === id);
function tableStatus(t) {
  const o = orderOf(t);
  if (!o && !(drafts[t] || []).length) return 'free';
  if (!o) return 'busy';
  if (o.status === 'billing') return 'bill';
  if (o.items.some(i => i.status === 'ready')) return 'ready';
  return 'busy';
}
const statusLabel = {free: 'Free', busy: 'Occupied', ready: 'Food ready', bill: 'Bill asked'};
function calc(o) {
  const sub = o.items.reduce((a, i) => a + i.price * i.qty, 0);
  const disc = o.discType === 'pct' ? sub * (o.discount || 0) / 100 : Math.min(o.discount || 0, sub);
  const after = sub - disc;
  const svc = after * (S.settings.service || 0) / 100;
  const gst = (after + svc) * (S.settings.gst || 0) / 100;
  const raw = after + svc + gst;
  const total = Math.round(raw);
  return {sub, disc, svc, gst, round: total - raw, total};
}
function toast(msg) { const t = $('#toast'); t.textContent = msg; t.classList.add('show'); clearTimeout(toast.t); toast.t = setTimeout(() => t.classList.remove('show'), 1800); }
function sheet(html, bind) {
  const s = $('#sheet'), c = $('.sheet-card', s); c.innerHTML = html; s.hidden = false;
  s.onclick = e => { if (e.target === s) closeSheet(); };
  bind && bind(c);
  const f = c.querySelector('input,select,textarea'); f && setTimeout(() => f.focus(), 50);
}
function closeSheet() { $('#sheet').hidden = true; render(); }
function confirmBox(msg, ok, label = 'Yes, continue') {
  sheet(`<h2>${esc(msg)}</h2><div class="row" style="margin-top:18px"><button class="btn" data-x>Cancel</button><button class="btn primary" data-ok>${esc(label)}</button></div>`, c => {
    $('[data-x]', c).onclick = closeSheet; $('[data-ok]', c).onclick = () => { $('#sheet').hidden = true; ok(); };
  });
}
const vegDot = v => `<span class="veg ${v ? '' : 'nv'}" title="${v ? 'Veg' : 'Non-veg'}"></span>`;

/* ---------- Render ---------- */
function renderBadges() {
  $('#restName').textContent = S.settings.name || 'Tablewise';
  const n = S.kots.filter(k => !k.done).length, b = $('#kBadge');
  b.hidden = !n; b.textContent = n;
  const sel = $('#waiterSel'), ws = S.settings.waiters.length ? S.settings.waiters : ['Waiter'];
  if (!waiter || !ws.includes(waiter)) waiter = ws[0];
  sel.innerHTML = ws.map(w => `<option ${w === waiter ? 'selected' : ''}>${esc(w)}</option>`).join('');
}
function render() {
  if (!S) return;
  renderBadges();
  document.querySelectorAll('.tabbar button').forEach(b => b.classList.toggle('active', b.dataset.tab === ui.tab));
  const v = $('#view');
  if (ui.tab === 'tables') v.innerHTML = ui.table ? viewOrder(ui.table) : viewTables();
  else if (ui.tab === 'kitchen') v.innerHTML = viewKitchen();
  else if (ui.tab === 'menu') v.innerHTML = viewMenu();
  else if (ui.tab === 'sales') v.innerHTML = viewSales();
  else v.innerHTML = viewSettings();
}

function viewTables() {
  const counts = {free: 0, busy: 0, ready: 0, bill: 0};
  const cards = Array.from({length: S.settings.tables}, (_, i) => {
    const t = i + 1, st = tableStatus(t); counts[st]++;
    const o = orderOf(t);
    const amt = o ? calc(o).total : 0;
    return `<button class="tcard ${st}" data-table="${t}">
      <div class="tn">T${t}</div><span class="st">${statusLabel[st]}</span>
      <div class="meta">${o ? `<span>${esc(o.waiter)} · ${ago(o.openedAt)}</span><b>${money(amt)}</b>` : (drafts[t]?.length ? '<span>Draft order</span>' : '<span>Tap to seat</span>')}</div>
    </button>`;
  }).join('');
  return `<div class="h-row"><h1>Tables</h1><span class="muted small">${counts.free} free of ${S.settings.tables}</span></div>
    <div class="legend"><span><i style="background:var(--free)"></i>Free ${counts.free}</span><span><i style="background:var(--busy)"></i>Occupied ${counts.busy}</span><span><i style="background:var(--ready)"></i>Food ready ${counts.ready}</span><span><i style="background:var(--bill)"></i>Bill asked ${counts.bill}</span></div>
    <div class="grid">${cards}</div>`;
}

function viewOrder(t) {
  const o = orderOf(t), d = drafts[t] || [];
  const cats = ['All', ...S.categories];
  const q = ui.q.trim().toLowerCase();
  const items = S.menu.filter(m => (ui.cat === 'All' || m.cat === ui.cat) && (!q || m.name.toLowerCase().includes(q)));
  const dq = id => d.filter(x => x.mid === id).reduce((a, x) => a + x.qty, 0);
  const menuHtml = items.length ? items.map(m => {
    const n = dq(m.id);
    return `<button class="mitem ${m.avail ? '' : 'off'}" data-add="${m.id}" ${m.avail ? '' : 'disabled'}>${vegDot(m.veg)}<div><div class="nm">${esc(m.name)}</div><div class="pr">${m.avail ? money(m.price) : 'Not available'}</div></div>${n ? `<span class="qn">${n}</span>` : '<span class="add">+</span>'}</button>`;
  }).join('') : `<div class="empty">No dishes match “${esc(ui.q)}”.</div>`;

  const sent = o ? o.items : [];
  const tagFor = s => ({kitchen: '<span class="tag kit">In kitchen</span>', ready: '<span class="tag rdy">Ready</span>', served: '<span class="tag srv">Served</span>'}[s] || '');
  const lines = [
    ...d.map((x, idx) => { const m = menuItem(x.mid); if (!m) return ''; return `<div class="line"><div class="ln"><div class="n">${esc(m.name)}<span class="tag new">New</span></div>${x.note ? `<div class="x">“${esc(x.note)}”</div>` : ''}<button class="x" data-note="${idx}" style="text-decoration:underline">${x.note ? 'Edit note' : 'Add note'}</button></div><div class="qty"><button data-dq="${idx}" data-d="-1" aria-label="Less">−</button><span>${x.qty}</span><button data-dq="${idx}" data-d="1" aria-label="More">+</button></div><div class="amt">${money(m.price * x.qty)}</div></div>`; }),
    ...sent.map(i => `<div class="line"><div class="ln"><div class="n">${esc(i.name)}${tagFor(i.status)}</div>${i.note ? `<div class="x">“${esc(i.note)}”</div>` : ''}</div><span class="muted" style="font-weight:600">×${i.qty}</span><div class="amt">${money(i.price * i.qty)}</div>${o.status !== 'paid' ? `<button class="btn ghost sm" data-void="${i.lid}" aria-label="Remove item">✕</button>` : ''}</div>`),
  ].join('');
  const c = o ? calc(o) : null;
  const draftTotal = d.reduce((a, x) => a + (menuItem(x.mid)?.price || 0) * x.qty, 0);
  const readyCount = sent.filter(i => i.status === 'ready').length;

  return `<button class="back" data-back>‹ All tables</button>
  <div class="h-row"><h1>Table ${t}</h1><div class="row" style="flex:none">${o ? `<button class="btn sm" data-guests>${o.guests || 1} guest${(o.guests || 1) > 1 ? 's' : ''}</button><button class="btn sm" data-move>Move table</button>` : ''}</div></div>
  <div class="order-layout">
    <section>
      <div class="chips">${cats.map(c => `<button class="chip ${c === ui.cat ? 'on' : ''}" data-cat="${esc(c)}">${esc(c)}</button>`).join('')}</div>
      <input class="search" id="q" placeholder="Search dishes…" value="${esc(ui.q)}" autocomplete="off">
      <div class="menu-list">${menuHtml}</div>
    </section>
    <aside class="ticket">
      <div class="ticket-h"><div><h2>Order ${o ? '#' + o.id.slice(0, 4).toUpperCase() : ''}</h2><div class="small muted">${o ? `${esc(o.waiter)} · opened ${ago(o.openedAt)} ago` : 'New order'}</div></div>${readyCount ? `<button class="btn sm primary" data-served>Mark ${readyCount} served</button>` : ''}</div>
      <div class="ticket-b">${lines || `<div class="empty"><svg viewBox="0 0 24 24"><path d="M6 3h12v18l-3-2-3 2-3-2-3 2z"/><path d="M9 8h6M9 12h6"/></svg><div>Tap dishes on the menu to add them.</div></div>`}</div>
      <div class="ticket-f">
        ${d.length ? `<button class="btn primary block" data-send>Send ${d.reduce((a, x) => a + x.qty, 0)} item(s) to kitchen · ${money(draftTotal)}</button>` : ''}
        ${c ? `<div class="tot"><span class="muted">Subtotal</span><span>${money(c.sub)}</span></div>
        <div class="tot big"><span>Total</span><span>${money(c.total)}</span></div>
        <div class="row"><button class="btn" data-billnow>${o.status === 'billing' ? 'View bill' : 'Generate bill'}</button>${!o.items.length ? `<button class="btn danger" data-cancel>Cancel</button>` : ''}</div>` : ''}
        ${!o && d.length ? `<button class="btn ghost" data-cleardraft>Clear draft</button>` : ''}
      </div>
    </aside>
  </div>
  ${(d.length || o) ? `<button class="jump" data-jump><span>${d.length ? d.reduce((a, x) => a + x.qty, 0) + ' new item(s) · ' + money(draftTotal) : 'View order'}</span><span>${d.length ? 'Review & send ›' : (c ? money(c.total) + ' ›' : '')}</span></button>` : ''}`;
}

function viewKitchen() {
  const open = S.kots.filter(k => !k.done).sort((a, b) => a.at - b.at);
  const body = open.length ? `<div class="kgrid">${open.map(k => {
    const o = S.orders[k.orderId]; if (!o) return '';
    const ls = o.items.filter(i => k.lines.includes(i.lid));
    const late = Date.now() - k.at > 20 * 60000;
    return `<div class="kot ${late ? 'late' : ''}"><div class="kot-h"><div><b>Table ${o.table}</b> <span class="small muted">KOT #${k.no}</span></div><span class="age">${ago(k.at)}</span></div>
      <div class="kot-b">${ls.map(i => `<div class="kl"><span class="q">${i.qty}×</span><div>${esc(i.name)}${i.note ? `<div class="note">${esc(i.note)}</div>` : ''}</div></div>`).join('') || '<div class="muted small">Items were removed</div>'}</div>
      <div class="kot-f"><button class="btn primary block" data-ready="${k.no}">Mark ready</button></div></div>`;
  }).join('')}</div>` : `<div class="card empty"><svg viewBox="0 0 24 24"><path d="M6 13h12v6a2 2 0 0 1-2 2H8a2 2 0 0 1-2-2z"/><path d="M8 13a4 4 0 1 1 1-7.9A4 4 0 0 1 16 5a4 4 0 1 1 0 8"/></svg><div><b>No pending orders</b></div><div class="small">New kitchen tickets (KOTs) show up here when waiters send orders.</div></div>`;
  return `<div class="h-row"><h1>Kitchen</h1><span class="muted small">${open.length} pending ticket${open.length === 1 ? '' : 's'} · open this tab on the kitchen screen</span></div>${body}`;
}

function viewMenu() {
  const cats = ['All', ...S.categories];
  const list = S.menu.filter(m => ui.menuCat === 'All' || m.cat === ui.menuCat);
  return `<div class="h-row"><h1>Menu</h1><div class="row" style="flex:none"><button class="btn sm" data-cats>Categories</button><button class="btn sm primary" data-newitem>+ Add dish</button></div></div>
  <div class="chips" style="margin-bottom:12px">${cats.map(c => `<button class="chip ${c === ui.menuCat ? 'on' : ''}" data-mcat="${esc(c)}">${esc(c)}</button>`).join('')}</div>
  <div class="card">${list.length ? list.map(m => `<div class="list-row">${vegDot(m.veg)}<div class="grow"><div style="font-weight:600">${esc(m.name)}</div><div class="small muted">${esc(m.cat)} · ${money(m.price)}</div></div>
    <button class="switch ${m.avail ? 'on' : ''}" data-avail="${m.id}" role="switch" aria-checked="${m.avail}" aria-label="Available"></button>
    <button class="btn sm" data-edit="${m.id}">Edit</button></div>`).join('') : '<div class="empty">No dishes in this category yet.</div>'}</div>
  <p class="small muted" style="margin-top:10px">Turn the switch off when a dish runs out — waiters won't be able to order it.</p>`;
}

function viewSales() {
  const paid = Object.values(S.orders).filter(o => o.status === 'paid');
  const days = [...new Set(paid.map(o => dayKey(o.paidAt)))].sort().reverse();
  if (!days.includes(ui.salesDay)) days.unshift(ui.salesDay);
  const today = paid.filter(o => dayKey(o.paidAt) === ui.salesDay);
  const sum = today.reduce((a, o) => a + o.bill.total, 0);
  const gst = today.reduce((a, o) => a + o.bill.gst, 0);
  const pay = {Cash: 0, UPI: 0, Card: 0};
  today.forEach(o => pay[o.payment] = (pay[o.payment] || 0) + o.bill.total);
  const dish = {};
  today.forEach(o => o.items.forEach(i => { dish[i.name] = (dish[i.name] || 0) + i.qty; }));
  const top = Object.entries(dish).sort((a, b) => b[1] - a[1]).slice(0, 8);
  const max = top[0]?.[1] || 1;
  const wt = {};
  today.forEach(o => wt[o.waiter] = (wt[o.waiter] || 0) + o.bill.total);
  return `<div class="h-row"><h1>Sales</h1><select class="input" id="salesDay" style="width:auto">${days.map(d => `<option value="${d}" ${d === ui.salesDay ? 'selected' : ''}>${new Date(d + 'T12:00').toLocaleDateString('en-IN', {weekday: 'short', day: 'numeric', month: 'short'})}</option>`).join('')}</select></div>
  <div class="kpis">
    <div class="card kpi"><div class="l">Total sales</div><div class="v">${money(sum)}</div></div>
    <div class="card kpi"><div class="l">Bills</div><div class="v">${today.length}</div></div>
    <div class="card kpi"><div class="l">Average bill</div><div class="v">${money(today.length ? sum / today.length : 0)}</div></div>
    <div class="card kpi"><div class="l">GST collected</div><div class="v">${money(gst)}</div></div>
  </div>
  <div class="two">
    <div class="card"><h2 style="margin-bottom:8px">Payments</h2>${Object.entries(pay).map(([k, v]) => `<div class="list-row"><div class="grow">${k}</div><b>${money(v)}</b></div>`).join('')}
      <h2 style="margin:16px 0 8px">By waiter</h2>${Object.keys(wt).length ? Object.entries(wt).map(([k, v]) => `<div class="list-row"><div class="grow">${esc(k)}</div><b>${money(v)}</b></div>`).join('') : '<div class="muted small">No bills yet.</div>'}</div>
    <div class="card"><h2 style="margin-bottom:8px">Top dishes</h2>${top.length ? top.map(([n, q]) => `<div style="margin:8px 0"><div class="tot small"><span>${esc(n)}</span><b>${q}</b></div><div class="bar"><i style="width:${q / max * 100}%"></i></div></div>`).join('') : '<div class="muted small">No bills yet.</div>'}</div>
  </div>
  <div class="card" style="margin-top:16px"><h2 style="margin-bottom:6px">Bills</h2>${today.length ? today.sort((a, b) => b.paidAt - a.paidAt).map(o => `<div class="list-row"><div class="grow"><b>Bill #${o.billNo}</b> <span class="small muted">· Table ${o.table} · ${new Date(o.paidAt).toLocaleTimeString('en-IN', {hour: 'numeric', minute: '2-digit'})} · ${o.payment}</span></div><b>${money(o.bill.total)}</b><button class="btn sm" data-reprint="${o.id}">View</button></div>`).join('') : '<div class="muted small">No bills on this day.</div>'}</div>`;
}

function viewSettings() {
  const s = S.settings;
  return `<div class="h-row"><h1>Settings</h1></div>
  <div class="two">
  <div class="card stack">
    <h2>Restaurant</h2>
    <div class="field"><label for="sName">Name</label><input id="sName" value="${esc(s.name)}"></div>
    <div class="field"><label for="sAddr">Address (on bill)</label><input id="sAddr" value="${esc(s.address)}"></div>
    <div class="row"><div class="field"><label for="sPhone">Phone</label><input id="sPhone" value="${esc(s.phone)}" inputmode="tel"></div><div class="field"><label for="sGstin">GSTIN</label><input id="sGstin" value="${esc(s.gstin)}"></div></div>
    <div class="row"><div class="field"><label for="sTables">Tables</label><input id="sTables" type="number" min="1" max="200" value="${s.tables}"></div><div class="field"><label for="sGst">GST %</label><input id="sGst" type="number" min="0" step="0.5" value="${s.gst}"></div><div class="field"><label for="sSvc">Service %</label><input id="sSvc" type="number" min="0" step="0.5" value="${s.service}"></div></div>
    <button class="btn primary" data-savesettings>Save settings</button>
  </div>
  <div class="card stack">
    <h2>Waiters</h2>
    <div>${s.waiters.map((w, i) => `<div class="list-row"><div class="grow">${esc(w)}</div><button class="btn sm danger" data-delwaiter="${i}">Remove</button></div>`).join('') || '<div class="muted small">No waiters yet.</div>'}</div>
    <div class="row"><input class="input" id="newWaiter" placeholder="Waiter name"><button class="btn" data-addwaiter style="flex:none">Add</button></div>
    <h2 style="margin-top:8px">Data</h2>
    <p class="small muted">Everything is saved automatically and shared by every p
