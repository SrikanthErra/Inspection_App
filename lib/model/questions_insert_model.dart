class QuestionsInsertModel {
  String? s25;
  String? s50;
  String? s75;
  String? s100;
  String? question;

  QuestionsInsertModel(
      {this.s25, this.s50, this.s75, this.s100, this.question});

  QuestionsInsertModel.fromJson(Map<String, dynamic> json) {
    s25 = json['25'];
    s50 = json['50'];
    s75 = json['75'];
    s100 = json['100'];
    question = json['question'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['25'] = this.s25;
    data['50'] = this.s50;
    data['75'] = this.s75;
    data['100'] = this.s100;
    data['question'] = this.question;
    return data;
  }
}
