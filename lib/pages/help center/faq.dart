import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class FAQScreen extends StatelessWidget {
  final List<FAQItem> faqItems = [
    FAQItem(
      question: 'Is Rocky Connect available on IOS?',
      answer:
          ' Rocky Connect IOS is currently under review and should be available from January 2024',
    ),
    FAQItem(
      question: 'Is Rocky Connect for WIU student?',
      answer:
          'Rocky Connect is a mobile app built to connect WIU students together and help them create easy transportation.',
    ),
    FAQItem(
      question: 'Can you be a rider and a driver?',
      answer:
          ' currently Rocky connect only permits one role per student email. Currently under review for multirole capabilities on the App',
    ),
    FAQItem(
      question: 'Can a rider login to a driver app?',
      answer:
          'Rocky Connect only allows riders access to Rider app, likewise on the driver app?',
    ),
    FAQItem(
      question: 'Is Rocky connect a paid app?',
      answer:
          'as a user on this app, you’re only required to pay for your trips. Rocky connect doesn’t charge students for using mobile application.',
    ),
    FAQItem(
      question: 'When is the next Update?',
      answer:
          ' Next software update will occur 01/01/24',
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
