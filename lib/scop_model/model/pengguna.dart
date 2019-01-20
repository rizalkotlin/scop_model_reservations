import 'package:scop_model_reservation/scop_model/base_architecture.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User extends BaseModel {
  static const String DEFAULT_IMAGE =
      'https://firebasestorage.googleapis.com/v0/b/freshmart-d9620.appspot.com/o/profile.jpeg?alt=media&token=fdec1349-566e-4d07-a9a6-b07877d7040b';

  String uid, displayName, email, phone, avatar, address;
  bool isAdmin;
  static CollectionReference _ref = Firestore.instance.collection('user');

  User({
    this.uid,
    this.displayName,
    this.email,
    this.avatar = DEFAULT_IMAGE,
    this.isAdmin,
    this.phone,
    this.address,
  });

  User.fromSnapshot(DocumentSnapshot snap) {
    uid = snap.documentID;
    displayName = snap['displayName'];
    email = snap['email'];
    avatar = snap['avatar'] ?? DEFAULT_IMAGE;
    phone = snap['phone'];
    isAdmin = snap['isAdmin'];
    address = snap['address'];
  }

  ///Save basic info data to database
  Future<void> saveInfo() {
    return _ref.document(uid).updateData({
      'displayName': displayName,
      'email': email,
      'avatar': avatar,
      'phone': phone,
      'address': address,
    });
  }

  ///Save basic info data to database
  Future<FirebaseUser> register(String password) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final operation =
        _auth.createUserWithEmailAndPassword(email: email, password: password);
    operation.then((user) {
      if (user != null) {
        _ref.document(user.uid).setData({
          'uid': user.uid,
          'displayName': displayName,
          'email': email,
          'avatar': avatar,
          'phone': phone,
          'isAdmin': false,
        });
      }
    });
    return operation;
  }

  ///update image url
  static updatePhotoUrl(String uid, String url) {
    return _ref.document(uid).updateData({'avatar': url});
  }

  ///Get all users snapshot
  static Stream<QuerySnapshot> getSnapshots() => _ref.snapshots();

  ///Memuat data berdasarkan id
  static Future<User> loadById(String id) async {
    Future<User> load() async {
      final snap = await _ref.document(id).get();
      final data = new User.fromSnapshot(snap);
      caches[id] = data;
      return data;
    }

    final loading = load();
    if (caches[id] != null) {
      return caches[id];
    }
    return await loading;
  }

  static Stream<DocumentSnapshot> loadUserSnapshot(String uid) {
    return _ref.document(uid).snapshots();
  }

  //Memuat data berdasarkan id
  static Future<User> currentUser() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final fireUser = await _auth.currentUser();
    return loadById(fireUser.uid);
  }

  static Map<String, User> caches = {};

  //kontrusksi dari map
  User.fromMap(Map<String, dynamic> map) {
    uid = map['uid'];
    displayName = map['displayName'];
    avatar = map['avatar'];
    email = map['email'];
    isAdmin = map['isAdmin'];
    phone = map['phone'];
    address = map['address'];
  }

  ///konversi ke map
  @override
  Map<String, dynamic> toMap() => {
        'uid': uid,
        'avatar': avatar,
        'displayName': displayName,
        'email': email,
        'isAdmin': isAdmin,
        'phone': phone,
        'address': address,
        // TODO: implement toMap
      };
}
