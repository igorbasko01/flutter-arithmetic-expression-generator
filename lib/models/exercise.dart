import 'arithmetic_operation.dart';
import 'operand.dart';

class Exercise {
  final Operand operand1;
  final Operand operand2;
  final ArithmeticOperation operator;
  final Operand result;

  Exercise(this.operand1, this.operand2, this.operator, this.result);

  String asArithmeticString() {
    switch (operator) {
      case ArithmeticOperation.addition:
        return '$operand1 + $operand2 = $result';
      case ArithmeticOperation.subtraction:
        return '$operand1 - $operand2 = $result';
      case ArithmeticOperation.multiplication:
        return '$operand1 x $operand2 = $result';
      case ArithmeticOperation.division:
        return '$operand1 : $operand2 = $result';
    }
  }

  Operand? getHiddenOperand() {
    if (!operand1.isVisible) {
      return operand1;
    } else if (!operand2.isVisible) {
      return operand2;
    } else if (!result.isVisible) {
      return result;
    } else {
      return null;
    }
  }

  bool isCorrect() {
    switch (operator) {
      case ArithmeticOperation.addition:
        return operand1 + operand2 == result.value;
      case ArithmeticOperation.subtraction:
        return operand1 - operand2 == result.value;
      case ArithmeticOperation.multiplication:
        return operand1 * operand2 == result.value;
      case ArithmeticOperation.division:
        return operand1 ~/ operand2 == result.value;
    }
  }

  Exercise copyWithAllVisible() {
    return Exercise(
        operand1.copyWithVisible(true),
        operand2.copyWithVisible(true),
        operator,
        result.copyWithVisible(true));
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Exercise &&
          runtimeType == other.runtimeType &&
          operand1 == other.operand1 &&
          operand2 == other.operand2 &&
          operator == other.operator &&
          result == other.result;

  @override
  int get hashCode =>
      operand1.hashCode ^
      operand2.hashCode ^
      operator.hashCode ^
      result.hashCode;
}