class Operand {
  final int value;
  final bool isVisible;

  Operand(this.value, {this.isVisible = true});

  @override
  String toString() {
    return isVisible ? value.toString() : '_';
  }

  Operand copyWithVisible(bool visible) {
    return Operand(value, isVisible: visible);
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

  bool operator <(Object other) {
    if (other is Operand) {
      return value < other.value;
    } else if (other is int) {
      return value < other;
    } else {
      return false;
    }
  }

  bool operator >(Object other) {
    if (other is Operand) {
      return value > other.value;
    } else if (other is int) {
      return value > other;
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
