enum ArithmeticOperation {
  addition,
  subtraction,
  multiplication,
  division;

  @override
  String toString() {
    switch (this) {
      case ArithmeticOperation.addition:
        return 'Addition';
      case ArithmeticOperation.subtraction:
        return 'Subtraction';
      case ArithmeticOperation.multiplication:
        return 'Multiplication';
      case ArithmeticOperation.division:
        return 'Division';
    }
  }
}