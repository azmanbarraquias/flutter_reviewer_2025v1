// #17 - Dart Generics, Generic Types, Generic Classes, Generic Methods
// https://www.youtube.com/watch?v=q2PMQPV7JRg&list=PLptHs0ZDJKt_fLp8ImPQVc1obUJKDSQL7&index=18

void main() {
  // var tuple = TupleI(1, 2, 3);
  // print(tuple.first);
  // print(tuple.second);
  // print(tuple.third);
  //
  // var tuple2 = TupleI.fromListM([2, 3, 1]);
  // print(tuple2.first);
  // print(tuple2.second);
  // print(tuple2.third);
  //
  // var tuple3 = TupleI.fromListM([1, 2, 1]);
  // print(tuple3.first);
  // print(tuple3.second);
  // print(tuple3.third);
  //
  // var tupleSum = tuple2 + tuple3;
  // print(tupleSum.first);
  // print(tupleSum.second);
  // print(tupleSum.third);

  // var te1 = Tuple(1, 2, 3);
  // var te2 = Tuple(4, 3, 2);
  // var te3 = te1 + te2;
  // print(te3.first);
  // print(te3.second);
  // print(te3.third);

  var list = [1, 2, "A"];
  print(UtilsG.getItem(list, 0));
  print(UtilsG.getItem(list, 1));
  print(UtilsG.getItem(list, 2));
  print(UtilsG.getItem(list, 3));


  print(UtilsG.getItemD(list, 0));
  print(UtilsG.getItemD(list, 1));
  print(UtilsG.getItemD(list, 2));
  print(UtilsG.getItemD(list, 3));
}

class TupleI {
  final int? _a;
  final int? _b;
  final int? _c;

  TupleI(this._a, this._b, this._c);

  int? get first => _a;

  int? get second => _b;

  int? get third => _c;

  TupleI.fromList(List<int> list) : this(list[0], list[1], list[2]);

  TupleI.fromListM(List<int> list)
    : _a = list.asMap().containsKey(0) ? list[0] : null,
      _b = list.asMap().containsKey(1) ? list[1] : null,
      _c = list.asMap().containsKey(2) ? list[2] : null;

  TupleI operator +(TupleI t) => TupleI(_a! + t._a!, _b! + t._b!, _c! + t._c!);

  TupleI operator -(TupleI t) => TupleI(_a! - t._a!, _b! - t._b!, _c! - t._c!);
}

class Tuple<E extends num > {
  final E? _a;
  final E? _b;
  final E? _c;

  Tuple(this._a, this._b, this._c);

  E? get first => _a;

  E? get second => _b;

  E? get third => _c;

  Tuple.fromList(List<E> list) : this(list[0], list[1], list[2]);

  Tuple.fromListM(List<E> list)
    : _a = list.asMap().containsKey(0) ? list[0] : null,
      _b = list.asMap().containsKey(1) ? list[1] : null,
      _c = list.asMap().containsKey(2) ? list[2] : null;

  Tuple<num> operator +(Tuple<num> t) {
    if (this is Tuple<num>) {
      final thisAsTupleNum = this as Tuple<num>;
      return Tuple(
        thisAsTupleNum._a! + t._a!,
        thisAsTupleNum._b! + t._b!,
        thisAsTupleNum._c! + t._c!,
      );
    }
    return Tuple(0, 0, 0);
  }

  Tuple<num> operator -(Tuple<num> t) {
    if (this is Tuple<num>) {
      final thisAsTupleNum = this as Tuple<num>;
      return Tuple(
        thisAsTupleNum._a! - t._a!,
        thisAsTupleNum._b! - t._b!,
        thisAsTupleNum._c! - t._c!,
      );
    }
    return Tuple(0, 0, 0);
  }
}

class UtilsG {
  static T getItem<T>(List<T> list, int index) {
   return list.asMap().containsKey(index) ? list[index] : null as T;
  }

  static dynamic getItemD(List<dynamic> list, int index) {
    return list.asMap().containsKey(index) ? list[index] : null;
  }
}
