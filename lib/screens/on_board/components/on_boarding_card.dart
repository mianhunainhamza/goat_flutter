import 'package:flutter/material.dart';
import 'on_boarding_data.dart';

class OnBoardingCard extends StatefulWidget {
  final OnBoarding onBoardingModel;

  const OnBoardingCard({
    super.key,
    required this.onBoardingModel,
  });

  @override
  State<OnBoardingCard> createState() => _OnBoardingCardState();
}

class _OnBoardingCardState extends State<OnBoardingCard> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      widget.onBoardingModel.image,
      width: 100,
      fit: BoxFit.contain,
    );
  }
}

class OnboardingTextCard extends StatelessWidget {
  final OnBoarding onBoardingModel;

  const OnboardingTextCard({required this.onBoardingModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          onBoardingModel.title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Lora',
            fontSize: 27,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary
          ),
        ),
        const SizedBox(height: 16),
        Text(
          onBoardingModel.description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Lora',
            fontSize: 14,
            color: Theme.of(context).colorScheme.primary.withOpacity(.7),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}