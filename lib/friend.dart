//ไฟล์นี้จะแปลง Data to .json และจาก .json to Data
class Friend {
  String id;
  String name;
  String email;
  String age;
  String status;
  String datetimeAdd;

  Friend(
      {this.id,
        this.name,
        this.email,
        this.age,
        this.status,
        this.datetimeAdd});

  Friend.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    age = json['age'];
    status = json['status'];
    datetimeAdd = json['datetime_add'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['age'] = this.age;
    data['status'] = this.status;
    data['datetime_add'] = this.datetimeAdd;
    return data;
  }
}