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
      default:
        return '';
    }
  }
}