import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = 'WebSocket Demo';
    return MaterialApp(
      title: title,
      home: MyHomePage(
        title: title,
        channel: IOWebSocketChannel.connect(
            'wss://ws.coincap.io/prices?assets=bitcoin,ethereum'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final WebSocketChannel channel;

  MyHomePage({Key key, @required this.title, @required this.channel})
      : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            StreamBuilder(
              stream: widget.channel.stream,
              builder: (context, snapshot) {
                Map a = json.decode(snapshot.data);
                List<Coin> b = [];
                a.forEach((key, value) => b.add(Coin(name: key, price: value)));

                return Container(
                  height: 600,
                  width: double.infinity,
                  child: ListView.builder(
                    itemCount: b.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Container(
                          height: 20,
                          width: 200,
                          child: Row(
                            children: [
                              Text(b[index].name),
                              Text(b[index].price),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
                // return Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 24.0),
                //   child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
                // );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _sendMessage() {
    Map map = {
      "type": "hello",
      "apikey": "E6E0DE7D-1527-4EC7-8450-30FA4D9328D6",
      "heartbeat": false,
      "subscribe_data_type": ["exrate"],
      "subscribe_filter_asset_id": ["BTC"],
    };
    widget.channel.sink.add(json.encode(map));
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }
}

class Coin {
  final String name;
  final dynamic price;

  Coin({this.name, this.price});

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
      name: json['name'] as String,
      price: json['price'] as String,
    );
  }
}
