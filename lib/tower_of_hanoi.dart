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
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tower_of_hanoi/peg.dart';
import 'package:tower_of_hanoi/state.dart';

class TowerOfHanoi extends StatefulWidget {
  @override
  _TowerOfHanoiState createState() => _TowerOfHanoiState();
}

class _TowerOfHanoiState extends State<TowerOfHanoi> {
  TextEditingController _controller = TextEditingController(text: '5');

  @override
  Widget build(_) {
    return ChangeNotifierProvider(
      create: (_) => TowerState(int.parse(_controller.text)),
      child: Consumer<TowerState>(
        builder: (_, state, __) => LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Column(
              children: <Widget>[
                _header(state),
                _pegsArea(constraints),
                _base(constraints),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _header(TowerState state) {
    return Container(
      height: 48,
      child: Row(
        children: <Widget>[
          FlatButton(
            color: Colors.indigo,
            child: Text('Reset'),
            onPressed: () => state.reset(),
          ),
          Container(width: 8),
          FlatButton(
            color: Colors.indigo,
            child: state.stopped ? Text('Solve') : Text('Stop'),
            onPressed: () {
              if (state.stopped) {
                state.solve();
              } else {
                state.stop();
              }
            },
          ),
          Container(width: 8),
          Expanded(
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                final v = int.tryParse(value);
                if (v != null && v < 10) {
                  state.reset(v);
                }
              },
            ),
          ),
          Container(width: 8),
          Expanded(child: Text('Moves: ${state.moves}'))
        ],
      ),
    );
  }

  Widget _pegsArea(BoxConstraints constraints) {
    return Consumer<TowerState>(
      builder: (_, state, __) => Container(
        width: constraints.maxWidth,
        height: constraints.maxHeight - 32 - 48,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Peg(0.25 * constraints.maxWidth, 1),
            Peg(0.25 * constraints.maxWidth, 2),
            Peg(0.25 * constraints.maxWidth, 3),
          ],
        ),
      ),
    );
  }

  Container _base(BoxConstraints constraints) {
    return Container(
      width: constraints.maxWidth,
      height: 32,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.brown,
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
