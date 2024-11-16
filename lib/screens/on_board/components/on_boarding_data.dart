class OnBoarding {
  String title;
  String description;
  String image;

  OnBoarding({
    required this.title,
    required this.description,
    required this.image,
  });
}

List<OnBoarding> onBoardinglist = [
  OnBoarding(
    title: "Welcome to Goat",
    image: 'assets/images/golf.jpg',
    description:
    'Book your golf tee times effortlessly with Goat. Simplifying your golfing experience, whether you’re a pro or a beginner.',
  ),
];
