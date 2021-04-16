import 'package:bloc/bloc.dart';

enum SortByMode {
  latestPosted,
  earliestPosted,
  latestPublished,
  earliestPublished,
}

extension SortByExtension on SortByMode {
  static const headers = {
    SortByMode.latestPosted: 'Latest Daily Cartoon',
    SortByMode.earliestPosted: 'Earliest Daily Cartoon',
    SortByMode.latestPublished: 'Latest Published Cartoon',
    SortByMode.earliestPublished: 'Earliest Published Cartoon',
  };

  String get header => headers[this] ?? 'Unknown';
}

class SortByCubit extends Cubit<SortByMode> {
  SortByCubit() : super(SortByMode.latestPosted);

  void selectSortBy(SortByMode sortBy) {
    return emit(sortBy);
  }
}
