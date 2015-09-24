library geoTest;

import './dartTest/dartTest.dart';

main() {
  new Module('Example Usage', [
    new Group('Vector:', [
      new Test('Constructor test', () {
        var v = new Vec(3, 7.0);
        expect.areEqual(v.x, 3);
        expect.areEqual(v.y, 7.0);
      }),
      new Test('Addition test', () {
        var a = new Vec(2, 5);
        var b = new Vec(3.0, 4.0);
        var c = a + b;
        expect.areEqual(c.x, 5.0);
        expect.areEqual(c.y, 9.0);
      }),
      new Test('Subtraction test', () {
        var a = new Vec(3, 7);
        var b = new Vec(5.0, 4.1);
        var c = a - b;
        expect.valuesEqual(c.x, -2, tolerance: 1e-4);
        expect.valuesEqual(c.y, 2.9, tolerance: 1e-4);
      }),
      new Test('Equality test', () {
        var a = new Vec(1.0, 2.0);
        var b = new Vec(1, 2);
        var c = new Vec(0.7, 3.2);
        expect.areEqual(a, b);
        expect.areUnequal(a, c);
      }),
      new Test('Scaling test', () {
        var a = (new Vec(24, -2));
        a.scaleBy(2);
        var b = new Vec(48, -4);
        expect.areEqual(a, b);
      }),
      new Test('Length test', () {
        var v = new Vec(3, 4);
        expect.areEqual(v.length, 5);
      }),
      new Test('Unit vector test', () {
        var u = new Vec(3, 4);
        var v = new Vec(0.6, 0.8);
        expect.areEqual(u.unitVector, v);
      }),
      new Test('Orthogonal test', () {
        var u = new Vec(3, 4);
        var v = new Vec(-0.8, 0.6);
        expect.areEqual(u.orthogonal, v);
      }),
    ]),
    new Group('Rect:', [
      new Test('Equality and constructor test.', () {
        var rectA = new Rect(2, 7, 4, 3);
        var rectB = new Rect(4, 3, 2, 7);
        assert(rectA == rectB);

        var pointA = new Vec(0, 1);
        var pointB = new Vec(2, 4);
        var rectP = new Rect.byCorners(pointA, pointB);
        var rectQ = new Rect(2, 1, 0, 4);
        assert(rectP == rectQ);
      }),
      new Test('xMin, xMax, yMin, yMax getters and setters.', () {
        var rect = new Rect(-3, 4, 2, 1);
        assert(rect.yMin == 1);
        rect.xMin = 7;
        assert(rect.xMin == 2);
        assert(rect.xMax == 7);
      }),
      new Test('Width and height getter test.', () {
        var rect = new Rect(7, 12, 4, 16);
        assert(rect.width == 3);
        assert(rect.height == 4);
      }),
      new Test('Contains test.', () {
        var rect = new Rect(-3, -2, 4, 11);
        var pointA = new Vec(1, 4);
        var pointB = new Vec(-2, 1);
        var pointC = new Vec(4, 11);
        var pointD = new Vec(-2, 6);
        expect.isTrue(rect.contains(pointA));
        expect.isTrue(rect.contains(pointB));
        expect.isTrue(rect.contains(pointC));
        expect.isTrue(rect.contains(pointD));
        var pointW = new Vec(-4, 2);
        var pointX = new Vec(-6, 12);
        var pointY = new Vec(2, 13);
        var pointZ = new Vec(5, 6);
        expect.isFalse(rect.contains(pointW));
        expect.isFalse(rect.contains(pointX));
        expect.isFalse(rect.contains(pointY));
        expect.isFalse(rect.contains(pointZ));
      }),
      new Test('Overlap test.', () {
        var rectA = new Rect(1, 2, 4, 8);
        var rectB = new Rect(2, 4, 8, 16);
        var rectC = new Rect(6, 12, 12, 24);
        expect.isTrue(rectA.overlaps(rectB));
        expect.isTrue(rectB.overlaps(rectA));
        expect.isTrue(rectB.overlaps(rectC));
        expect.isTrue(rectC.overlaps(rectB));
        expect.isFalse(rectA.overlaps(rectC));
        expect.isFalse(rectC.overlaps(rectA));
      }),
      new Test('Union test.', () {
        var rectA = new Rect(-1, -2, 4, 8);
        var rectB = new Rect(-4, 1, 8, 6);
        var rectC = new Rect(-4, -2, 8, 8);
        expect.isTrue(rectA.union(rectB) == rectC);
      }),
    ]),
    new Group('Line:', [
      new Test('Equality and constructor test.', () {
        var A = new Vec(-1, -2);
        var B = new Vec(4, 8);
        var lineP = new Line.fromAtoB(A, B);
        var lineQ = new Line(-1, -2, 4, 8);
        expect.areEqual(lineP, lineQ);
      }),
      new Test('Length test.', () {
        var line = new Line(1, 2, 4, 6);
        expect.areEqual(line.length, 5);
      }),
      new Test('Unit vector test.', () {
        var line = new Line(1, 2, 4, 6);
        expect.areEqual(line.unitVector, new Vec(0.6, 0.8));
      }),
      new Test('Bounding box test.', () {
        var lineP = new Line(3, 7, 6, 2);
        var lineQ = new Line(6, 7, 3, 2);
        expect.areEqual(lineP.boundingBox, lineQ.boundingBox);
      }),
      new Test('Intersection test.', () {
        Line p, q;
        Vec intersect;
        p = new Line(0, 2, 2, 0);
        q = new Line(0, 0, 2, 2);
        intersect = new Vec(1, 1);
        expect.areEqual(p.intersectWith(q), intersect);
        expect.areEqual(q.intersectWith(p), intersect);

        p = new Line(-2, -2, 1, 1);
        q = new Line(1, 1, 4, 0);
        intersect = new Vec(1, 1);
        expect.areEqual(p.intersectWith(q), intersect);
        expect.areEqual(q.intersectWith(p), intersect);

        p = new Line(0, 0, 4, 4);
        q = new Line(3, 2, 1, 0);
        intersect = null;
        expect.areEqual(p.intersectWith(q), intersect);
        expect.areEqual(q.intersectWith(p), intersect);

        p = new Line(0, 0, 0, 4);
        q = new Line(-2, 2, 2, 2);
        intersect = new Vec(0, 2);
        expect.areEqual(p.intersectWith(q), intersect);
        expect.areEqual(q.intersectWith(p), intersect);

        p = new Line(2, -8, 2, 8);
        q = new Line(0, 0, 4, 4);
        intersect = new Vec(2, 2);
        expect.areEqual(p.intersectWith(q), intersect);
        expect.areEqual(q.intersectWith(p), intersect);

        p = new Line(0, 4, 8, 4);
        q = new Line(2, 0, 4, 8);
        intersect = new Vec(3, 4);
        expect.areEqual(p.intersectWith(q), intersect);
        expect.areEqual(q.intersectWith(p), intersect);

        p = new Line(1, 2, 2, 3);
        q = new Line(0, 0, 4, 4);
        intersect = null;
        expect.areEqual(p.intersectWith(q), intersect);
        expect.areEqual(q.intersectWith(p), intersect);

        p = new Line(0, 0, 4, 4);
        q = new Line(1, 1, 2, 2);
        intersect = new Vec(1, 1);
        expect.areEqual(p.intersectWith(q), intersect);

        p = new Line(0, 1, 0, 3);
        q = new Line(0, 0, 0, 4);
        intersect = new Vec(0, 0);
        expect.areEqual(p.intersectWith(q), intersect);
      }),
      new Test('Underlying vector modification test', () {
        var line = new Line(0, 1, 7, 4);
        line.p1.x = 1;
        expect.areEqual(line.p1.x, 1);
      }),
      new Test('Elaborate onModified event test', () {
        bool modified = false;
        Line line = new Line(0, 1, 7, 4);
        line.p1.x = 2;
        line.onModified.addListener((e) {
          modified = true;
        });

        expect.isFalse(modified);
        line.p1.x = 1;
        expect.areEqual(line.p1.x, 1);
        expect.isTrue(modified);

        var point = line.p1;
        line.p1 = new Vec.zero();
        modified = false;
        point.x += 7;
        expect.isFalse(modified);
      }),
    ])
  ]);
}
