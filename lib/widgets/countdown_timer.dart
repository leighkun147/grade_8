import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimer extends StatefulWidget {
  const CountdownTimer({super.key});

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late Timer _timer;
  late DateTime _examDate;
  late Duration _timeLeft;

  @override
  void initState() {
    super.initState();
    // TODO: Get actual exam date from configuration
    _examDate = DateTime(2024, 6, 1); // Example date
    _calculateTimeLeft();
    _startTimer();
  }

  void _calculateTimeLeft() {
    final now = DateTime.now();
    _timeLeft = _examDate.difference(now);
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _calculateTimeLeft();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Time Until National Exam',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTimeUnit('Days', _timeLeft.inDays),
                _buildDivider(),
                _buildTimeUnit(
                    'Hours', _timeLeft.inHours.remainder(24)),
                _buildDivider(),
                _buildTimeUnit(
                    'Minutes', _timeLeft.inMinutes.remainder(60)),
                _buildDivider(),
                _buildTimeUnit(
                    'Seconds', _timeLeft.inSeconds.remainder(60)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeUnit(String label, int value) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value.toString().padLeft(2, '0'),
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return const Text(
      ':',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
