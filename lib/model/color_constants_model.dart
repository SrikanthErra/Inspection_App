class ColorConstantsModel {
  String? backgroundColor;
  String? background1;
  String? background2;
  String? textcolor1;
  String? textcolor2;
  String? appBarIconColor;

  ColorConstantsModel(
      {this.backgroundColor,
      this.background1,
      this.background2,
      this.textcolor1,
      this.textcolor2,
      this.appBarIconColor});

  ColorConstantsModel.fromJson(Map<String, dynamic> json) {
    backgroundColor = json['backgroundColor'];
    background1 = json['background1'];
    background2 = json['background2'];
    textcolor1 = json['textcolor1'];
    textcolor2 = json['textcolor2'];
    appBarIconColor = json['appBarIconColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['backgroundColor'] = this.backgroundColor;
    data['background1'] = this.background1;
    data['background2'] = this.background2;
    data['textcolor1'] = this.textcolor1;
    data['textcolor2'] = this.textcolor2;
    data['appBarIconColor'] = this.appBarIconColor;
    return data;
  }
}
