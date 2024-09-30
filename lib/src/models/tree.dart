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
  bool expanded;
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
    this.expanded = true,
  });

  factory Tree.fromLocation(Location location) {
    return Tree(
      id: location.id,
      name: location.name,
      parentId: location.parentId,
      treeType: TreeType.location,
      path: location.path,
    );
  }

  factory Tree.fromAsset(Asset asset) {
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
      path: asset.path,
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
      id: id ?? id,
      name: name ?? name,
      parentId: parentId ?? parentId,
      gatewayId: gatewayId ?? gatewayId,
      locationId: locationId ?? locationId,
      sensorId: sensorId ?? sensorId,
      sensorType: sensorType ?? sensorType,
      status: status ?? status,
      child: subTree ?? child,
      path: path ?? path,
    );
  }
}
