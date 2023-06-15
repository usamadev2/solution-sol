// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DetailModel {
  String? image;
  String? title;
  String? author;
  String? uid;
  DetailModel({
    this.image,
    this.title,
    this.author,
    this.uid,
  });

  DetailModel copyWith({
    String? image,
    String? title,
    String? author,
    String? uid,
  }) {
    return DetailModel(
      image: image ?? this.image,
      title: title ?? this.title,
      author: author ?? this.author,
      uid: uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'image': image,
      'title': title,
      'author': author,
      'uid': uid,
    };
  }

  factory DetailModel.fromMap(Map<String, dynamic> map) {
    return DetailModel(
      image: map['image'] != null ? map['image'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      author: map['author'] != null ? map['author'] as String : null,
      uid: map['uid'] != null ? map['uid'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DetailModel.fromJson(String source) =>
      DetailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'DetailModel(image: $image, title: $title, author: $author, uid: $uid)';

  @override
  bool operator ==(covariant DetailModel other) {
    if (identical(this, other)) return true;

    return other.image == image &&
        other.title == title &&
        other.uid == uid &&
        other.author == author;
  }

  @override
  int get hashCode =>
      image.hashCode ^ title.hashCode ^ author.hashCode ^ uid.hashCode;
}
