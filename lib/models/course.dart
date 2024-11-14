class Course {
  final int capacity;
  final int courseId;
  final String courseName;
  final String dayOfWeek;
  final String description;
  final double duration;
  final int id;
  final double price;
  final String time;
  final String type;

  Course(
      {required this.capacity,
      required this.courseId,
      required this.courseName,
      required this.dayOfWeek,
      required this.description,
      required this.duration,
      required this.id,
      required this.price,
      required this.time,
      required this.type});
}
