import 'signalr.dart';

void main() {
  //print('Hello, World!');
  var connection = SignalRConnection.connect('wss://csim.ngrok.io/signalr/connect');

}