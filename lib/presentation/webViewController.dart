import 'package:flutter/material.dart';
import 'package:nataraja_games/presentation/home_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewContainer extends StatefulWidget {
  final url;
  final String coinAmount;

  WebViewContainer(this.url, this.coinAmount);

  @override
  createState() => _WebViewContainerState(this.url);
}

class _WebViewContainerState extends State<WebViewContainer> {
  var _url;
  final _key = UniqueKey();

  _WebViewContainerState(this._url);

  @override
  void initState() {
    print("WebBalance ${widget.coinAmount}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          child: Padding(
            padding: EdgeInsets.only(top: 50),
            child: WebView(
                key: _key,
                javascriptMode: JavascriptMode.unrestricted,
                initialUrl: _url),
          ),
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: 20, right: 10),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen(coin: widget.coinAmount,)));
            },
          child: Icon(Icons.add),
    ),
        ),);
  }
}
