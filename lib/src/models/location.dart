class Location {
  String? id;
  String? name;
  String? parentId;
  List<String>? path;
  Location({
    this.id,
    this.name,
    this.parentId,
    this.path,
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

  @override
  String toString() {
    return '$name:$path';
  }
}
