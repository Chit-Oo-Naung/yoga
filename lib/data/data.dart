import 'package:yoga/models/course.dart';
import 'package:yoga/models/style.dart';

final _standStyle = Style(
  imageUrl: 'assets/images/pose2.png',
  name: 'Standing Style',
  time: 5,
);
final _sittingStyle = Style(
  imageUrl: 'assets/images/pose1.png',
  name: 'Sitting Style',
  time: 8,
);
final _legCrossStyle = Style(
  imageUrl: 'assets/images/pose3.png',
  name: 'Leg Cross Style',
  time: 6,
);

final styles = [_standStyle, _sittingStyle, _legCrossStyle];

final _course1 = Course(
    // imageUrl: 'assets/images/course1.jpg',
    capacity: 10,
    courseId: 154320,
    courseName: 'Flow Yoga Course 1 ',
    dayOfWeek: 'Monday',
    description: 'this is best course for beginner',
    duration: 10,
    id: 1,
    price: 10.0,
    time: '08:00',
    type: 'Flow Yoga');

final _course2 = Course(
    // imageUrl: 'assets/images/course1.jpg',
    capacity: 10,
    courseId: 154320,
    courseName: 'Flow Yoga Course 2 ',
    dayOfWeek: 'Monday',
    description: 'this is best course for beginner',
    duration: 10,
    id: 1,
    price: 10.0,
    time: '08:00',
    type: 'Flow Yoga');

final _course3 = Course(
    // imageUrl: 'assets/images/course1.jpg',
    capacity: 10,
    courseId: 154320,
    courseName: 'Flow Yoga Course 3 ',
    dayOfWeek: 'Monday',
    description: 'this is best course for beginner',
    duration: 10,
    id: 1,
    price: 10.0,
    time: '08:00',
    type: 'Flow Yoga');

final _course4 = Course(
    // imageUrl: 'assets/images/course1.jpg',
    capacity: 10,
    courseId: 154320,
    courseName: 'Flow Yoga Course 4 ',
    dayOfWeek: 'Monday',
    description: 'this is best course for beginner',
    duration: 10,
    id: 1,
    price: 10.0,
    time: '08:00',
    type: 'Flow Yoga');

final _course5 = Course(
    // imageUrl: 'assets/images/course1.jpg',
    capacity: 10,
    courseId: 154320,
    courseName: 'Flow Yoga Course 5 ',
    dayOfWeek: 'Monday',
    description: 'this is best course for beginner',
    duration: 10,
    id: 1,
    price: 10.0,
    time: '08:00',
    type: 'Flow Yoga');

final List<Course> courses = [_course1, _course3, _course2, _course4, _course5];
