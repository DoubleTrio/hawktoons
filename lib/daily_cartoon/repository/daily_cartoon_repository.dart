import 'dart:async';
import '../model/models.dart';

abstract class DailyCartoonRepository {
  Future<DailyCartoon> fetchDailyCartoon();
}

DailyCartoon dailyPoliticalCartoon = DailyCartoon(
    id: '1',
    image: 'insert-image-uri',
    author: 'Kurt',
    date: '11-20-2020',
    description: 'Mock Political Cartoon');

class FirebaseDailyCartoonRepository implements DailyCartoonRepository {
  @override
  Future<DailyCartoon> fetchDailyCartoon() async {
    return Future.delayed(
        const Duration(seconds: 1), () => dailyPoliticalCartoon);
  }
}
