import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movie/presentation/pages/home_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kDavysGrey,
      child: Column(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('Movie App by Alit'),
            accountEmail: Text('gmail@alit.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://avatars.githubusercontent.com/u/29432760?v=4'),
            ),
          ),
          ListTile(
            key: const Key('movie_menu'),
            leading: const Icon(Icons.movie),
            title: const Text('Movies'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeScreen(
                            selectedIndex: 0,
                          )));
            },
          ),
          ListTile(
            key: const Key('tv_menu'),
            leading: const Icon(Icons.tv),
            title: const Text('Tv Series'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeScreen(
                            selectedIndex: 1,
                          )));
            },
          ),
          ListTile(
            key: const Key('watchlist_menu'),
            leading: const Icon(Icons.save_alt),
            title: const Text('Watchlist'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HomeScreen(
                            selectedIndex: 2,
                          )));
            },
          )
        ],
      ),
    );
  }
}
