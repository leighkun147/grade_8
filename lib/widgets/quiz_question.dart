import 'package:flutter/material.dart';
import '../models/quiz.dart';

class QuizQuestion extends StatelessWidget {
  final Question question;
  final int? selectedAnswer;
  final Function(int) onAnswerSelected;

  const QuizQuestion({
    super.key,
    required this.question,
    required this.selectedAnswer,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                question.text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          ...List.generate(
            question.options.length,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: InkWell(
                onTap: () => onAnswerSelected(index),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: selectedAnswer == index
                          ? Theme.of(context).primaryColor
                          : Colors.grey[300]!,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    color: selectedAnswer == index
                        ? Theme.of(context).primaryColor.withOpacity(0.1)
                        : null,
                  ),
                  child: RadioListTile(
                    value: index,
                    groupValue: selectedAnswer,
                    onChanged: (value) => onAnswerSelected(value as int),
                    title: Text(
                      question.options[index],
                      style: TextStyle(
                        fontWeight: selectedAnswer == index
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                    activeColor: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
