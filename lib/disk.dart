import 'package:flutter/material.dart';

class Disk extends StatefulWidget {
  final int _n;
  final int _total;

  const Disk(this._n, this._total, {Key key}) : super(key: key);

  @override
  _DiskState createState() => _DiskState(_n, _total);
}

class _DiskState extends State<Disk> {
  final int _n;
  final int _total;
  final _colors = const [
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.green,
    Colors.purple,
    Colors.orange,
    Colors.indigo,
    Colors.pink,
    Colors.amber,
    Colors.teal,
  ];

  _DiskState(this._n, this._total);

  @override
  Widget build(_) {
    return LayoutBuilder(
      builder: (_, BoxConstraints constraints) {
        return Container(
          decoration: BoxDecoration(
            color: _colors[widget._n - 1],
            borderRadius: BorderRadius.circular(16),
          ),
          width: constraints.maxWidth * _n / _total,
          height: 32,
        );
      },
    );
  }
}
