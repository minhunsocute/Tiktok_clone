import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constains.dart';
import 'package:tiktok_clone/models/notification.dart';

import '../models/user.dart';
import '../models/video.dart';

class ProfileControls extends GetxController {
  final Rx<List<Video>> _videoFav = Rx<List<Video>>([]);
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  final Rx<List<User>> _userUnFollow = Rx<List<User>>([]);
  final Rx<List<User>> _following = Rx<List<User>>([]);
  final Rx<List<User>> _followers = Rx<List<User>>([]);

  Map<String, dynamic> get user => _user.value;
  List<Video> get videoFav => _videoFav.value;
  List<User> get userUnFollow => _userUnFollow.value;
  List<User> get following => _following.value;
  List<User> get followers => _followers.value;
  final Rx<String> _uid = "".obs;

  upDateUser(String id) {
    _uid.value = id;
    getUser();
    // print(_user.value);
  }

  getUser() async {
    String username = "";
    String email = "";
    String profilePic = "";
    List<Map<String, dynamic>> allPosts = [];
    List<String> followers = [];
    List<String> following = [];
    String uid = "";
    uid = _uid.value;
    DocumentSnapshot userDoc =
        await firestore.collection('users').doc(_uid.value).get();
    Map<String, dynamic> dataUser = userDoc.data() as Map<String, dynamic>;
    username = dataUser['username'];
    profilePic = dataUser['photoUrl'];
    email = (userDoc.data() as Map<String, dynamic>)['email'];
    var allVids =
        await firestore.collection('videos').where('uid', isEqualTo: uid).get();
    for (var item in allVids.docs) {
      Map<String, dynamic> i = {
        "id": item.data()['id'],
        "thumbNails": item.data()['thumbNailsPath'],
        "caption": item.data()['caption'],
      };
      allPosts.add(i);
    }
    for (var item in dataUser['followers']) {
      followers.add(item);
    }
    for (var item in dataUser['following']) {
      following.add(item);
    }
    _user.value = {
      "uid": uid,
      "username": username,
      "email": email,
      "profilePic": profilePic,
      "allPosts": allPosts,
      "followers": followers,
      "following": following,
      "bio": dataUser['bio'],
      "password": dataUser['password'],
    };
    //  print(_user.value);
    update();
  }

  updatVideoFav(String id) {
    _uid.value = id;
    getDataVidFav();
  }

  getDataVidFav() async {
    var allVideo = await firestore.collection('videos').get();
    List<Video> result = [];
    for (var item in allVideo.docs) {
      if ((item.data())['likes'].contains(_uid.value)) {
        result.add(Video.fromSnap(item));
      }
    }
    _videoFav.value = result;
    update();
  }

  updateUserUnfollow(String id) {
    _uid.value = id;
    getDataUserUnfollow();
  }

  getDataUserUnfollow() async {
    DocumentSnapshot userDoc =
        await firestore.collection('users').doc(_uid.value).get();
    List userInListFollow =
        (userDoc.data() as Map<String, dynamic>)['following'];
    _userUnFollow.bindStream(
      firestore.collection('users').snapshots().map(
        (event) {
          List<User> result = [];
          for (var item in event.docs) {
            Map<String, dynamic> data = item.data();
            if (data['username'] !=
                (userDoc.data() as Map<String, dynamic>)['username']) {
              if (userInListFollow.contains(data['uid'])) {
              } else {
                result.add(User.fromSnap(item));
              }
            }
          }
          return result;
        },
      ),
    );
  }

  Future<void> followingUser(String uidUser, List listFollowing) async {
    try {
      String uid = authMethods.user.uid;
      if (listFollowing.contains(uidUser)) {
        firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([uidUser])
        });
        firestore.collection('users').doc(uidUser).update({
          'followers': FieldValue.arrayRemove([uid]),
        });
        _user.value['following'].add(uidUser);
      } else {
        firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([uidUser])
        });
        firestore.collection('users').doc(uidUser).update({
          'followers': FieldValue.arrayUnion([uid]),
        });
        addDataToNoti(uidUser, uid);
      }
      update();
    } catch (err) {
      print(err.toString());
    }
  }

  addDataToNoti(String uidOp, String uid) async {
    var userDoc = await firestore.collection('users').doc(uid).get();
    User user = User.fromSnap(userDoc);

    var allNoti = await firestore.collection('noti').get();
    String notiId = 'noti ${allNoti.docs.length}';

    Noti data = Noti(
      notiId: notiId,
      typeNoti: 0,
      username: user.username,
      profilePic: user.photoUrl,
      uid: uid,
      uidRec: uidOp,
      postUid: "",
      postPath: "",
      commentUid: "",
    );

    try {
      await firestore.collection('noti').doc(notiId).set(data.toJson());
    } catch (err) {
      print(err.toString());
    }
  }

  updateFollowing(String id) {
    _uid.value = id;
    getDataFollowing();
    // print("---------------------");
    // for (var item in _following.value) {
    //   print(item.username);
    // }
  }

  getDataFollowing() async {
    DocumentSnapshot userDoc =
        await firestore.collection('users').doc(_uid.value).get();
    User data = User.fromSnap(userDoc);
    _following.bindStream(
      firestore.collection('users').snapshots().map(
        (event) {
          List<User> result = [];
          for (var item in event.docs) {
            User d = User.fromSnap(item);
            if (data.following.contains(d.uid)) {
              result.add(d);
            }
          }
          return result;
        },
      ),
    );
  }

  updateFollowers(String id) {
    _uid.value = id;
    getDataFollowers();
  }

  getDataFollowers() async {
    DocumentSnapshot userDoc =
        await firestore.collection('users').doc(_uid.value).get();
    User data = User.fromSnap(userDoc);
    _followers
        .bindStream(firestore.collection('users').snapshots().map((event) {
      List<User> result = [];
      for (var item in event.docs) {
        User d = User.fromSnap(item);
        if (data.followers.contains(d.uid)) {
          result.add(d);
        }
      }
      return result;
    }));
  }

  updatePassword(String newPass) async {
    await firebaseAuth.currentUser?.updatePassword(newPass).then((value) {
      Get.snackbar("Update password", "success", backgroundColor: Colors.blue);
    }).catchError((err) {
      Get.snackbar("Update password", err.toString(),
          backgroundColor: Colors.blue);
    });
    await firestore.collection('users').doc(authMethods.user.uid).update({
      'password': newPass,
    });
  }
}
