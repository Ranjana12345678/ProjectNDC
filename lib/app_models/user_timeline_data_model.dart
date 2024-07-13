class UserTimeLineDataModel {
  bool? status;
  List<Data>? data;

  UserTimeLineDataModel({this.status, this.data});

  UserTimeLineDataModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? userId;
  String? eventDate;
  String? eventType;
  String? eventDescription;
  String? eventSalary;
  String? eventField;
  String? eventName;

  Data(
      {this.userId,
        this.eventDate,
        this.eventType,
        this.eventDescription,
        this.eventSalary,
        this.eventField,
        this.eventName});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    eventDate = json['event_date'];
    eventType = json['event_type'];
    eventDescription = json['event_description'];
    eventSalary = json['event_salary'];
    eventField = json['event_field'];
    eventName = json['event_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['event_date'] = this.eventDate;
    data['event_type'] = this.eventType;
    data['event_description'] = this.eventDescription;
    data['event_salary'] = this.eventSalary;
    data['event_field'] = this.eventField;
    data['event_name'] = this.eventName;
    return data;
  }
}
