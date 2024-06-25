import 'package:flutter/material.dart';

void main() {
  runApp(EditProfilePage());
}

class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Profil'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop(); // Navigate back when the back button is pressed
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 50.0,
                backgroundImage: AssetImage('data/jeruk.jpg'),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                ),
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Kata Sandi',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _simpanPerubahan();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:  Colors.green,
                    ),
                    child: Text(
                      'Simpan',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              OutlinedButton(
                onPressed: () {
                  _keluar();
                },
                child: Text('Keluar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _simpanPerubahan() {
    print('Menyimpan perubahan profil...');
  }

  void _keluar() {
    print('Keluar...');
  }
}