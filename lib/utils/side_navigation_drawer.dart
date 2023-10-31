import 'package:flutter/material.dart';
import 'package:task_management_app/pages/category/category_page.dart';

class SideNavigationDrawer extends StatelessWidget {
  const SideNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://gulamanas.github.io/hosted-assets/alex-smith.png',
              ),
            ),
            accountName: Text('Alex Smith'),
            accountEmail: Text('smithalex@email.com'),
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text('Category'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: ((context) {
                    return const CategoryScreen();
                  }),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.done),
            title: const Text('Medium Priority'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.done),
            title: const Text('High Priority'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
