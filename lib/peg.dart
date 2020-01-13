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
import 'package:provider/provider.dart';
import 'package:tower_of_hanoi/disk.dart';
import 'package:tower_of_hanoi/state.dart';

class Peg extends StatefulWidget {
  final double width;
  final int peg;

  Peg(this.width, this.peg, {Key key}) : super(key: key);

  @override
  _PegState createState() => _PegState();
}

class _PegState extends State<Peg> {
  @override
  Widget build(_) {
    return Consumer<TowerState>(
      builder: (_, state, __) => LayoutBuilder(
        builder: (_, BoxConstraints constraints) {
          return DragTarget<int>(
            builder: (_, incoming, __) {
              if (incoming.isNotEmpty) {
                return _body(constraints, state, true, state.size);
              } else {
                return _body(constraints, state, false, state.size);
              }
            },
            onWillAccept: (n) {
              return state.pegs[widget.peg].top > n ||
                  state.pegs[widget.peg].top == 0;
            },
            onAccept: (n) => state.move(n, widget.peg),
          );
        },
      ),
    );
  }

  Container _body(
    BoxConstraints constraints,
    TowerState state,
    bool lighter,
    int size,
  ) {
    return Container(
      width: widget.width,
      height: constraints.maxHeight,
      child: Stack(
        children: <Widget>[
          _pole(constraints, lighter),
          Column(
            verticalDirection: VerticalDirection.up,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: _disks(state.pegs[widget.peg], size),
          ),
        ],
      ),
    );
  }

  List<Widget> _disks(PegState state, int size) {
    return state.stack
        .map((d) {
          if (d == state.top) {
            return Draggable<int>(
              data: d,
              child: Disk(d, size, key: Key('Disk $d')),
              childWhenDragging: Container(),
              feedback: Container(
                width: widget.width * d / size,
                child: Disk(d, size, key: Key('Disk $d')),
              ),
            );
          } else {
            return Disk(d, size, key: Key('Disk $d'));
          }
        })
        .map((w) => Container(alignment: Alignment.center, child: w))
        .toList();
  }

  Widget _pole(BoxConstraints constraints, [bool lighter = false]) {
    return Positioned(
      top: 64,
      bottom: -15,
      left: (widget.width - 16) / 2,
      child: Container(
        width: 16,
        height: constraints.maxHeight,
        decoration: BoxDecoration(
          color: lighter ? Colors.blueGrey : Colors.brown,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
