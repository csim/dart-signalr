import 'dart:io';
import 'dart:async';
import 'dart:convert';

class SignalRConnection {
  WebSocket _socket;

  SignalRConnection(WebSocket socket) {
    _socket = socket;
  }

  static Future<SignalRConnection> connect(String baseUrl, String authToken) {
    return SignalRConnection._negotiate(baseUrl).then((x) {
      return WebSocket.connect(baseUrl).then((socket) {
        var conn = new SignalRConnection(socket);
        conn._log('connected');
        socket.listen(conn._listen);

        return conn;
      });
    });

  }

  static Future _negotiate(String baseUrl) async {
    var u = baseUrl.replaceAll('wss:', 'https:');
    var url =
        '$u/signalr/negotiate?clientProtocol=1.5&connectionData=%5B%7B%22name%22%3A%22apphub%22%7D%2C%7B%22name%22%3A%22smshub%22%7D%5D';

    //body: JSON.encode({'test': 'value'})
    print(url);
    // http.get(url).then((response) {
    //   print("Response status: $response.statusCode");
    //   print("Response body: $response.body");
    // });

    var httpClient = new HttpClient();
    var uri = Uri.parse(url);
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    var responseBody = await response.transform(UTF8.decoder).join();

    print('******* _negotiate $baseUrl');
    print('******* _negotiate ${response.statusCode}');
    print(responseBody);
  }

  _listen(data) {
    print(data);
  }

  subscribe(String key) {}

  _log(String message) {
    print(message);
  }
}

class SignalRNegotiateResponse {
  String ConnectionId;
  int ConnectionTimeout;
  String ConnectionToken;
  int DisconnectTimeout;
  int KeepAliveTimeout;
  int LongPollDelay;
  String ProtocolVersion;
  int TransportConnectTimeout;
  bool TryWebSockets;
  String Url;
}
