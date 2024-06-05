import 'dart:async';

import 'package:flutter/material.dart';
import 'package:share/share.dart';
class QuizApp extends StatefulWidget {
  const QuizApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<QuizApp> {
  final List<Map<String, Object>> _questions = [
    {
      'questionText': 'What is the capital of Bangladesh?',
      'answers': [
        {'text': 'London', 'score': -5},
        {'text': 'Dhaka', 'score': 10},
        {'text': 'Berlin', 'score': -5},
        {'text': 'Paris', 'score': -5},
      ],
    },
    {
      'questionText': 'Which planet is known as the Red Planet?',
      'answers': [
        {'text': 'Earth', 'score': -5},
        {'text': 'Mars', 'score': 10},
        {'text': 'Jupiter', 'score': -5},
        {'text': 'Venus', 'score': -5},
      ],
    },
    {
      'questionText': 'What is the chemical symbol for gold?',
      'answers': [
        {'text': 'Ag', 'score': -5},
        {'text': 'Au', 'score': 10},
        {'text': 'Pb', 'score': -5},
        {'text': 'Fe', 'score': -5},
      ],
    },
    {
      'questionText': 'Who wrote "Romeo and Juliet"?',
      'answers': [
        {'text': 'Charles Dickens', 'score': -5},
        {'text': 'William Shakespeare', 'score': 10},
        {'text': 'Mark Twain', 'score': -5},
        {'text': 'Jane Austen', 'score': -5},
      ],
    },
    {
      'questionText': 'Which gas do plants absorb from the atmosphere?',
      'answers': [
        {'text': 'Oxygen', 'score': -5},
        {'text': 'Carbon Dioxide', 'score': 10},
        {'text': 'Nitrogen', 'score': -5},
        {'text': 'Hydrogen', 'score': -5},
      ],
    },
    {
      'questionText': 'What is the largest ocean on Earth?',
      'answers': [
        {'text': 'Atlantic Ocean', 'score': -5},
        {'text': 'Pacific Ocean', 'score': 10},
        {'text': 'Indian Ocean', 'score': -5},
        {'text': 'Arctic Ocean', 'score': -5},
      ],
    },
    {
      'questionText': 'Who painted the Mona Lisa?',
      'answers': [
        {'text': 'Leonardo da Vinci', 'score': 10},
        {'text': 'Vincent van Gogh', 'score': -5},
        {'text': 'Pablo Picasso', 'score': -5},
        {'text': 'Claude Monet', 'score': -5},
      ],
    },
    {
      'questionText': 'What is the smallest prime number?',
      'answers': [
        {'text': '2', 'score': 10},
        {'text': '1', 'score': -5},
        {'text': '3', 'score': 5},
        {'text': '5', 'score': -5},
      ],
    },
    {
      'questionText': 'Which element has the atomic number 1?',
      'answers': [
        {'text': 'Helium', 'score': -5},
        {'text': 'Hydrogen', 'score': 10},
        {'text': 'Oxygen', 'score': -5},
        {'text': 'Carbon', 'score': -5},
      ],
    },
    {
      'questionText': 'What is the square root of 144?',
      'answers': [
        {'text': '12', 'score': 10},
        {'text': '14', 'score': -5},
        {'text': '13', 'score': -5},
        {'text': '11', 'score': -5},
      ],
    },
  ];

  var _questionIndex = 0;
  var _totalScore = 0;
  Timer? _quizTimer;
  Timer? _questionTimer;
  final int _totalTime = 50; // Total quiz time in seconds
  final int _questionTime = 5; // Time for each question in seconds
  int _remainingTotalTime = 0;
  int _remainingQuestionTime = 0;
  int _selectedAnswerIndex = -1;

  @override
  void initState() {
    super.initState();
    _resetTimers();
  }

  void _resetTimers() {
    _remainingTotalTime = _totalTime;
    _remainingQuestionTime = _questionTime;
  }

  void _startQuiz() {
    _totalScore = 0;
    _questionIndex = 0;
    _selectedAnswerIndex = -1;
    _resetTimers();

    _quizTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          _remainingTotalTime -= 1;
        });
        if (_remainingTotalTime <= 0) {
          _endQuiz();
        }
      },
    );

    _questionTimer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          _remainingQuestionTime -= 1;
        });
        if (_remainingQuestionTime <= 0) {
          _nextQuestion();
        }
      },
    );
  }

  void _endQuiz() {
    _quizTimer?.cancel();
    _questionTimer?.cancel();
    setState(() {
      _questionIndex = _questions.length; // Ends the quiz
    });
  }

  void _nextQuestion() {
    if (_selectedAnswerIndex >= 0) {
      var answerScore = (_questions[_questionIndex]['answers']
          as List<Map<String, Object>>)[_selectedAnswerIndex]['score'] as int;
      _totalScore += answerScore;
    }
    setState(() {
      _questionIndex += 1;
      _remainingQuestionTime = _questionTime;
      _selectedAnswerIndex = -1;
    });

    if (_questionIndex >= _questions.length) {
      _endQuiz();
    }
  }

  void _shareResult() {
    Share.share("I scored $_totalScore in the quiz!");
  }

  void _selectAnswer(int index) {
    setState(() {
      _selectedAnswerIndex = index;
    });
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Quiz App'),
              Text(
                'Remaining quiz time: $_remainingTotalTime s',
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: _shareResult,
            ),
          ],
        ),
        body: _questionIndex < _questions.length
            ? Quiz(
                questions: _questions,
                questionIndex: _questionIndex,
                selectedAnswerIndex: _selectedAnswerIndex,
                answerQuestion: _selectAnswer,
                remainingTime: _remainingQuestionTime,
              )
            : Result(
                totalScore: _totalScore,
                resetQuiz: _startQuiz,
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: _startQuiz, // Reset and restart the quiz
          child: const Icon(Icons.start),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final int selectedAnswerIndex;
  final Function(int) answerQuestion;
  final int remainingTime;

  const Quiz({
    super.key,
    required this.questions,
    required this.questionIndex,
    required this.selectedAnswerIndex,
    required this.answerQuestion,
    required this.remainingTime,
  });

  @override
  Widget build(BuildContext context) {
    final question = questions[questionIndex];
    final answers = (question['answers'] as List<Map<String, Object>>);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          question['questionText'] as String,
          style: const TextStyle(fontSize: 20),
        ),
        ...answers.asMap().entries.map((entry) {
          int answerIndex = entry.key;
          var answer = entry.value;

          return ListTile(
            title: Text(answer['text'] as String),
            selected: answerIndex == selectedAnswerIndex,
            onTap: () => answerQuestion(answerIndex),
          );
        }),
        const SizedBox(height: 10),
        Text(
          'Remaining question time: $remainingTime s',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}

class Result extends StatelessWidget {
  final int totalScore;
  final Function resetQuiz;

  const Result({
    super.key,
    required this.totalScore,
    required this.resetQuiz,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Your total score is $totalScore',
          style: const TextStyle(fontSize: 20),
        ),
        ElevatedButton(
          onPressed: () => resetQuiz(),
          child: const Text('Restart Quiz'),
        ),
      ],
    );
  }
}
