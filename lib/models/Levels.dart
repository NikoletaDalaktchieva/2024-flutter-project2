enum Levels {
  easy("Easy", 4, 60),
  medium("Medium", 8, 120),
  hard("Hard", 12, 180);

  final String name; // Dispaly name
  final int pairs; // Number of pairs of cards
  final double timeLimit; // Time allowed in seconds

  const Levels(this.name, this.pairs, this.timeLimit);
}
