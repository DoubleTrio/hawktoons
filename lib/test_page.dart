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
      author: '',
      timestamp: Timestamp.fromDate(
        DateTime.now().subtract(const Duration(minutes: 2))),
      description: 'Map of the election of 1860',
      tags: [Tag.tag5, Tag.tag19],
      downloadUrl: 'https://firebasestorage.googleapis.com/v0/b/daily-political-cartoon.appspot.com/o/election_of_1860_map.jpg?alt=media&token=9915d509-7c27-4112-90b9-5981d0fa3be2',
      type: ImageType.infographic
    );

    return SafeArea(
      child: Material(
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
      ),
    );
  }
}
