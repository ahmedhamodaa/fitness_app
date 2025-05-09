import 'package:flutter_test/flutter_test.dart';

double calculateBMI(double weight, double height) {
  double heightInMeters = height / 100;
  return weight / (heightInMeters * heightInMeters);
}

void main() {
  test('BMI is calculated correctly', () {
    final weight = 60.0; // kg
    final height = 180.0; // cm

    final bmi = calculateBMI(weight, height);

    expect(bmi, closeTo(18.5, 0.01));
  });

  test('BMI handles zero height safely', () {
    expect(() => calculateBMI(70.0, 0), throwsA(isA<UnsupportedError>()));
  });
}
