class CovidBedData {
	List<Fields>? fields;
	List<dynamic>? data;

	CovidBedData({this.fields, this.data});

	CovidBedData.fromJson(Map<String, dynamic> json) {
		if (json['fields'] != null) {
			fields = <Fields>[];
			json['fields'].forEach((v) { fields!.add(new Fields.fromJson(v)); });
		}
		if (json['data'] != null) {
			data =
			json['data'];
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.fields != null) {
      data['fields'] = this.fields!.map((v) => v.toJson()).toList();
    }
		if (this.data != null) {
      data['data'] = this.data;
    }
		return data;
	}
}

class Fields {
	String? id;
	String? label;
	String? type;

	Fields({this.id, this.label, this.type});

	Fields.fromJson(Map<String, dynamic> json) {
		id = json['id'];
		label = json['label'];
		type = json['type'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = this.id;
		data['label'] = this.label;
		data['type'] = this.type;
		return data;
	}
}

