
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constains.dart';
import 'package:tiktok_clone/models/comment.dart';

class CommentsController extends GetxController {
  final Rx<List<Comments>> _listComments = Rx<List<Comments>>([]);
  List<Comments> get listComments => _listComments.value;
  String postId = "";
  upDatePostId(String id) {
    postId = id;
    getAllCommentsInPost();
  }

  getAllCommentsInPost() async {
    _listComments.bindStream(
      firestore
          .collection('videos')
          .doc(postId)
          .collection('comments')
          .snapshots()
          .map(
        (event) {
          List<Comments> result = [];
          for (var item in event.docs) {
            result.add(Comments.fromSnap(item));
          }
          return result;
        },
      ),
    );
  }

  Future<String> PostComments(String tittle) async {
    String result = "Some errors";
    try {
      String uid = firebaseAuth.currentUser!.uid;
      if (postId.isNotEmpty && tittle.isNotEmpty) {
        DocumentSnapshot userDoc =
            await firestore.collection('users').doc(authMethods.user.uid).get();
        var allCmtInPost = await firestore
            .collection('videos')
            .doc(postId)
            .collection('comments')
            .get();
        String cmtId = 'comments ${allCmtInPost.docs.length}';
        Comments cmt = Comments(
          commentId: cmtId,
          postId: postId,
          uid: uid,
          likes: [],
          datePublished: DateTime.now(),
          title: tittle,
          profilePic: (userDoc.data() as Map<String, dynamic>)['photoUrl'],
          username: (userDoc.data() as Map<String, dynamic>)['username'],
        );

        await firestore
            .collection('videos')
            .doc(postId)
            .collection('comments')
            .doc(cmtId)
            .set(cmt.toJson());
        result = "Comment is uploaded";
        print(result);
        return result;
      } else {
        print('Field is Empty');
        result = "Field is Empty";
        return result;
      }
    } catch (err) {
      print(err.toString());
      result = err.toString();
      return result;
    }
    return result;
  }

  Future<void> likesCmt(
      String uid, String postId, String cmtId, List list) async {
    try {
      if (list.contains(uid)) {
        await firestore
            .collection('videos')
            .doc(postId)
            .collection('comments')
            .doc(cmtId)
            .update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await firestore
            .collection('videos')
            .doc(postId)
            .collection('comments')
            .doc(cmtId)
            .update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (err) {
      print(err.toString());
    }
  }
}
