// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quiz _$QuizFromJson(Map<String, dynamic> json) => Quiz(
      question: json['question'] as String,
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      correctAnswer: json['correctAnswer'] as String,
    );

Map<String, dynamic> _$QuizToJson(Quiz instance) => <String, dynamic>{
      'question': instance.question,
      'options': instance.options,
      'correctAnswer': instance.correctAnswer,
    };
