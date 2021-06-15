

import 'package:equatable/equatable.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class CreateCartoonDetails extends Equatable {
  const CreateCartoonDetails({
    this.file,
    this.published,
    this.author,
    this.description,
    this.imageType,
    this.tags = const [],
  });

  final String? file;
  final DateTime? published;
  final String? author;
  final String? description;
  final ImageType? imageType;
  final List<Tag> tags;

  CreateCartoonDetails copyWith({
    String? file,
    DateTime? published,
    String? author,
    String? description,
    ImageType? imageType,
    List<Tag>? tags,
  }) {
    return CreateCartoonDetails(
      file: file ?? this.file,
      published: published ?? this.published,
      author: author ?? this.author,
      description: description ?? this.description,
      imageType: imageType ?? this.imageType,
    );
  }

  @override
  List<Object?> get props => [
    file,
    published,
    author,
    description,
    imageType,
    tags
  ];
}