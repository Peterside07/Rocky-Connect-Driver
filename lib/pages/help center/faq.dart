import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class FAQScreen extends StatelessWidget {
  final List<FAQItem> faqItems = [
    FAQItem(
      question: 'What is Lorem Ipsum?',
      answer:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
    ),
    FAQItem(
      question: 'What is Lorem Ipsum?',
      answer:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
    ),
    FAQItem(
      question: 'What is Lorem Ipsum?',
      answer:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
    ),
    FAQItem(
      question: 'What is Lorem Ipsum?',
      answer:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
    ),
    FAQItem(
      question: 'What is Lorem Ipsum?',
      answer:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
    ),
    FAQItem(
      question: 'What is Lorem Ipsum?',
      answer:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
    ),
  ];

  FAQScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.PRIMARY_COLOR_LIGHT,
      appBar: AppBar(
        centerTitle: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(40),
        )),
        title: const Text(
          'FAQ ',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.PRIMARY_COLOR,
      ),
      body: Center(
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: faqItems.map((item) {
            return ExpansionTile(
              title: Text(
                item.question,
                style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    item.answer,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}

class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});
}
