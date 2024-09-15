class Company {
  String? id;
  String? name;
  Company({
    this.id,
    this.name,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory Company.fromJson(Map<String, dynamic> map) {
    return Company(
      id: map['id'] != null ? map['id'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
    );
  }
}
