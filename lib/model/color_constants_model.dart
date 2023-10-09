class ColorConstantsModel {
  String? backgroundColor;
  String? textcolor1;
  String? textcolor2;
  String? appBarIconColor;

  ColorConstantsModel(
      {this.backgroundColor,
      this.textcolor1,
      this.textcolor2,
      this.appBarIconColor});

  ColorConstantsModel.fromJson(Map<String, dynamic> json) {
    backgroundColor = json['backgroundColor'];
    textcolor1 = json['textcolor1'];
    textcolor2 = json['textcolor2'];
    appBarIconColor = json['appBarIconColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['backgroundColor'] = this.backgroundColor;
    data['textcolor1'] = this.textcolor1;
    data['textcolor2'] = this.textcolor2;
    data['appBarIconColor'] = this.appBarIconColor;
    return data;
  }
}
