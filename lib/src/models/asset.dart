// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'tree.dart';

class Asset {
  String? gatewayId;
  String? id;
  String? locationId;
  String? name;
  String? parentId;
  String? sensorId;
  String? sensorType;
  String? status;
  List<Tree>? subTree;
  Asset({
    this.gatewayId,
    this.id,
    this.locationId,
    this.name,
    this.parentId,
    this.sensorId,
    this.sensorType,
    this.status,
    this.subTree,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'gatewayId': gatewayId,
      'id': id,
      'locationId': locationId,
      'name': name,
      'parentId': parentId,
      'sensorId': sensorId,
      'sensorType': sensorType,
      'status': status,
    };
  }

  factory Asset.fromJson(Map<String, dynamic> map) {
    return Asset(
      gatewayId: map['gatewayId'] != null ? map['gatewayId'] as String : null,
      id: map['id'] != null ? map['id'] as String : null,
      locationId:
          map['locationId'] != null ? map['locationId'] as String : null,
      name: map['name'] != null ? map['name'] as String : null,
      parentId: map['parentId'] != null ? map['parentId'] as String : null,
      sensorId: map['sensorId'] != null ? map['sensorId'] as String : null,
      sensorType:
          map['sensorType'] != null ? map['sensorType'] as String : null,
      status: map['status'] != null ? map['status'] as String : null,
    );
  }

  @override
  String toString() {
    return name!.toUpperCase();
  }
}
