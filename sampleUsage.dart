library sampleUsage;

import 'dart:math';
import './dartTest/dartTest.dart';

// Example cat and dog classes for failing test.
class Cat {}
class Dog {}

// Example vector class to test our testing framework.
class Vector {
  final num x, y;
  Vector(this.x, this.y);

  // Returns the magnitude of this vector.
  num get magnitude => sqrt(x * x + y * y);

  // Returns true if the vectors are equal and false otherwise.
  bool operator ==(Vector b) => (x == b.x) && (y == b.y);

  // Returns a new vector that is the sum of the two vectors.
  Vector operator +(Vector b) => new Vector(x + b.x, y + b.y);
}


main() {
  new Module('Sample Usage', [
    new Group('Vector:', [
      new Test('Equality test', () {
        var v = new Vector(7, 4);
        var u = new Vector(7, 4);
        expect.areEqual(u, v);
      }),
      new Test('Addition test', () {
        var v = new Vector(1, 2);
        var u = new Vector(7, 5);
        var w = new Vector(8, 7);
        expect.areEqual(u + v, w);
      }),
      new Test('Magnitude test', () {
        var v = new Vector(3, 4);
        expect.areEqual(v.magnitude, 5);
      })
    ]),
    new Group('Failing Tests:', [
      new Test('Yes means no', () {
        expect.areEqual('yes', 'no');
      }),
      new Test('My cat is a dog', () {
        var myCat = new Cat();
        expect.isTrue(myCat is Dog);
      }),
    ])
  ]);
}
