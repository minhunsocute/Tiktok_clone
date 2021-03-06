import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  String id;
  String messNearest;
  int groupOrWithPerson; // 0: group 1: Person
  String photoGroup_member;
  List listUid;
  List photoUrl;
  List username;
  int colorOfchat;
  String nameOfGroup;
  Message({
    required this.id,
    required this.messNearest,
    required this.photoGroup_member,
    required this.groupOrWithPerson,
    required this.listUid,
    required this.photoUrl,
    required this.username,
    required this.colorOfchat,
    required this.nameOfGroup,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'messNearest': messNearest,
        'groupOrWithPerson': groupOrWithPerson,
        'photoGroup_member': photoGroup_member,
        'listUid': listUid,
        'photoUrl': photoUrl,
        'username': username,
        'colorOfchat': colorOfchat,
        'nameOfGroup': nameOfGroup,
      };

  static Message fromSnap(DocumentSnapshot snap) {
    return Message(
      id: snap['id'],
      messNearest: snap['messNearest'],
      groupOrWithPerson: snap['groupOrWithPerson'],
      photoGroup_member: snap['photoGroup_member'],
      listUid: snap['listUid'],
      photoUrl: snap['photoUrl'],
      username: snap['username'],
      colorOfchat: snap['colorOfchat'],
      nameOfGroup: snap['nameOfGroup'],
    );
  }
}
