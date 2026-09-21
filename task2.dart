/// prints the welcome msg
void printWelcome(String appName) {
  print('===== $appName =====');
}

// generates a simple code using the first two letters of the course title
String generateCode(String title) {
  return title.substring(0, 2).toUpperCase() + '101';
}

void main() {
  // Part 1 
  printWelcome('Course Roster Manager');

  // Part 2 
  // course details
  const int maxCapacity = 4;
  final DateTime createdAt = DateTime.now();

  String courseTitle = 'CS201: Mobile App Development';
  int capacity = maxCapacity;
  double creditHours = 3.0;
  bool isOpen = true;

  // students already enrolled in the course
  List<String> enrolledStudents = ['Aiden', 'Maria', 'Jamal'];

  // students currently waiting for a seat
  Set<String> waitlist = {'Priya', 'Noah'};

  // stores attendance for each enrolled student
  Map<String, int> attendanceCount = {
    'Aiden': 3,
    'Maria': 4,
    'Jamal': 2,
  };

  print(
      '$courseTitle | Capacity: $capacity | Enrolled: ${enrolledStudents.length}');

  // Part 3
  // email is nullable because it has not been assigned yet
  String? instructorEmail;

  // if email is null TBA will be shown instead
  print(instructorEmail ?? 'TBA');

  late String enrollmentCode;
  enrollmentCode = generateCode(courseTitle);

  print('Enrollment code: $enrollmentCode');

  // Deliberate crash for testing
  // print(instructorEmail!.length);

  // Safe version
  print(instructorEmail?.length ?? 0);

  // Part 4 
  // raw names contain extra spaces
  String rawNames = ' Aiden , maria ,JAMAL , Priya ';

  List<String> cleanNames = [];

  // splits names and remove unnecessary spaces
  for (var name in rawNames.split(',')) {
    cleanNames.add(name.trim());
  }

  print(cleanNames);

  // Multi-line description of the course
  String courseDescription = '''
Course: $courseTitle
Credit Hours: $creditHours
Capacity: $capacity
Created: $createdAt
''';

  print(courseDescription);

  print('Seats left: ${capacity - enrolledStudents.length}');

  // ---------- Part 5 ----------
  // divide students into groups of 3
  int fullGroups = enrolledStudents.length ~/ 3;
  int leftover = enrolledStudents.length % 3;

  print('Full groups of 3: $fullGroups, leftover: $leftover');

  // sample input val
  Object formInput = 'twenty-two';

  if (formInput is String) {
    print('This is text!');
  }

  if (formInput is! int) {
    print('The input is not an integer.');
  }

  // Build one report using cascade operators
  StringBuffer report = StringBuffer()
    ..write('Report: $courseTitle')
    ..write(' | Cap: $capacity')
    ..write(' | Roster: ${enrolledStudents.length}');

  print(report.toString());

  // this is nullable list so nothing is added while it is null
  List<String>? extraNotes;

  extraNotes?..add('Room change pending');

  print('Extra notes: $extraNotes');

  // give bonusSeats a value only if it is null
  int? bonusSeats;
  bonusSeats ??= 0;

  print('Bonus seats: $bonusSeats');

  // Part 6 
  // check if there is still space for a new student
  if (isOpen && enrolledStudents.length < capacity) {
    print("You're in! Welcome aboard.");
  } else {
    print('Course is currently full.');
  }

  int enrollmentStatusCode = 200;

  // displays msg based on the status code
  switch (enrollmentStatusCode) {
    case 200:
      print('Enrolled');
      break;

    case 404:
      print('Course not found');
      break;

    default:
      print('Unknown error');
      break;
  }

  String statusTag = isOpen ? 'OPEN' : 'FULL';

  print(statusTag);

  // Part 7 
  // prints every student in the roster
  for (var student in enrolledStudents) {
    print(student);
  }

  // print each students attendance
  attendanceCount.forEach((student, count) {
    print('$student: $count');
  });

  // announcements
  List<String> announcements = [
    'Welcome to $courseTitle',
    if (!isOpen) 'Course is FULL — waitlist open',
    for (var student in waitlist)
      'Reminder: $student, please confirm attendance',
  ];

  for (var announcement in announcements) {
    print(announcement);
  }
}
