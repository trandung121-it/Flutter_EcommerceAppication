import 'package:equatable/equatable.dart';

class CustomerModel extends Equatable {
  String? id;
  String? type;
  String? name;
  String? username;
  String? email;
  int? userLength;
  String? dob;
  String? idCard;
  String? range;
  String? placeCreated;
  String? tel;
  String? vnid;
  String? idStatus;
  int? userType;

  CustomerModel({
    this.id,
    this.type,
    this.name,
    this.username,
    this.email,
    this.userLength,
    this.dob,
    this.idCard,
    this.range,
    this.placeCreated,
    this.tel,
    this.vnid,
    this.idStatus,
    this.userType,
  });

  CustomerModel.fromJson(Map json) {
    id = json['id'];
    type = json['type'];
    name = json['fullname'];
    username = json['username'];
    email = json['email'];
    userLength = json['user_length'];
    dob = json['dob'];
    idCard = json['id_card'];
    range = json['range'];
    placeCreated = json['place_created'];
    tel = json['tel'];
    vnid = json['vnid'];
    idStatus = json['id_status'];
    userType = json['user_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['name'] = this.name;
    data['email'] = this.email;
    data['user_length'] = this.userLength;
    data['dob'] = this.dob;
    data['id_card'] = this.idCard;
    data['range'] = this.range;
    data['place_created'] = this.placeCreated;
    data['tel'] = this.tel;
    data['vnid'] = this.vnid;
    data['id_status'] = this.idStatus;
    data['user_type'] = this.userType;
    return data;
  }

  @override
  List<Object?> get props => [
        id,
        type,
        name,
        email,
        userLength,
        dob,
        idCard,
        range,
        placeCreated,
        tel,
        vnid,
        idStatus,
        userType
      ];
}
