import 'package:cloud_firestore/cloud_firestore.dart';

class Booking {
  String? uuid;
  DateTime start;
  DateTime end;
  String name;
  String lastName;
  String email;
  bool hall;
  bool videoConference;
  bool? approved;
  bool? notAssist;

  Booking(
      {required this.start,
      required this.end,
      required this.name,
      required this.lastName,
      required this.email,
      this.hall = true,
      this.videoConference = true});

  Booking.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> doc)
      : uuid = doc.id,
        start = (doc.data()!["start"] as Timestamp).toDate(),
        end = (doc.data()!["end"] as Timestamp).toDate(),
        name = doc.data()!["name"],
        lastName = doc.data()!["lastName"],
        email = doc.data()!["email"],
        hall = doc.data()!["hall"] ?? false,
        videoConference = doc.data()!["videoConference"] ?? false,
        approved = doc.data()!["approved"],
        notAssist = doc.data()!["notAssist"];

  Booking.fromQuerySnapshot(QueryDocumentSnapshot<dynamic> doc)
      : uuid = doc.id,
        start = (doc.data()!["start"] as Timestamp).toDate(),
        end = (doc.data()!["end"] as Timestamp).toDate(),
        name = doc.data()!["name"],
        lastName = doc.data()!["lastName"],
        email = doc.data()!["email"],
        hall = doc.data()!["hall"] ?? false,
        videoConference = doc.data()["videoConference"] ?? false,
        approved = doc.data()!["approved"],
        notAssist = doc.data()!["notAssist"];

  Map<String, dynamic> toMap() {
    return {
      'start': start,
      'end': end,
      'name': name,
      'lastName': lastName,
      'email': email,
      'hall': hall,
      'hallAndVideoConference': videoConference,
      'approved': approved,
      'notAssist': notAssist,
    };
  }
}
