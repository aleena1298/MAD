// library_lab.dart  -  Campus Library System
// Name: Aleena Tariq  Roll no: 04072313016

const String rollNo = '04072313016'; // e.g. '21F-0347'

// ===== Seeded settings (generated from YOUR roll number). Do not edit. =====
final int seed = int.parse(rollNo.substring(rollNo.length - 2));
final int t = seed ~/ 10; // tens digit
final int u = seed % 10; // units digit

const List<String> titles = [
  'Dart Basics',
  'Flutter In Action',
  'Data Structures',
  'Operating Systems',
  'Mobile Design',
  'Clean Code',
  'Algorithms Unlocked',
  'Computer Networks',
  'Database Systems',
  'Software Testing',
];

int yearOf(int i) => 1995 + 2 * i + t; // publication year of titles[i]
final int feePerDay = 5 + t; // late fee per day, in rupees
final int daysLate = 3 + (t + u) % 6; // normal number of days late
final int daysBig = 10 + u; // a long overdue period
final int feeCap = 150 + 10 * t; // no single fee may exceed this
final int renewLimit = 1 + t % 3; // renewals allowed per item
final int renewAttempts = 2 + u; // renewal attempts made in Step 5
final int shelfSize = 3 + u % 4; // items on the shelf in Steps 9-10
// ===========================================================================

// Step 1
// 1.1
abstract class LibraryItem {
  // 9.1
  static int created = 0;
  final String title;
  final int year;

  // 9.1
  LibraryItem(this.title, this.year) {
    created++;
  }

  // 2.1
  String describe() => '$title ($year)';

  // 3.1
  int lateFee(int days);

  // 9.1
  static int capFee(int fee) {
    return fee > feeCap ? feeCap : fee;
  }
}

// 1.2
class Book extends LibraryItem with Renewable implements Borrowable {
  final int pages;
  bool _out = false;

  Book(super.title, super.year, this.pages);

  // 2.2
  @override
  String describe() => '${super.describe()}, $pages pages';

  // 3.2
  @override
  int lateFee(int days) => days * feePerDay;

  // 4.2
  @override
  bool get isAvailable => !_out;

  @override
  void borrow() {
    _out = true;
  }

  @override
  void giveBack() {
    _out = false;
  }
}

// 1.3
Book mainBook() {
  return Book(titles[u], yearOf(u), 100 + 3 * seed);
}

// 2.3
class Magazine extends LibraryItem {
  final int issue;

  Magazine(super.title, super.year, this.issue);

  @override
  String describe() => '${super.describe()}, issue $issue';

  // 3.2
  @override
  int lateFee(int days) => days * (feePerDay ~/ 2);
}

Magazine mainMagazine() {
  int i = (u + 1) % 10;

  return Magazine(titles[i], yearOf(i), 1 + (t + u) % 12);
}

// 3.2
class Dvd extends LibraryItem with Renewable {
  final int minutes;

  Dvd(super.title, super.year, this.minutes);

  @override
  String describe() => '${super.describe()}, $minutes min';

  @override
  int lateFee(int days) => days * feePerDay * 2;
}

Dvd mainDvd() {
  int i = (u + 2) % 10;

  return Dvd(titles[i], yearOf(i), 90 + seed % 40);
}

// 4.1
abstract class Borrowable {
  bool get isAvailable;

  void borrow();

  void giveBack();
}

// 5.1
mixin Renewable {
  int renewals = 0;

  bool renew(int limit) {
    if (renewals >= limit) {
      return false;
    }

    renewals++;
    return true;
  }
}

// 6.1
enum MemberType {
  student(3, 50),
  faculty(10, 20),
  guest(1, 0);

  final int maxLoans;
  final int discountPercent;

  const MemberType(this.maxLoans, this.discountPercent);

  int applyDiscount(int fee) {
    return fee - (fee * discountPercent ~/ 100);
  }
}

// 7.1
extension MoneyText on int {
  String get rs => 'Rs $this'; // 72.rs -> 'Rs 72'
}

extension Initials on String {
  String get initials => split(' ')
      .map((word) => word[0])
      .join(); // 'Computer Networks'.initials -> 'CN'
}

extension ShelfMath on List<LibraryItem> {
  int totalLateFee(int days) {
    return fold(
      0,
      (sum, item) =>
          sum + item.lateFee(days), // sum of lateFee(days) over the list
    );
  }
}

// Step 8.1
class Fine {
  final int amount;

  const Fine(this.amount);

  Fine operator +(Fine other) {
    return Fine(amount + other.amount);
  }

  bool operator >(Fine other) {
    return amount > other.amount;
  }

  @override
  bool operator ==(Object other) {
    return other is Fine && amount == other.amount;
  }

  @override
  int get hashCode => amount.hashCode;

  @override
  String toString() => 'Fine($amount)';
}

// 9.1
List<LibraryItem> buildShelf() {
  return [
    for (int k = 0; k < shelfSize; k++)
      if (k % 3 == 0)
        Book(titles[(u + k) % 10], yearOf((u + k) % 10), 100 + 3 * seed)
      else if (k % 3 == 1)
        Magazine(titles[(u + k) % 10], yearOf((u + k) % 10), 1 + (t + k) % 12)
      else
        Dvd(titles[(u + k) % 10], yearOf((u + k) % 10), 90 + seed % 40),
  ];
}

// 10.1
class Member {
  final String name;
  final MemberType type;

  Member(this.name, this.type);

  Fine feeFor(LibraryItem item, int days) {
    int fee = item.lateFee(days);

    fee = LibraryItem.capFee(fee);

    fee = type.applyDiscount(fee);

    return Fine(fee);
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

  var b = mainBook();

  LibraryItem item = b;

  print('Step 1: ${b.title} (${b.year}), ${b.pages} pages');
  print('Step 1: stored as LibraryItem: ${item.title}');
  print('Step 1: runtimeType = ${item.runtimeType}');

  // item.pages is a compile time error because item is declared as LibraryItem and LibraryItem does not have pages field.
}

void step2() {
  print('--- Step 2 ---');
  print('Step 2: ${mainBook().describe()}');
  print('Step 2: ${mainMagazine().describe()}');

  // If @override is forgotten and describe is misspelled as descibe() Dart treats it as a new method instead of replacing describe()
}

void step3() {
  print('--- Step 3 ---');
  var book = mainBook();
  var magazine = mainMagazine();
  var dvd = mainDvd();

  print('Step 3: Book late fee for $daysLate days = ${book.lateFee(daysLate)}');

  print(
    'Step 3: Magazine late fee for $daysLate days = ${magazine.lateFee(daysLate)}',
  );

  print('Step 3: Dvd late fee for $daysLate days = ${dvd.lateFee(daysLate)}');

  // LibraryItem cannot be created directly because it is abstract.
}

void step4() {
  print('--- Step 4 ---');
  var book = mainBook();

  print('Step 4: available? ${book.isAvailable}');

  book.borrow();
  print('Step 4: after borrow? ${book.isAvailable}');

  book.giveBack();
  print('Step 4: after return? ${book.isAvailable}');

  List<LibraryItem> items = [book, mainMagazine(), mainDvd()];

  for (var item in items) {
    print('Step 4: ${item.runtimeType} borrowable? ${item is Borrowable}');
  }

  // Borrowable only defines a contract here, so Book writes the methods itself.
  // Book also already extends LibraryItem, and Dart allows only one parent class.
}

void step5() {
  print('--- Step 5 ---');
  var book = mainBook();

  int ok = 0;

  for (int i = 0; i < renewAttempts; i++) {
    if (book.renew(renewLimit)) {
      ok++;
    }
  }

  print(
    'Step 5: renewed $ok of $renewAttempts attempts '
    '(limit $renewLimit)',
  );

  print('Step 5: renew once more? ${book.renew(renewLimit)}');

  print('Step 5: dvd can renew too? ${mainDvd().renew(1)}');

  // A mixin is suitable because Book and Dvd need this behaviour while Magazine does not
}

void step6() {
  print('--- Step 6 ---');
  var type = MemberType.values[seed % 3];

  int fee = mainBook().lateFee(daysLate);

  print(
    'Step 6: member type = ${type.name} '
    '(index ${type.index})',
  );

  print('Step 6: max loans = ${type.maxLoans}');

  print(
    'Step 6: book fee $fee -> '
    '${type.applyDiscount(fee)} after discount',
  );

  // MemberType.student is safer than the String student because the enum only allows valid predefined values
}

void step7() {
  print('--- Step 7 ---');
  var type = MemberType.values[seed % 3];

  int fee = mainBook().lateFee(daysLate);

  int discountedFee = type.applyDiscount(fee);

  List<LibraryItem> shelf = [mainBook(), mainMagazine(), mainDvd()];

  print('Step 7: ${discountedFee.rs}');

  print('Step 7: initials of "${titles[u]}" = ${titles[u].initials}');

  print(
    'Step 7: shelf fee for $daysLate days = '
    '${shelf.totalLateFee(daysLate).rs}',
  );

  // Extensions make code easier to read, such as 72.rs instead of calling a separate function like rs(72)
}

void step8() {
  print('--- Step 8 ---');
  var f1 = Fine(mainBook().lateFee(daysLate));

  var f2 = Fine(mainMagazine().lateFee(daysLate));

  print('Step 8: $f1 + $f2 = ${f1 + f2}');

  print('Step 8: first bigger? ${f1 > f2}');

  print('Step 8: equal copies? ${f1 == Fine(f1.amount)}');

  print(
    'Step 8: set size = '
    '${{f1, Fine(f1.amount), f2}.length}',
  );

  // == and hashCode must agree so equal objects behave correctly inside Sets and Maps
}

void step9() {
  print('--- Step 9 ---');
  LibraryItem.created = 0;

  buildShelf();

  var shelf = buildShelf();

  print('Step 9: items created = ${LibraryItem.created}');

  print(
    'Step 9: capped fee = '
    '${LibraryItem.capFee(shelf.first.lateFee(daysBig))} '
    '(cap $feeCap)',
  );

  print(
    'Step 9: const copies identical? '
    '${identical(const Fine(10), const Fine(10))}',
  );

  print(
    'Step 9: new copies identical? '
    '${identical(Fine(10), Fine(10))}',
  );

  // created is static, so it belongs to LibraryItem itself rather than to one LibraryItem object
}

void step10() {
  print('--- Step 10 ---');
  var shelf = buildShelf();

  var member = Member('S$seed', MemberType.values[seed % 3]);

  var total = shelf.fold<Fine>(
    const Fine(0),
    (sum, item) => sum + member.feeFor(item, daysLate),
  );

  int borrowable = 0;
  int renewable = 0;

  for (var item in shelf) {
    if (item is Borrowable) {
      borrowable++;
    }

    if (item is Renewable) {
      renewable++;
    }
  }

  print(
    'Step 10: ${shelf.length} items, '
    '$borrowable borrowable, '
    '$renewable renewable',
  );

  print(
    'Step 10: ${member.name} '
    '(${member.type.name}) owes $total',
  );

  print(
    'Step 10: over the cap? '
    '${total > Fine(feeCap)}',
  );
}
