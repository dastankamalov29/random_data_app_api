import 'package:api_app_first/service/user_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final items = List.generate(50, (i) => i);

  late Future<List<User>> futureUsers;

  @override
  void initState() {
    super.initState();

    futureUsers = UserService().getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("People"),
      ),
      body: RefreshIndicator(
        child: Center(
          child: FutureBuilder<List<User>>(
            future: futureUsers,
            builder: ((context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      User user = snapshot.data?[index];
                      return ListTile(
                        title: Text(
                          user.email,
                        ),
                        subtitle: Text(user.name.first),
                        trailing: const Icon(Icons.chevron_right_outlined),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailsPage(
                                user: user,
                              ),
                            ),
                          );
                        },
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider(
                        color: Colors.white,
                      );
                    },
                    itemCount: snapshot.data!.length);
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              return const CircularProgressIndicator();
            }),
          ),
        ),
        onRefresh: () async {
          var users = await UserService().getUser();
          setState(() {
            futureUsers = Future.value(users);
          });
        },
      ),
    );
  }
}





// ListView.builder(
//         itemCount: items.length,
//         itemBuilder: (context, index) {
//           final item = items[index];

//           return ListTile(
//             title: Text("Item $item"),
//             subtitle: const Text("My subtitle"),
//             onTap: () {},
//             trailing: const Icon(Icons.chevron_right_outlined),
//           );
//         },
//       ),