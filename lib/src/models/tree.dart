// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'asset.dart';
import 'location.dart';

enum TreeType {
  location,
  asset,
  component,
}

class Tree {
  String? id;
  String? name;
  String? parentId;

  String? gatewayId;
  String? locationId;
  String? sensorId;
  String? sensorType;
  String? status;
  TreeType? treeType;
  List<Tree>? child;
  List<Tree>? parent;
  List<String>? path;
  Tree({
    this.id,
    this.name,
    this.parentId,
    this.gatewayId,
    this.locationId,
    this.sensorId,
    this.sensorType,
    this.status,
    this.treeType,
    this.child,
    this.path,
  });

  factory Tree.fromLocation(Location location, {List<String>? paths}) {
    return Tree(
      id: location.id,
      name: location.name,
      parentId: location.parentId,
      treeType: TreeType.location,
      path: paths,
    );
  }

  factory Tree.fromAsset(Asset asset, {List<String>? paths}) {
    return Tree(
      gatewayId: asset.gatewayId,
      id: asset.id,
      locationId: asset.locationId,
      name: asset.name,
      parentId: asset.parentId,
      sensorId: asset.sensorId,
      sensorType: asset.sensorType,
      status: asset.status,
      treeType: asset.sensorType != null ? TreeType.component : TreeType.asset,
      path: paths,
    );
  }

  @override
  String toString() {
    return 'Tree(id: $id, name: $name, parentId: $parentId, gatewayId: $gatewayId, locationId: $locationId, sensorId: $sensorId, sensorType: $sensorType, status: $status, subTree: $child, path: $path)';
  }

  Tree copyWith({
    String? id,
    String? name,
    String? parentId,
    String? gatewayId,
    String? locationId,
    String? sensorId,
    String? sensorType,
    String? status,
    List<Tree>? subTree,
    List<String>? path,
  }) {
    return Tree(
      id: id ?? this.id,
      name: name ?? this.name,
      parentId: parentId ?? this.parentId,
      gatewayId: gatewayId ?? this.gatewayId,
      locationId: locationId ?? this.locationId,
      sensorId: sensorId ?? this.sensorId,
      sensorType: sensorType ?? this.sensorType,
      status: status ?? this.status,
      child: subTree ?? this.child,
      path: path ?? this.path,
    );
  }
}
