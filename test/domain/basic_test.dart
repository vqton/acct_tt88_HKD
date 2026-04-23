import 'package:flutter_test/flutter_test.dart';
import 'package:equatable/equatable.dart';

class SoTien extends Equatable {
  final int value;
  const SoTien(this.value);
  
  @override
  List<Object?> get props => [value];
}

void main() {
  group('Basic Entity Test - verify test infrastructure', () {
    test('Equatable should work', () {
      final a = SoTien(100);
      final b = SoTien(100);
      expect(a, equals(b));
    });
  });
}