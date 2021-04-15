// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:history_app/l10n/l10n.dart';
// import 'package:history_app/utils/utils.dart';
// import 'package:political_cartoon_repository/political_cartoon_repository.dart';
//
// class TestPage extends StatefulWidget {
//   @override
//   _TestPageState createState() => _TestPageState();
// }
//
// class _TestPageState extends State<TestPage> {
//   late PoliticalCartoonRepository repo;
//   // late Future<String> url;
//   // late Stream<PoliticalCartoon> cartoon;
//
//   @override
//   void initState() {
//     repo = FirestorePoliticalCartoonRepository();
//     // cartoon = repo.getLatestPoliticalCartoon();
//     // url = FirebaseStorage.instance.ref('rail-splitter.jpg').getDownloadURL();
//
//     super.initState();
//   }
//
//   void onButtonClick(PoliticalCartoon cartoon) async {
//     return repo.addNewPoliticalCartoon(cartoon);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final l10n = context.l10n;
//     final locale = Platform.localeName;
//     var testCartoon = PoliticalCartoon(
//         published: Timestamp.now(),
//         timeConverter: TimeAgo(l10n: l10n, locale: locale),
//         id: '5',
//         author: 'Test Cartoon',
//         date: Timestamp.fromDate(
//             DateTime.now().subtract(const Duration(minutes: 2))),
//         description: 'This a cartoon description and this will be added on'
//             ' later and more text to the container',
//         unit: unit.unit3,
//         downloadUrl:
//             'https://images.unsplash.com/photo-1515966097209-ec48f3216288?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=1950&q=80');
//
//     return Material(
//       child: Column(
//         children: [
//           IconButton(
//               icon: const Icon(Icons.description),
//               onPressed: () => onButtonClick(testCartoon))
//           // StreamBuilder<PoliticalCartoon>(
//           //     stream: cartoon,
//           //     builder: (context, snapshot) {
//           //       if (snapshot.hasData) {
//           //         return Image.network(snapshot.data!.downloadUrl);
//           //       } else if (snapshot.hasError) {
//           //         return Text(snapshot.error.toString());
//           //       } else {
//           //         return const CircularProgressIndicator();
//           //       }
//           //     }),
//           // FutureBuilder<String>(
//           //     future: url,
//           //     builder: (context, snapshot) {
//           //       if (snapshot.connectionState == ConnectionState.waiting) {
//           //         return const CircularProgressIndicator();
//           //       } else if (snapshot.hasData) {
//           //         return Text(snapshot.data!);
//           //       } else {
//           //         print(snapshot.error);
//           //         return const Text('error');
//           //       }
//           //     }),
//         ],
//       ),
//     );
//   }
// }

// class TestWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return       Column(
//       key: const Key('DailyCartoonPage_DailyCartoonLoaded_card'),
//       mainAxisAlignment: MainAxisAlignment.start,
//       children: [
//         Text(l10n.dailyCartoonTitle),
//         Container(
//           constraints: BoxConstraints(maxWidth: size.width * 0.8),
//           decoration: BoxDecoration(
//             borderRadius: const BorderRadius.all(Radius.circular(10)),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black54.withOpacity(0.5),
//                 spreadRadius: 5,
//                 blurRadius: 7,
//                 offset: const Offset(0, 4), // changes position of shadow
//               ),
//             ],
//           ),
//           child: ClipRRect(
//               borderRadius: const BorderRadius.all(Radius.circular(10)),
//               child: Image.asset('assets/images/unit5/rail-splitter.jpg')),
//         ),
//         Text(state.dailyCartoon.date.toDate().toIso8601String())
//       ],
//     );
//   }
// }

// class CartoonCard extends StatelessWidget {
//   CartoonCard({required this.cartoon});
//
//   final PoliticalCartoon cartoon;
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Container(
//         decoration: BoxDecoration(
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black54.withOpacity(0.4),
//                 spreadRadius: 1,
//                 blurRadius: 3,
//                 offset: const Offset(3, 4), // changes position of shadow
//               ),
//             ],
//             borderRadius: const BorderRadius.all(Radius.circular(12))),
//         constraints: BoxConstraints(minHeight: size.height * 0.2),
//         width: size.width * 0.9,
//         height: size.height * 0.2,
//         child: ClipRRect(
//             borderRadius: const BorderRadius.all(Radius.circular(12)),
//             child: Row(
//               children: [
//                 Expanded(
//                   flex: 5,
//                   child: Container(
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                             image: NetworkImage(cartoon.downloadUrl),
//                             fit: BoxFit.cover),
//                       )),
//                 ),
//                 Expanded(
//                     flex: 6,
//                     child: Container(
//                       padding: const EdgeInsets.all(12),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             cartoon.dateString,
//                             style: TextStyle(color: Colors.grey),
//                           ),
//                           Text(
//            'Unit ${cartoon.unit.index.toString()}: ${cartoon.unitName}'),
//                           Text('By ${cartoon.author}'),
//                           Text(cartoon.unitName),
//                           Text(
//                             cartoon.description,
//                             maxLines: 2,
//                             softWrap: true,
//                             overflow: TextOverflow.fade,
//                           ),
//                           // Text(cartoon.description)
//                         ],
//                       ),
//                     )),
//               ],
//             )));
//   }
// }
