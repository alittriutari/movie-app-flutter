import 'package:flutter/material.dart';
import 'package:movie_app/common/constants.dart';
import 'package:movie_app/features/movies/presentation/pages/home_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kDavysGrey,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Movie App by Alit'),
            accountEmail: Text('gmail@alit.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://avatars.githubusercontent.com/u/29432760?v=4'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.movie),
            title: Text('Movies'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(
                            selectedIndex: 0,
                          )));
            },
          ),
          ListTile(
            leading: Icon(Icons.tv),
            title: Text('Tv Series'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(
                            selectedIndex: 1,
                          )));
            },
          ),
          ListTile(
            leading: Icon(Icons.save_alt),
            title: Text('Watchlist'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HomeScreen(
                            selectedIndex: 2,
                          )));
            },
          )
        ],
      ),
    );
  }
}
