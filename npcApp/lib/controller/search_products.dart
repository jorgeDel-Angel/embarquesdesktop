// import 'package:crudfirebase/models/models.dart';
// import 'package:crudfirebase/pages/editar_posicion.dart';
// import 'package:crudfirebase/pages/mover_prodcuto.dart';
// import 'package:crudfirebase/prividers/prodcutos.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';

// class SearchProducts extends SearchDelegate<MoverProducto> {

//   FetchUserList _userList = FetchUserList();

//   List<Map<String, dynamic>> _flitro = [];
//   final List<Map<String, dynamic>> tarea;

//   SearchProducts(this.tarea);

//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//           onPressed: () {
//             query = '';
//           },
//           icon: const Icon(Icons.close))
//     ];
//   }

//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: const Icon(Icons.arrow_back_ios),
//       onPressed: () {
//         Navigator.pop(context);
//       },
//     );
//   }

//   @override
//   Widget buildResults(BuildContext context) {
//     return FutureBuilder<List<Userlist>>(
//         future: _userList.getuserList(query: query),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(
//               child: const CircularProgressIndicator(),
//             );
//           }
//           List<Userlist>? data = snapshot.data;
//           return ListView.builder(
//               itemCount: data?.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Row(
//                     children: [
//                       Container(
//                         width: 60,
//                         height: 60,
//                         decoration: BoxDecoration(
//                           color: Colors.deepPurpleAccent,
//                           borderRadius: BorderRadius.circular(10),
//                         ),
//                         child: Center(
//                           child: Text(
//                             '${data?[index].id}',
//                             style: const TextStyle(
//                                 fontSize: 20,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.white),
//                             overflow: TextOverflow.clip,
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 20),
//                       Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               '${data?[index].name}',
//                               style: const TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.w600),
//                             ),
//                             const SizedBox(height: 10),
//                             Text(
//                               '${data?[index].email}',
//                               style: const TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400,
//                               ),
//                             ),
//                           ])
//                     ],
//                   ),
//                 );
//               });
//         });
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     return const Center(
//       child: const Text('Search User'),
//     );
//   }
// }
