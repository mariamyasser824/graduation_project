class LevelModel {
  final int number;
  final LevelState state;
  final int stars;

  LevelModel({required this.number, required this.state, required this.stars});
}

enum LevelState {
  locked, // 🔒 مقفول
  unlocked, // 🟣 مفتوح ولسه متلعبش
  inProgress, // 🟡 بدأ فيه
  completed, // ⭐ خلصه وعنده نجوم
}
