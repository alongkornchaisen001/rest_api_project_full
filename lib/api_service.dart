import 'dart:io';
import 'friend.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Friend>> getallfriend() async {
  final response = await http.get(
    Uri.encodeFull('http://192.168.56.1:81/iotservice/getallfriend.php'),
    headers: {"Content-Type":"application/json"},
  );

  if (response.statusCode == 200) {
    final response_data = jsonDecode(response.body);
    //-------- แปลงขอ้มลู ทสѷี ง่ กลับมา JSON ใหเ้ป็นขอ้มลู ทจีѷ ะนํามาใชง้านใน App
    final friend_data = await response_data.map<Friend>((json) {
      return Friend.fromJson(json);
    }).toList();
    return friend_data;
  } else {
    throw Exception('Fail to load Todo from the Internet');
  }
}

Future<String> insertfriend(String name, String email, String age,String status) async {
  Friend friend = Friend(name: name, email: email, age: age, status: status);
  final response = await http.post(
    Uri.encodeFull('http://192.168.56.1:81/iotservice/insertfriend.php'),
    body: json.encode(friend.toJson()), //-------- แปลงขอ้มลู เป็น JSON กอ่ นสง่ ไป
    headers: {"Content-Type":"application/json"},
  );
  if (response.statusCode == 200) {
    final response_data = await json.decode(response.body);
    return response_data['message'];
  } else {
    throw Exception('Failed to update a Task. Error: ${response.toString()}');
  }
}

Future<String> updatefriend(String id, String name, String email, String age, String status) async {
  Friend friend = Friend(id: id,
      name: name,
      email: email,
      age: age,
      status: status);
  final response = await http.post(
    Uri.encodeFull('http://192.168.56.1:81/iotservice/updatefriend.php'),
    body: json.encode(friend.toJson()),
    //-------- แปลงขอ้มลู เป็น JSON กอ่ นสง่ ไป
    headers: {"Content-Type": "application/json"},
  );
  if (response.statusCode == 200) {
    final response_data = await json.decode(response.body);
    return response_data['message'];
  } else {
    throw Exception('Failed to update a Task. Error: ${response.toString()}');
  }
}

Future<String> deletefriend(String id) async {
  Friend friend = Friend(id: id);
  final response = await http.post(
    Uri.encodeFull('http://192.168.56.1:81/iotservice/deletefriend.php'),
    body: json.encode(friend.toJson()),
    headers: {"Content-Type":"application/json"},
  );
  if (response.statusCode == 200) {
    final response_data = await json.decode(response.body);
    return response_data['message'];
  } else {
    throw Exception('Failed to update a Task. Error: ${response.toString()}');
  }
}