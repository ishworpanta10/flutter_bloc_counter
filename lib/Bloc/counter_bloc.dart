import 'dart:async';

import 'package:bloc_demo/Bloc/counter_event.dart';

class CounterBlock {
  int _counter = 0;

  final _counterStateController = StreamController<int>();
  StreamSink<int> get _inCounter => _counterStateController.sink;
  //for state, exposing only a stream which outputs data
  Stream<int> get counter => _counterStateController.stream; //output stream

  final _counterEventController = StreamController<CounterEvent>();
  // for events, exposing only sink which is an input
  Sink<CounterEvent> get counterEventSink =>
      _counterEventController.sink; //input stream

  CounterBlock() {
    // when there is a new event we want to map it to new state
    _counterEventController.stream.listen(_mapEventToStream);
  }

  _mapEventToStream(CounterEvent event) {
    if (event is IncrementEvent)
      _counter++;
    else
      _counter--;
    _inCounter.add(_counter);
  }

  void dispose() {
    _counterStateController.close();
    _counterEventController.close();
  }
}
