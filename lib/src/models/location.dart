// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'tree.dart';

class Location {
  String? id;
  String? name;
  String? parentId;
  List<Tree>? subTree;
  Location({
    this.id,
    this.name,
    this.parentId,
    this.subTree,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'parentId': parentId,
    };
  }

  factory Location.fromJson(Map<String, dynamic> map) {
    return Location(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      parentId: map['parentId'] != null ? map['parentId'] as String : null,
    );
  }
}
