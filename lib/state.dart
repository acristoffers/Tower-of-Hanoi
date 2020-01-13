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

class TowerState extends ChangeNotifier {
  TowerState(int size) {
    _pegs = {
      1: PegState(init: true, npegs: size),
      2: PegState(),
      3: PegState(),
    };
  }

  Map<int, PegState> _pegs;
  Map<int, PegState> get pegs => _pegs;
  int get size {
    return pegs.values.map((p) => p.stack.length).fold(0, (a, b) => a + b);
  }

  bool _running = false;
  bool get stopped => !_running;
  void stop() => _running = false;

  int _moves = 0;
  int get moves => _moves;

  void move(n, to) {
    if (pegs[1].stack.contains(n)) {
      pegs[1].stack.removeLast();
      pegs[to].stack.add(n);
    } else if (pegs[2].stack.contains(n)) {
      pegs[2].stack.removeLast();
      pegs[to].stack.add(n);
    } else {
      pegs[3].stack.removeLast();
      pegs[to].stack.add(n);
    }

    _moves++;

    notifyListeners();
  }

  void reset([int size]) {
    _moves = 0;
    _running = false;
    _pegs = {
      1: PegState(init: true, npegs: size != null ? size : this.size),
      2: PegState(),
      3: PegState(),
    };
    notifyListeners();
  }

  void solve() {
    reset();
    _running = true;
    Future(() async => await _move(1, 3)).whenComplete(() {
      _running = false;
      notifyListeners();
    });
  }

  Future<void> _move(int o, int d, [int n]) async {
    if (n == null) n = pegs[o].stack.length;
    int v = 6 - o - d;
    if (n != 0) {
      if (_running) await _move(o, v, n - 1);
      if (_running) move(pegs[o].top, d);
      await Future.delayed(Duration(milliseconds: 200));
      if (_running) await _move(v, d, n - 1);
    }
  }
}

class PegState {
  var _stack = <int>[];

  PegState({init = false, npegs = 5}) {
    if (init) {
      _stack = List.generate(npegs, (i) => npegs - i);
    }
  }

  List<int> get stack => _stack;
  int get top => _stack.isEmpty ? 0 : _stack.last;
  int get bottom => _stack.isEmpty ? 0 : _stack.first;
}
