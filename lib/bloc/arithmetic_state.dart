import 'package:arithmetic_expressions_generator/models/arithmetic_operation.dart';

sealed class ArithmeticState {}

class InitialArithmeticState extends ArithmeticState {}

class NewExerciseArithmeticState extends ArithmeticState {
  final Operand operand1;
  final Operand operand2;
  final ArithmeticOperation operator;
  final Operand result;

  NewExerciseArithmeticState(
      this.operand1, this.operand2, this.operator, this.result);

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

class Operand {
  final int value;
  final bool isVisible;

  Operand(this.value, {this.isVisible = true});

  @override
  String toString() {
    return isVisible ? value.toString() : '_';
  }

  bool operator <=(Object other) {
    if (other is Operand) {
      return value <= other.value;
    } else if (other is int) {
      return value <= other;
    } else {
      return false;
    }
  }

  bool operator >=(Object other) {
    if (other is Operand) {
      return value >= other.value;
    } else if (other is int) {
      return value >= other;
    } else {
      return false;
    }
  }

  int operator ~/ (Object other) {
    if (other is Operand) {
      return value ~/ other.value;
    } else if (other is int) {
      return value ~/ other;
    } else {
      return 0;
    }
  }

  int operator +(Object other) {
    if (other is Operand) {
      return value + other.value;
    } else if (other is int) {
      return value + other;
    } else {
      return 0;
    }
  }

  int operator -(Object other) {
    if (other is Operand) {
      return value - other.value;
    } else if (other is int) {
      return value - other;
    } else {
      return 0;
    }
  }

  int operator *(Object other) {
    if (other is Operand) {
      return value * other.value;
    } else if (other is int) {
      return value * other;
    } else {
      return 0;
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    if (other is Operand) {
      return value == other.value && isVisible == other.isVisible;
    } else if (other is int) {
      return value == other;
    } else {
      return false;
    }
  }

  @override
  int get hashCode => value.hashCode ^ isVisible.hashCode;

}
