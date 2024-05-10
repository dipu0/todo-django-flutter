class ItemListResponse {
  ItemListResponse({
    bool? success,
    List<ItemData>? data,
    dynamic errorMessage,
  }) {
    _success = success;
    _data = data;
    _errorMessage = errorMessage;
  }

  ItemListResponse.fromJson(dynamic json) {
    _success = json['Success'];
    if (json['Data'] != null) {
      _data = [];
      json['Data'].forEach((v) {
        _data?.add(ItemData.fromJson(v));
      });
    }
    _errorMessage = json['ErrorMessage'];
  }

  bool? _success;
  List<ItemData>? _data;
  dynamic _errorMessage;

  ItemListResponse copyWith({
    bool? success,
    List<ItemData>? data,
    dynamic errorMessage,
  }) =>
      ItemListResponse(
        success: success ?? _success,
        data: data ?? _data,
        errorMessage: errorMessage ?? _errorMessage,
      );

  bool? get success => _success;

  List<ItemData>? get data => _data;

  dynamic get errorMessage => _errorMessage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Success'] = _success;
    if (_data != null) {
      map['Data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['ErrorMessage'] = _errorMessage;
    return map;
  }
}

class ItemData {
  int? _id;
  String? _title;
  String? _description;
  bool? _complete;
  String? _created;

  ItemData(
      {int? id,
        String? title,
        String? description,
        bool? complete,
        String? created}) {
    if (id != null) {
      this._id = id;
    }
    if (title != null) {
      this._title = title;
    }
    if (description != null) {
      this._description = description;
    }
    if (complete != null) {
      this._complete = complete;
    }
    if (created != null) {
      this._created = created;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get title => _title;
  set title(String? title) => _title = title;
  String? get description => _description;
  set description(String? description) => _description = description;
  bool? get complete => _complete;
  set complete(bool? complete) => _complete = complete;
  String? get created => _created;
  set created(String? created) => _created = created;

  ItemData.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _title = json['title'];
    _description = json['description'];
    _complete = json['complete'];
    _created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['title'] = this._title;
    data['description'] = this._description;
    data['complete'] = this._complete;
    data['created'] = this._created;
    return data;
  }
}
