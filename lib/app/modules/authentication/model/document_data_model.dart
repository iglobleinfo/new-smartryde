class DocumentDataModel {
  int? id;
  String? name;
  int? size;
  String? key;
  String? url;
  String? modelType;
  int? modelId;
  int? projectId;
  int? typeId;
  String? createdOn;
  int? createdById;
  String? createdByName;
  String? createdByImage;


  DocumentDataModel(
      {this.id,
        this.name,
        this.size,
        this.key,
        this.url,
        this.modelType,
        this.modelId,
        this.projectId,
        this.typeId,
        this.createdOn,
        this.createdById,
        this.createdByName,
        this.createdByImage});

  DocumentDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    size = json['size'];
    key = json['key'];
    url = json['url'];
    modelType = json['model_type'];
    modelId = json['model_id'];
    projectId = json['project_id'];
    typeId = json['type_id'];
    createdOn = json['created_on'];
    createdById = json['created_by_id'];
    createdByName = json['created_by_name'];
    createdByImage = json['created_by_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['size'] = this.size;
    data['key'] = this.key;
    data['url'] = this.url;
    data['model_type'] = this.modelType;
    data['model_id'] = this.modelId;
    data['project_id'] = this.projectId;
    data['type_id'] = this.typeId;
    data['created_on'] = this.createdOn;
    data['created_by_id'] = this.createdById;
    data['created_by_name'] = this.createdByName;
    data['created_by_image'] = this.createdByImage;
    return data;
  }
}
