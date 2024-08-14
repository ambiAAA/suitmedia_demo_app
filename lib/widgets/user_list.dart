// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final users = userProvider.users;

    return users.isEmpty
        ? Center(child: Text('No Users Found'))
        : RefreshIndicator(
            onRefresh: () async {
              userProvider.resetUsers();
              await userProvider.fetchUsers();
            },
            child: ListView.builder(
              itemCount: users.length + 1,
              itemBuilder: (ctx, index) {
                if (index == users.length) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () => userProvider.loadNextPage(),
                        child: Text('Load More'),
                      ),
                    ),
                  );
                }

                final user = users[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.avatar),
                  ),
                  title: Text('${user.firstName} ${user.lastName}'),
                  subtitle: Text(user.email),
                  onTap: () {
                    userProvider.selectUser(user);
                    Navigator.of(context).pop();
                  },
                );
              },
            ),
          );
  }
}
