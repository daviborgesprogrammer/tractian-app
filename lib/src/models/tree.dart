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
  List<Tree>? subTree;
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
    this.subTree,
  });

  factory Tree.fromLocation(Location location) {
    return Tree(
      id: location.id,
      name: location.name,
      parentId: location.parentId,
      treeType: TreeType.location,
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
    );
  }
}
