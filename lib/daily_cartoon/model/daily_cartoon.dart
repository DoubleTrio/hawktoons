import 'package:equatable/equatable.dart';

class DailyCartoon extends Equatable {
  DailyCartoon(
      {required this.id,
      required this.image,
      required this.author,
      required this.date,
      required this.description});

  final String id;
  final String image;
  final String date;
  final String author;
  final String description;

  @override
  List<Object> get props => [id, image, date, author, description];

  @override
  String toString() => 'DailyCartoon { '
      'id: $id '
      'image: $image, '
      'date: $date, '
      'author: $author, '
      'description: $description'
      '}';
}
