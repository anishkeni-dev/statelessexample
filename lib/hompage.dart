import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stateless/db.dart';
import 'package:stateless/model/datamodel.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  late List<Map<String, dynamic>> data = [];
  Userdb udb = Userdb();
  //call this only at the start
  // putdata(){
  //   var user = UserModel(name: "anish");
  //   udb.initDBUserData();
  //   udb.insertUserData(user);
  // }
  getuser()async{
    //putdata();
    udb.initDBUserData();
    data = await udb.getDataUserData();
  }
  updatedata(user){
    udb.initDBUserData();
    //id is hardcoded to 1 for updating the db
    udb.updateUserData(1,user);
    getuser();
  }
  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> _real = ValueNotifier<bool>(false);
    return FutureBuilder(
       future: getuser(),
        builder:(context, snapshot) {
          ValueNotifier<String> name = ValueNotifier<String>(data.isEmpty?'':data[0]['name']);
          final uname = TextEditingController(text:name.value);
         return Scaffold(
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
                    builder: (context, value, child) =>
                        Column(
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
                              builder: (context, value, child) =>
                                  TextButton(
                                      child: Text(
                                        //if the value is updated it'll change the text button
                                          _real.value ? "updated" : "update"),
                                      onPressed: () {
                                        _real.value = true;
                                        name.value = uname.text;
                                        var user = UserModel(name: name.value);
                                        updatedata(user);
                                      }),
                            ),

                            //datafrom valuelistenable
                            Text("data from text field: " + name.value),

                            //data from db
                            Text(data.isEmpty
                                ? "db has no data"
                                : "data from db: " + data[0]['name']),
                          ],
                        ),
                  ),


                ],
              ),
            ),
          );

        }
    );
  }
}
