import 'signalr.dart';

void main() {
  //print('Hello, World!');
  var x = new SignalRConnection();
  x.connect('test');
}