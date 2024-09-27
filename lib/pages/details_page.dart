import 'package:flutter/material.dart';

import '../service/user_service.dart';

class DetailsPage extends StatelessWidget {
  final User user;
  const DetailsPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.name.first} ${user.name.last}')
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Image.network(user.picture,fit: BoxFit.cover,),
            const SizedBox(height: 30),
            Text(user.email)
          ],
        ),
      ),
    );
  }
}
