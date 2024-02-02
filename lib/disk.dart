/*
 * Copyright (c) 2020 Álan Crístoffer
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and / or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import 'package:flutter/material.dart';

class Disk extends StatefulWidget {
  final int _n;
  final int _total;

  const Disk(this._n, this._total, {Key? key}) : super(key: key);

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
