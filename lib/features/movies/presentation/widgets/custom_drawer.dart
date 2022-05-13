import 'package:flutter/material.dart';
import 'package:movie_app/common/constants.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kDavysGrey,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Movie App'),
            accountEmail: Text('movie_app@gmail.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage('https://avatars.githubusercontent.com/u/29432760?v=4'),
            ),
          ),
          ListTile(
            leading: Icon(Icons.movie),
            title: Text('Movies'),
          ),
          ListTile(
            leading: Icon(Icons.tv),
            title: Text('Tv Series'),
          ),
          ListTile(
            leading: Icon(Icons.save_alt),
            title: Text('Watchlist'),
          )
        ],
      ),
    );
    ;
  }
}
