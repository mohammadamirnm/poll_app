// To parse this JSON data, do
//
//     final pollModel = pollModelFromJson(jsonString);

import 'dart:convert';

PollModel pollModelFromJson(String str) => PollModel.fromJson(json.decode(str));

String pollModelToJson(PollModel data) => json.encode(data.toJson());

class PollModel {
  PollModel({
    this.id,
    this.title,
    this.description,
    this.startedAt,
    this.endedAt,
    this.imageUrl,
    this.termsAndConditionsUrl,
    this.finishText,
    this.questions,
  });

  final String? id;
  final String? title;
  final String? description;
  final String? startedAt;
  final String? endedAt;
  final String? imageUrl;
  final String? termsAndConditionsUrl;
  final String? finishText;
  final List<QuestionModel>? questions;

  factory PollModel.fromJson(Map<String, dynamic> json) => PollModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        startedAt: json['startedAt'],
        endedAt: json['endedAt'],
        imageUrl: json['imageUrl'],
        termsAndConditionsUrl: json['termsAndConditionsUrl'],
        finishText: json['finishText'],
        questions: json['questions'] == null
            ? <QuestionModel>[]
            : List<QuestionModel>.from(json['questions']
                ?.map((dynamic x) => QuestionModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'startedAt': startedAt,
        'endedAt': endedAt,
        'imageUrl': imageUrl,
        'termsAndConditionsUrl': termsAndConditionsUrl,
        'finishText': finishText,
        'questions': questions == null
            ? <dynamic>[]
            : List<dynamic>.from(
                questions!.map((QuestionModel x) => x.toJson())),
      };
}

class QuestionModel {
  final String? id;
  final String? text;
  final String? type;
  final bool? required;
  final List<AnswerModel>? answers;

  QuestionModel({
    this.id,
    this.text,
    this.type,
    this.required,
    this.answers,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        id: json['id'],
        text: json['text'],
        type: json['type'],
        required: json['required'],
        answers: json['answers'] == null
            ? <AnswerModel>[]
            : List<AnswerModel>.from(
                json['answers']?.map((dynamic x) => AnswerModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'type': type,
        'required': required,
        'answers': answers == null
            ? <dynamic>[]
            : List<dynamic>.from(answers!.map((AnswerModel x) => x.toJson())),
      };
}

class AnswerModel {
  final String? text;
  final int? value;

  AnswerModel({
    this.text,
    this.value,
  });

  factory AnswerModel.fromJson(Map<String, dynamic> json) => AnswerModel(
        text: json['text'],
        value: json['value'],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'text': text,
        'value': value,
      };
}
