import 'package:flutter/material.dart';
import 'progress_dialog.dart';
import 'api_service.dart';

class UpdateDeleteFriendUI extends StatefulWidget {
  String id;
  String name;
  String email;
  String age;
  String status;

  UpdateDeleteFriendUI({this.id, this.name, this.email, this.age, this.status});

  @override
  _UpdateDeleteFriendUIState createState() => _UpdateDeleteFriendUIState();
}

class _UpdateDeleteFriendUIState extends State<UpdateDeleteFriendUI> {
  String _radioStatus;
  TextEditingController _tecName; //= TextEditingController();
  TextEditingController _tecEmail; //= TextEditingController();
  TextEditingController _tecAge; //= TextEditingController();
  ProgressDialog progressDialog =
  ProgressDialog.getProgressDialog('กําลังประมวลผล...', false);

  _handleRadioValueChange(String value) {
    setState(() {
      _radioStatus = value;
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
    _tecName = TextEditingController(text: widget.name);
    _tecEmail = TextEditingController(text: widget.email);
    _tecAge = TextEditingController(text: widget.age);
    _radioStatus = widget.status;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Update-Delete Friend',
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
                          groupValue: _radioStatus,
                          onChanged: _handleRadioValueChange,
                        ),
                        Text(
                          'เพือѷ นสนทิ ',
                          style: new TextStyle(fontSize: 16.0),
                        ),
                        Radio(
                          value: '0',
                          groupValue: _radioStatus,
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
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: MaterialButton(
                            onPressed: () async {
                              if (_tecName.text.trim().length == 0) {
                                _showWarningDialog(
                                    context, 'ตรวจสอบการป้อนชอืѷ ...');
                              } else if (_tecEmail.text.trim().length == 0) {
                                _showWarningDialog(
                                    context, 'ตรวจสอบการป้อนอเีมล...');
                              } else {
//Send data to server for save on database

                                progressDialog.showProgress();
                                String message = await updatefriend(
                                    widget.id,
                                    _tecName.text,
                                    _tecEmail.text,
                                    _tecAge.text,
                                    _radioStatus);

                                print(message);
                                if (message == '1') {
                                  setState(() {
                                    progressDialog.hideProgress();
                                    Navigator.pop(context);
                                  });
                                }
                              }
                            },
                            height: 55.0,
                            color: Colors.blue,
                            child: Text(
                              'แกไ้ข',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 24.0,
                        ),
                        Expanded(
                          child: MaterialButton(
                            onPressed: () async {
                              showDialog<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('ยนื ยัน'),
                                      titleTextStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0,
                                      ),
                                      content: Text('ยนื ยันการลบ ?'),
                                      actions: <Widget>[
                                        RaisedButton(
                                          child: Text(
                                            'ตกลง',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          onPressed: () async {
                                            progressDialog.showProgress();
                                            String message =
                                            await deletefriend(widget.id);
                                            print(message);
                                            if (message == '1') {
                                              setState(() {
                                                progressDialog.hideProgress();
                                                Navigator.pop(context);
                                              });
                                            }
                                            Navigator.pop(context);
                                          },
                                          color: Colors.green,
                                        ),
                                        RaisedButton(
                                          child: Text(
                                            'ยกเลกิ',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          color: Colors.deepOrange,
                                        ),
                                      ],
                                    );
                                  });
                            },
                            height: 55.0,
                            color: Colors.deepOrange,
                            child: Text(
                              'ลบ',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
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