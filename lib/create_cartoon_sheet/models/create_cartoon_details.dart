import 'package:equatable/equatable.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class CreateCartoonDetails extends Equatable {
  const CreateCartoonDetails({
    this.filePath,
    this.published,
    this.author,
    this.description,
    this.imageType,
    this.tags = const [],
  });

  final String? filePath;
  final DateTime? published;
  final String? author;
  final String? description;
  final ImageType? imageType;
  final List<Tag> tags;

  CreateCartoonDetails copyWith({
    String? filePath,
    DateTime? published,
    String? author,
    String? description,
    ImageType? imageType,
    List<Tag>? tags,
  }) {
    return CreateCartoonDetails(
      filePath: filePath ?? this.filePath,
      published: published ?? this.published,
      author: author ?? this.author,
      description: description ?? this.description,
      imageType: imageType ?? this.imageType,
      tags: tags ?? this.tags,
    );
  }

  @override
  List<Object?> get props => [
    filePath,
    published,
    author,
    description,
    imageType,
    tags
  ];
}