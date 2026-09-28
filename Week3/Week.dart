// Week3.dart - Library Desk Assistant
// Name: Aleena Tariq Roll no: 04072313016

final List<Map<String, dynamic>> books = [
 {'title': 'Dart in Action', 'author': 'Ada', 'year': 2021,
 'copies': 3, 'tags': ['dart', 'programming']},
 {'title': 'Flutter Basics', 'author': 'Sam', 'year': 2023,
 'copies': 0, 'tags': ['flutter', 'mobile']},
 {'title': 'Clean Code', 'author': 'Martin', 'year': 2008,
 'copies': 2, 'tags': ['programming', 'design']},
 {'title': 'Algorithms', 'author': 'Knuth', 'year': 1968,
 'copies': 1, 'tags': ['programming', 'math']},
 {'title': 'UI Design', 'author': 'Nora', 'year': 2019,
 'copies': 4, 'tags': ['design', 'mobile']},
];

// PART 1
// 1.1: Positional parameters
double lateFee(int daysLate, double ratePerDay) => daysLate * ratePerDay;

//  1.2: Optional positional parameter
 String formatTitle(String title, [String? author])=> author == null ? title : '$title by $author';

//  1.3: Named parameters with required and a default
Map<String, dynamic> makeBook({required String title, required String author, int year = 2024,int copies = 1}) {
  return {
    'title': title,
    'author': author,
    'year': year,
    'copies': copies,
  };
}

// 1.4: Arrow function
bool isClassic(int year) => year < 2000;

// PART 2

// 2.1: Passing a function as an argument
List<String> transformAll(List<String> items, String Function(String) fn) => items.map(fn).toList();


//  2.2: A closure that remembers
int Function() makeCounter() {
  int count = 0;

  return () => ++count;
}


//  2.3: A closure with a parameter
double Function(int) makeFeeCalculator(double rate) => (int days) => days * rate;


//  2.4: Recursion
int sumDigits(int n) => n<10 ? n: (n % 10) + sumDigits(n ~/ 10);


// PART 3
Map<String, int> buildStock() { 
  return { 
    books.forEach(b) 
      print b['title'] as String: b['copies'] as int 
  }; 
}

// PART 4
// 4.1: A generic class
class Box<T> {
  T value;
  Box(this.value);
}

// 4.2: A generic function
T firstOr<T>(List<T> items, T fallback)=> items.isNotEmpty ? items.first : fallback;


// 4.3: A class with two type parameters
class Pair<A, B> {
  A first;
  B second;
  Pair(this.first, this.second);

  @override
  String toString() => '($first, $second)';
}

// PART 5
//  5.1: Custom exceptions
class BookNotFoundException implements Exception {
  final String title;

  BookNotFoundException(this.title);
}

// 5.2: Throwing
class BookNotAvailableException implements Exception {
  final String title;

  BookNotAvailableException(this.title);
}


// 5.3: try / on / catch / finally
void checkOut(Map<String, int> stock, String title) {
  if (!stock.containsKey(title)) {
    throw BookNotFoundException(title);
  }

  if (stock[title]! <= 0) {
    throw BookNotAvailableException(title);
  }

  stock[title] = stock[title]! - 1;
}

// 5.4: A built-in exception
Map<String, dynamic> findBook(String title) => books.firstWhere((book) => book['title'] == title);


// -------------------- Part 6 --------------------

// 6.1: Await a Future
Future<String> fetchBookOfTheDay() async {
  await Future.delayed(const Duration(seconds: 1));
  return 'Dart in Action';
}

//  6.2: See what happens without await
// Future<String> fetchBookOfTheDay() async {
//   Future.delayed(const Duration(seconds: 1));
//   return 'Dart in Action';
// }


// 6.3: Errors in async code
Future<String> fetchBroken() async {
  await Future.delayed(const Duration(milliseconds: 500));
  throw Exception('Server down');
}


// MAIN
void main() async {
  part1();
  part2();
  part3();
  part4();
  part5();
  await part6();
}

void part1() {
  print('--- Part 1 ---');

  print('Late fee: ${lateFee(5, 0.5)}');
  print(formatTitle('Dart in Action'));
  print(formatTitle('Dart in Action', 'Ada'));

  print(
    makeBook(
      title: 'Clean Code',
      author: 'Martin',
    ),
  );

  print(
    makeBook(
      title: 'Algorithms',
      author: 'Knuth',
      year: 1968,
    ),
  );

  print(isClassic(1968));
  print(isClassic(2021));
}

void part2() {
  print('--- Part 2 ---');

  var titles = ['Dart in Action', 'Clean Code'];

  var upperCaseTitles = transformAll(
    titles,
    (String item) {
      return item.toUpperCase();
    },
  );

  var excitedTitles = transformAll(
    titles,
    (item) => '$item!',
  );

  print(upperCaseTitles);
  print(excitedTitles);

  var desk1 = makeCounter();
  var desk2 = makeCounter();

  print(desk1());
  print(desk1());
  print(desk1());
  print(desk2());

  var studentFee = makeFeeCalculator(0.25);
  var staffFee = makeFeeCalculator(0.10);

  print('Student fee: ${studentFee(4)}');
  print('Staff fee: ${staffFee(4)}');

  print('Sum of digits: ${sumDigits(314)}');
}

void part3() {
  print('--- Part 3 ---');

  var titles = books.map((book) => book['title'] as String).toList();
  print('Titles: $titles');

  var available = books
      .where((book) => (book['copies'] as int) > 0)
      .map((book) => book['title'] as String)
      .toList();
  print('Available: $available');

  var totalCopies = books.fold<int>(
    0,
    (sum, book) => sum + (book['copies'] as int),
  );
  print('Total copies: $totalCopies');

  var years = books.map((book) => book['year'] as int).toList();
  var oldestYear = years.reduce((a, b) => a < b ? a : b);
  print('Oldest year: $oldestYear');

  var sortedBooks = List<Map<String, dynamic>>.of(books);
  sortedBooks.sort(
    (a, b) => (a['year'] as int).compareTo(b['year'] as int),
  );

  var titlesByYear =
      sortedBooks.map((book) => book['title'] as String).toList();
  print('By year: $titlesByYear');

  var stock = buildStock();
  print('Stock: $stock');

  stock.forEach((title, copies) {
    if (copies == 0) {
      print('Out of stock: $title');
    }
  });

  print('Copies of Unknown: ${stock['Unknown'] ?? 0}');

  Set<String> allTags = {
    for (var book in books) ...(book['tags'] as List<String>),
  };
  print('All tags: $allTags');

  var a = {'Dart in Action', 'Clean Code', 'Flutter Basics'};
  var b = {'Clean Code', 'Flutter Basics', 'Algorithms'};

  print('Union: ${a.union(b)}');
  print('Common: ${a.intersection(b)}');
  print('Only in A: ${a.difference(b)}');
}

void part4() {
  print('--- Part 4 ---');

  var intBox = Box<int>(5);
  var strBox = Box<String>('dart');

  print('Box<int>: ${intBox.value}');
  print('Box<String>: ${strBox.value}');

  // intBox.value = 'hello';

  print(firstOr(['Dart in Action', 'Clean Code'], 'none'));
  print(firstOr<String>([], 'z'));

  print(Pair('Dart in Action', 3));
}

void part5() {
  print('--- Part 5 ---');

  var stock = buildStock();

  var titles = [
    'Dart in Action',
    'Flutter Basics',
    'Unknown Book',
  ];

  for (var title in titles) {
    try {
      checkOut(stock, title);
      print('Checked out: $title');
    } on BookNotAvailableException catch (e) {
      print('Sorry: "${e.title}" has no copies left');
    } on BookNotFoundException catch (e) {
      print('Not found: "${e.title}"');
    } catch (e) {
      print('Unexpected error: $e');
    } finally {
      print('Transaction logged.');
    }
  }

  print('Copies left of Dart in Action: ${stock['Dart in Action']}');

  try {
    findBook('Missing');
  } on StateError {
    print('Search failed: no such book');
  }
}

Future<void> part6() async {
  print('--- Part 6 ---');

  print('Fetching...');
  var result = await fetchBookOfTheDay();
  print('Book of the day: $result');

  try {
    await fetchBroken();
  } catch (e) {
    print('Fetch failed: $e');
  }
}

/*
Answers
1. Fold over reduce
I would choose fold when I want to provide my own starting value or when the
list is empty. reduce uses the first list item as its initial value.

2. closure "captures" a variable
Closure captures a variable means the returned function remembers and can keep using a variable from
the scope where it was created. The captured variable is count.

3. BookNotAvailableException come before a general catch (e)
BookNotAvailableException should be handled first so it gets its required
message. A general catch can catch many errors and may otherwise handle it
before the specific logic is reached.

*/
