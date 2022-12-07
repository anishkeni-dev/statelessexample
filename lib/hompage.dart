import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stateless/db.dart';
import 'package:stateless/model/datamodel.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  late List<Map<String, dynamic>> data = [];
  Userdb udb = Userdb();
  getuser()async{
    udb.initDBUserData();
    data = await udb.getDataUserData();
  }
  // putdata(){
  //   var user = UserModel(name: "anish");
  //   udb.initDBUserData();
  //   udb.insertUserData(user);
  // }
  updatedata(user){
    udb.initDBUserData();
    udb.updateUserData(3,user);
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<String> name = ValueNotifier<String>(data.isEmpty?'':data[0]['name']);
    final uname = TextEditingController(text:name.value);
    ValueNotifier<bool> _real = ValueNotifier<bool>(false);
    return FutureBuilder(
       future: getuser(),
        builder:(context, snapshot) =>  Scaffold(
        appBar: AppBar(
          title: Text('stateless'),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: Column(
            children: [
              ValueListenableBuilder(
                valueListenable: name,
                builder: (context, value, child) => Column(
                  children: [
                TextFormField(
                decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'What do people call you?',
                labelText: 'Name *',
              ),
                  controller: uname,
                ),
                    //textbutton example
                    ValueListenableBuilder(
                      valueListenable: _real,
                      builder: (context, value, child) => TextButton(
                          child: Text(_real.value?"updated":"update"),
                          onPressed: (){
                            _real.value=true;
                           name.value=uname.text;
                           var user = UserModel(name: name.value);
                            updatedata(user);
                            // getuser();
                          }),
                    ),
                    Text("data from text field: "+ name.value),
                    Text(data.isEmpty?"db has no data":"data from db: "+ data[0]['name']),
                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
