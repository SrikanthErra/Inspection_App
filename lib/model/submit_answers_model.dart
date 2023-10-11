class SubmitAnswersModel {
  String? name;
  String? mobile;
  String? time;
  String? question;
  String? answer;
  String? answerPercent;
  String? questionId;

  SubmitAnswersModel(
      {this.name,
      this.mobile,
      this.time,
      this.question,
      this.answer,
      this.answerPercent,
      this.questionId});

  SubmitAnswersModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    mobile = json['mobile'];
    time = json['time'];
    question = json['Question'];
    answer = json['Answer'];
    questionId = json['QuestionId'];
    answerPercent = json['AnswerPercent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['mobile'] = this.mobile;
    data['time'] = this.time;
    data['Question'] = this.question;
    data['Answer'] = this.answer;
    data['AnswerPercent'] = this.answerPercent;
    data['QuestionId'] = this.questionId;
    return data;
  }
}
