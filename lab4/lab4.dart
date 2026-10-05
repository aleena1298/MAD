// lab4.dart  -  Campus Cafe Order System
// Name: Aleena Tariq  Roll no: 04072313016

const String rollNo = '04072313016'; // e.g. '2100672347'

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit
final int u = seed % 10; // units digit

const List<String> menu = [
  'Chai',
  'Latte',
  'Mocha',
  'Samosa',
  'Brownie',
  'Sandwich',
  'Cold Coffee',
  'Fries',
  'Pakora',
  'Zinger Wrap',
];
int priceOf(int i) => 100 + 7 * i + 3 * t; // price of menu[i], in rupees
final int priceFloor = 60 + 5 * t;
final int taxPercent = 5 + t;
final int bigOrderLimit = 450 + 20 * t;
final int balanceCap = 600 + 20 * t;
final int couponPercent = 5 + t + u;
// ===========================================================================

// Part 1
class Dish {
  late String name;
  late int price;
}

// Part 2
class MenuItem {
  String name;
  int price;

  MenuItem(this.name, this.price) {
    if (this.price < priceFloor) {
      this.price = priceFloor;
    }
  }

  // Part 3
  MenuItem.free(this.name) : price = 0;

  MenuItem.fromString(String text)
    : name = text.split(':')[0],
      price = int.parse(text.split(':')[1]);

  // Part 7
  @override
  String toString() => '$name (Rs $price)';
}

// Part 4
class OrderLog {
  static OrderLog? _instance;

  final List<String> entries = [];

  OrderLog._internal();

  factory OrderLog() {
    return _instance ??= OrderLog._internal();
  }

  void add(String msg) => entries.add(msg);
}

// Part 5
class OrderLine {
  final MenuItem item;
  final int qty;
  final int total;
  final int tax;

  // Part 6
  int get grand => total + tax;
  bool get isBigOrder => grand > bigOrderLimit;
  String get label => '${item.name} x$qty';
  // Part 6

  OrderLine(this.item, this.qty)
    : total = item.price * qty,
      tax = item.price * qty * taxPercent ~/ 100,
      assert(qty > 0, 'qty must be positive');
}

OrderLine mainOrder() {
  return OrderLine(MenuItem(menu[u], priceOf(u)), 2 + (t + u) % 5);
}

// Part 7
class StudentCard {
  final String owner;
  int _balance;

  StudentCard(this.owner) : _balance = 0;

  int get balance => _balance;

  set balance(int v) {
    if (v < 0) {
      _balance = 0;
    } else if (v > balanceCap) {
      _balance = balanceCap;
    } else {
      _balance = v;
    }
  }
}

// Part 8
List<MenuItem> buildMenu() {
  return [
    for (int k = 0; k < 4; k++)
      MenuItem.fromString(
        '${menu[(u + 3 * k) % 10]}:${priceOf((u + 3 * k) % 10)}',
      ),
  ];
}

// Part 9
List<OrderLine> buildReceipt() {
  var items = buildMenu();

  return [for (int k = 0; k < 3; k++) OrderLine(items[k], 1 + (t + k) % 4)];
}

// Part 10
class Coupon {
  static final Map<String, Coupon> _cache = {};

  final String code;
  final int percent;
  final int minSpend;

  Coupon(this.code, this.percent)
    : minSpend = percent * 70,
      assert(percent >= 1 && percent <= 50, 'percent must be between 1 and 50');

  factory Coupon.fromCode(String code) {
    return _cache.putIfAbsent(code, () => Coupon(code, couponPercent));
  }

  int discountOn(int amount) {
    if (amount >= minSpend) {
      return amount * percent ~/ 100;
    }

    return 0;
  }
}

void main() {
  print('Seed: $seed (t=$t, u=$u)');
  step1();
  step2();
  step3();
  step4();
  step5();
  step6();
  step7();
  step8();
  step9();
  step10();
}

void step1() {
  print('--- Step 1 ---');

  var item1 = Dish();
  item1.name = menu[u];
  item1.price = priceOf(u);

  var item2 = Dish();

  int index = (u + 1) % 10;

  item2.name = menu[index];
  item2.price = priceOf(index);

  item2.price = item2.price - u;

  print('Step 1: ${item1.name} Rs ${item1.price}');
  print('Step 1: ${item2.name} Rs ${item2.price}');
}

void step2() {
  print('--- Step 2 ---');

  var a = MenuItem(menu[u], priceOf(u));
  var b = MenuItem('Test Special', 15 * u);

  print('Step 2: ${a.name} Rs ${a.price}');
  print('Step 2: ${b.name} Rs ${b.price}');

  // price cannot be final because the constructor may change the price when it is below priceFloor.
}

void step3() {
  print('--- Step 3 ---');
  var freebie = MenuItem.free('Water');

  int i = (u + 2) % 10;

  var parsed = MenuItem.fromString('${menu[i]}:${priceOf(i)}');

  print('Step 3: ${freebie.name} Rs ${freebie.price}');
  print('Step 3: ${parsed.name} Rs ${parsed.price}');
  print('Step 3: floor=$priceFloor, free price=${freebie.price}');

  // the floor logic did not run because MenuItem.free()is a separate named constructor and does not call the main MenuItem constructor
}

void step4() {
  print('--- Step 4 ---');
  var log1 = OrderLog();
  var log2 = OrderLog();

  for (int i = 1; i <= u + 2; i++) {
    String message = 'order #${100 * t + i}';

    if (i % 2 == 1) {
      log1.add(message);
    } else {
      log2.add(message);
    }
  }

  print('Step 4: same object? ${identical(log1, log2)}');
  print('Step 4: entries = ${log1.entries.length}');
  print('Step 4: last = ${log2.entries.last}');

  // _instance and _internal start with _ to make them private to the Dart file and prevent it normal external access
}

void step5() {
  print('--- Step 5 ---');
  var line = mainOrder();

  print('Step 5: ${line.item.name} x${line.qty}');
  print('Step 5: total=${line.total} tax=${line.tax}');

  try {
    OrderLine(line.item, 0);
    print('Step 5: assert did NOT fire');
  } on AssertionError {
    print('Step 5: assert fired');
  }

  // we cannot use total to calculate tax in the initializer list because another instance field is not available there yet we calculate again from item.price and qty
}

void step6() {
  print('--- Step 6 ---');
  var line = mainOrder();

  print('Step 6: grand=${line.grand}');
  print(
    'Step 6: big order? ${line.isBigOrder} '
    '(limit $bigOrderLimit)',
  );
  print('Step 6: label=${line.label}');

  // line.grand = 5;
  // compile error grand only has a getter so it is read only A setter would be needed to assign value to it
}

void step7() {
  print('--- Step 7 ---');
  var card = StudentCard('S$seed');

  card.balance = seed * 10 + 50;
  print('Step 7: topped up -> ${card.balance}');

  card.balance = -seed - 1;
  print('Step 7: bad value -> ${card.balance}');

  card.balance = balanceCap - u;
  print('Step 7: reset -> ${card.balance}');

  card.balance = card.balance - mainOrder().grand;
  print('Step 7: paid order -> ${card.balance}');

  // instead of just silently changing an invalid value a setter could also throw an exception
}

void step8() {
  print('--- Step 8 ---');
  var items = buildMenu();

  var priciest = items.reduce((a, b) => a.price > b.price ? a : b);

  var sum = items.fold<int>(0, (total, item) => total + item.price);

  print('Step 8: menu = $items');
  print('Step 8: priciest = ${priciest.name}');
  print('Step 8: sum = $sum');
}

void step9() {
  print('--- Step 9 ---');
  var receipt = buildReceipt();

  for (var line in receipt) {
    print('Step 9: ${line.label} = ${line.grand}');

    OrderLog().add('receipt: ${line.label}');
  }

  var total = receipt.fold<int>(0, (sum, line) => sum + line.grand);

  print('Step 9: receipt total = $total');
  print('Step 9: log size = ${OrderLog().entries.length}');
}

void step10() {
  print('--- Step 10 ---');
  String code = 'CAFE${seed.toString().padLeft(2, '0')}';

  var c1 = Coupon.fromCode(code);
  var c2 = Coupon.fromCode(code);

  var receipt = buildReceipt();

  var receiptAmount = receipt.fold<int>(0, (sum, line) => sum + line.grand);

  var discount = c1.discountOn(receiptAmount);

  print(
    'Step 10: $code gives ${c1.percent}% off, '
    'min spend ${c1.minSpend}',
  );

  print('Step 10: cached? ${identical(c1, c2)}');

  print(
    'Step 10: receipt $receiptAmount, '
    'discount $discount, '
    'payable ${receiptAmount - discount}',
  );
}

/*
 Reflection Answers

1.The shorthand saves us from writing this.name = name and this.type = type separately it makes the constructor shorter.

2.We use a named constructor when we want another way to create an object and use a factory constructor when we may return an old object instead of creating a new one.

3.An initializer list sets the value before the constructor body runs the constructor body will run after that.

4.Getters and setters are used to control access to the data of a class getter is used to read or calculate a value and a setter is used to check or control a value before changing it.
*/
