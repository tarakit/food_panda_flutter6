
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
          child: ListView(
            scrollDirection: Axis.vertical,
            children: [
              UserAccountsDrawerHeader(
                  currentAccountPicture: ClipRRect(
                    borderRadius: BorderRadius.circular(45),
                    child: Image.network('https://marketplace.canva.com/EAFHfL_zPBk/1/0/1600w/canva-yellow-inspiration-modern-instagram-profile-picture-kpZhUIzCx_w.jpg'),
                  ),
                  accountName: Text('Tara Kit'),
                  accountEmail: Text('tarakit.istad@gmail.com')
              ),
              ListTile(
                onTap: (){},
                leading: Icon(Icons.favorite),
                title: Text('Favourites'),
              ),
              ListTile(
                onTap: (){},
                leading: Icon(Icons.favorite),
                title: Text('Favourites'),
              ),
              ListTile(
                onTap: (){},
                leading: Icon(Icons.favorite),
                title: Text('Favourites'),
              ),
              ListTile(
                onTap: (){},
                leading: Icon(Icons.favorite),
                title: Text('Favourites'),
              ),
              ListTile(
                onTap: (){},
                leading: Icon(Icons.favorite),
                title: Text('Favourites'),
              ),
              ListTile(
                onTap: (){},
                leading: Icon(Icons.favorite),
                title: Text('Favourites'),
              ),
              ListTile(
                onTap: (){},
                leading: Icon(Icons.favorite),
                title: Text('Favourites'),
              ),
              ListTile(
                onTap: (){},
                leading: Icon(Icons.favorite),
                title: Text('Favourites'),
              ),
              ListTile(
                onTap: (){},
                leading: Icon(Icons.favorite),
                title: Text('Favourites'),
              ),
              ListTile(
                onTap: (){},
                leading: Icon(Icons.favorite),
                title: Text('Favourites'),
              ),
              ListTile(
                onTap: (){},
                leading: Icon(Icons.favorite),
                title: Text('Favourites'),
              ),
              ListTile(
                onTap: (){},
                leading: Icon(Icons.favorite),
                title: Text('Hello'),
              ),
              ListTile(
                onTap: (){},
                leading: Icon(Icons.favorite),
                title: Text('Hello'),
              ),
            ],
          )
      ),
    );
  }
}