import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'cache_data_manager.dart';
import 'models/comment_model.dart';
import 'remote_data_manager.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isConnected = true;

  Future<List<Comment>> getData() async {
    final _response = await DioHelper.get();
    if (_response != null) {
      debugPrint('hello from api');
      setState(() {
        _isConnected = true;
      });
      final List<Comment> _comments =
          List.from(_response.map((x) => Comment.fromJson(x)));
      return _comments;
    } else {
      debugPrint('hello from local storage');
      setState(() {
        _isConnected = false;
      });
      final _box = await LocalDataSource.openBox();
      return LocalDataSource.getComments(_box);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cache Example'),
      ),
      body: FutureBuilder<List<Comment>>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: [
                if (!_isConnected)
                  Container(
                    width: double.infinity,
                    color: Colors.black,
                    padding: const EdgeInsets.all(12),
                    child: const Center(
                      child: Text(
                        'No internet connection',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                Expanded(
                  child: ListView.separated(
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Comment _comment = snapshot.data[index];
                      return ListTile(
                        title: Text(_comment.name!),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
