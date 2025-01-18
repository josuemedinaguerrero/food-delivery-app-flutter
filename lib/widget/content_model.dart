class UnboardingModel {
  final String title;
  final String description;
  final String image;

  UnboardingModel({required this.title, required this.description, required this.image});
}

List<UnboardingModel> contents = [
  UnboardingModel(
    title: 'Pick your food from our menu \nMore than 35 times',
    description: 'Select from out \nBest Menu',
    image: 'images/screen1.png',
  ),
  UnboardingModel(
    title: 'You can pay cash on delivery and \nCard payment is available',
    description: 'Easy and Online Payment',
    image: 'images/screen2.png',
  ),
  UnboardingModel(
    title: 'Deliver your food at your \nDoorstep',
    description: 'Quick Delivery at your Doorstep',
    image: 'images/screen3.png',
  ),
];
