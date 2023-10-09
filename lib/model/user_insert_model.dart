class UserInsertModel {
  String? name;
  String? mobileNumber;
  String? mpin;
  String? memberType;

  UserInsertModel({this.name, this.mobileNumber, this.mpin, this.memberType});

  UserInsertModel.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    mobileNumber = json['mobileNumber'];
    mpin = json['mpin'];
    memberType = json['memberType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Name'] = this.name;
    data['mobileNumber'] = this.mobileNumber;
    data['mpin'] = this.mpin;
    data['memberType'] = this.memberType;
    return data;
  }
}
