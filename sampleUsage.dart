library sampleUsage;

import './dartTest/dartTest.dart';

class Sky {
  static bool get isBlue => true;
}

class Dog {
  static bool get isMansBestFriend => true;
}

class Cat {
  static num get numLives => 9;
}

main() {
  new Module('Sample Usage', [
    new Group('Test Group A:', [
      new Test('The sky is blue', () {
        expect.isTrue(Sky.isBlue);
      }),
      new Test('Yes means no', () {
        expect.areEqual('yes', 'no');
      }),
      new Test('A dog is a man\'s best friend', () {
        expect.isTrue(Dog.isMansBestFriend);
      }),
    ]),
    new Group('Test Group B:', [
      new Test('A cat has nine lives', () {
        expect.areEqual(Cat.numLives, 9);
      }),
      new Test('My cat is a dog', () {
        var myCat = new Cat();
        expect.isTrue(myCat is Dog);
      }),
    ])
  ]);
}
