import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:political_cartoon_repository/political_cartoon_repository.dart';

class TestPagePage extends Page {
  TestPagePage() : super(key: const ValueKey('TestPagePage'));

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) => TestPage(),
      transitionDuration: const Duration(milliseconds: 0),
    );
  }
}

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late PoliticalCartoonRepository repo;
  // late Future<String> url;
  // late Stream<PoliticalCartoon> cartoon;

  @override
  void initState() {
    repo = FirestorePoliticalCartoonRepository();
    // cartoon = repo.getLatestPoliticalCartoon();
    // url = FirebaseStorage.instance.ref('rail-splitter.jpg').getDownloadURL();

    super.initState();
  }

  void onButtonClick(PoliticalCartoon cartoon) async {
    return repo.addNewPoliticalCartoon(cartoon);
  }

  @override
  Widget build(BuildContext context) {
    var testCartoon = PoliticalCartoon(
      published: Timestamp.now(),
      author: 'Test Cartoon',
      date: Timestamp.fromDate(
          DateTime.now().subtract(const Duration(minutes: 2))),
      description: 'This a cartoon description and this will be added on'
          ' later and more text to the container',
      tags: [Tag.tag3],
      downloadUrl:
          'https://images.unsplash.com/photo-1515966097209-ec48f3216288?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1950&q=80',
      type: ImageType.all
    );

    return Material(
      child: Column(
        children: [
          IconButton(
              icon: const Icon(Icons.description),
              onPressed: () => onButtonClick(testCartoon))
          // StreamBuilder<PoliticalCartoon>(
          //     stream: cartoon,
          //     builder: (context, snapshot) {
          //       if (snapshot.hasData) {
          //         return Image.network(snapshot.data!.downloadUrl);
          //       } else if (snapshot.hasError) {
          //         return Text(snapshot.error.toString());
          //       } else {
          //         return const CircularProgressIndicator();
          //       }
          //     }),
          // FutureBuilder<String>(
          //     future: url,
          //     builder: (context, snapshot) {
          //       if (snapshot.connectionState == ConnectionState.waiting) {
          //         return const CircularProgressIndicator();
          //       } else if (snapshot.hasData) {
          //         return Text(snapshot.data!);
          //       } else {
          //         print(snapshot.error);
          //         return const Text('error');
          //       }
          //     }),
        ],
      ),
    );
  }
}
