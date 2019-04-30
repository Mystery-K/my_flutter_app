import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build');

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      // debugShowCheckedModeBanner: false,
    );
  }
}

Future fetchApi(String uri) async {
  final HttpClient client = HttpClient();
  var result;
  try {
    final HttpClientRequest request = await client.getUrl(Uri.parse(uri));
    final HttpClientResponse response = await request.close();
    if (response.statusCode == HttpStatus.ok) {
      result = json.decode(await response.transform(utf8.decoder).join());
    }
  } catch (e) {
    result = e;
  }
  client.close();
  return result;
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List _streamData = [];

  void _incrementCounter() {
    setState(() {
      _counter++;
      print(_counter);
    });
  }

  Future<void> _fetchStream() async {
    final _res = await fetchApi(
        'https://i16-tb.sgsnssdk.com/api/723/stream?category=391&category_parameter=&is_preload=0&count=20&min_behot_time=1.556011701999E9&sign=9d8f71b264d6f72ff953f854542fcb530d3b1577&timestamp=1556012084&logo=helo&session_impr_id=0&gender=0&bv_is_auto_play=0&youtube=0&manifest_version_code=223&app_version=2.2.3&iid=6680773317588633346&original_channel=local_test&channel=local_test&device_type=MI%208&language=hi&app_version_minor=2.2.3.02&resolution=2028*1080&openudid=08ed61b7e8fd566a&update_version_code=2230&sys_language=zh&sys_region=cn&os_api=28&tz_name=Asia%2FShanghai&tz_offset=28800&dpi=440&brand=Xiaomi&ac=WIFI&device_id=6647361290569385474&os=android&os_version=9&version_code=223&hevc_supported=1&device_brand=Xiaomi&device_platform=android&sim_region=&region=in&aid=1342&ui_language=en');

    setState(() {
      _streamData = _res['data']['items'];
    });
    print(_res);
  }

  @override
  void initState() {
    super.initState();
    _fetchStream();
    setState(() {
      _counter = 4;
    });
  }

  Widget _buildFeed(BuildContext context) {
    if (_streamData.length != 0) {
      return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: _streamData.length,
        itemBuilder: (context, i) {
          return _buildFeedItem(_streamData[i], i);
        },
      );
    } else {
      return CupertinoActivityIndicator();
    }
  }

  Widget _buildFeedItem(item, i) {
    return Card(
      child: Container(
        margin: EdgeInsets.all(4.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                margin: EdgeInsets.only(left: 8.0),
                height: 150,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item['name'] ?? 'kw',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                      maxLines: 1,
                    ),
                    Text(
                      item['title'] ?? 'test',
                      style: TextStyle(fontSize: 16.0),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(color: Colors.black)),
        backgroundColor: new Color(0xfff8faf8),
        centerTitle: true,
        // elevation: 1.0,
      ),
      body: _buildFeed(context),
      // body: Text('$_counter'),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
