import 'package:flutter/material.dart';
import 'api_service.dart';
import 'progress_dialog.dart';

class AddFriendUI extends StatefulWidget {
  @override
  _AddFriendUIState createState() => _AddFriendUIState();
}

class _AddFriendUIState extends State<AddFriendUI> {
  String _friendStatus; // = '0';
  TextEditingController _tecName; // = TextEditingController();
  TextEditingController _tecEmail; // = TextEditingController();
  TextEditingController _tecAge; // = TextEditingController();
  ProgressDialog
      progressDialog; // = ProgressDialog.getProgressDialog('กําลังประมวลผล...',false);

  _handleRadioValueChange(String value) {
    setState(() {
      _friendStatus = value;
    });
  }

  Future<void> _showWarningDialog(BuildContext context, String msg) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('คําเตอื น'),
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
          content: Text(msg),
          actions: <Widget>[
            RaisedButton(
              child: Text(
                'Ok',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
              color: Colors.green,
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    _friendStatus = '1';
    _tecName = TextEditingController();
    _tecEmail = TextEditingController();
    _tecAge = TextEditingController();
    progressDialog =
        ProgressDialog.getProgressDialog('กําลังประมวลผล...', false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Friend',
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/avatar1.png',
                      height: 120.0,
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    TextFormField(
                      controller: _tecName,
                      decoration: new InputDecoration(
                        icon: Icon(
                          Icons.person,
                        ),
                        labelText: "Enter name *",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(4.0),
                          borderSide: new BorderSide(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    TextFormField(
                      controller: _tecEmail,
                      decoration: new InputDecoration(
                        icon: Icon(
                          Icons.email,
                        ),
                        labelText: "Enter email *",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(4.0),
                          borderSide: new BorderSide(),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    TextFormField(
                      controller: _tecAge,
                      decoration: new InputDecoration(
                        icon: Icon(
                          Icons.alarm,
                        ),
                        labelText: "Enter age",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(4.0),
                          borderSide: new BorderSide(),
                        ),
                      ),
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: false),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Radio(
                          value: '1',
                          groupValue: _friendStatus,
                          onChanged: _handleRadioValueChange,
                        ),
                        Text(
                          'เพือѷ นสนทิ ',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                        Radio(
                          value: '0',
                          groupValue: _friendStatus,
                          onChanged: _handleRadioValueChange,
                        ),
                        Text(
                          'เพือѷ นไมส่ นทิ ',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        if (_tecName.text.trim().length == 0) {
                          _showWarningDialog(
                            context,
                            'ตรวจสอบการป้อนชื่อ ...',
                          );
                        } else if (_tecEmail.text.trim().length == 0) {
                          _showWarningDialog(
                            context,
                            'ตรวจสอบการป้อนอเีมล...',
                          );
                        } else {
                          //Send data to server for save on database
                          progressDialog.showProgress();
                          String message = await insertfriend(_tecName.text,
                              _tecEmail.text, _tecAge.text, _friendStatus);
                          print(message);
                          if (message == '1') {
                            setState(() {
                              progressDialog.hideProgress();
                              Navigator.pop(context);
                            });
                          }
                        }
                      },
                      minWidth: 200.0,
                      height: 55.0,
                      color: Colors.blue,
                      child: Text(
                        'บันทกึ ',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          progressDialog,
        ],
      ),
    );
  }
}
