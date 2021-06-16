// ignore_for_file: prefer_const_constructors
import 'package:flutter_test/flutter_test.dart';
import 'package:hawktoons/create_cartoon_sheet/create_cartoon_sheet.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

void main() {
  group('CreateCartoonDetails', () {
    test('supports value comparisons', () {
      expect(
        CreateCartoonDetails(),
        CreateCartoonDetails(),
      );
      expect(
        CreateCartoonDetails(
          filePath: '123',
          published: DateTime.now(),
          author: 'author',
          description: 'description',
          imageType: ImageType.document,
          tags: [Tag.tag1],
        ).copyWith(),
        isNot(equals(
          CreateCartoonDetails().copyWith(),
        )),
      );
    });
  });
}
