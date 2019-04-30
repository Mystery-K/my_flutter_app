void main() {
  // const n = 123;
  // assert(n == 11111);
  // const s = 'aaa'
  //     'bbb';
  // final a = [1, 2, 3];
  // a.add(4);
  // print(s ?? 'a');
  // void doStuff(
  //     {List<int> list = const [1, 2, 3],
  //     Map<String, String> gifts = const {
  //       'first': 'paper',
  //       'second': 'cotton',
  //       'third': 'leather'
  //     }}) {
  //   print('list:  $list');
  //   print('gifts: $gifts');
  // }
  // doStuff();
  // final callbacks = [];
  // for (var i = 0; i < 2; i++) {
  //   callbacks.add(() => print(i));
  // }
  // callbacks.forEach((c) => c());
  // Person(name: 'kw').report();
  // Person('kw', 2).report();
  Student('kw', 100).report();
}

class Person {
  final String name;
  final num id;
  final num age;
  Person(this.name, [this.id = 1, this.age = 10]);
  void report() {
    print('$name id: $id age:$age');
  }
}

class Student extends Person {
  final String name;
  final num grades;
  Student(this.name, this.grades) : super(name);

  @override
  void report() {
    // TODO: implement report
    super.report();
    print('grades:$grades');
  }
}
