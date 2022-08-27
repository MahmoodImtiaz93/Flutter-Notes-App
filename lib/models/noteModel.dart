class NoteModel {
  String? id;
  String? userid;
  String? title;
  String? content;
  DateTime? dateadded;

  NoteModel({
    this.id,
    this.userid,
    this.title,
    this.content,
    this.dateadded,
  });

  factory NoteModel.fromMap(Map<String, dynamic> map) {
    return NoteModel(
      id: map['id'],
      userid: map['userid'],
      title: map['title'],
      content: map['content'],
      dateadded: DateTime.tryParse(map['dateAdded']),
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userid': userid,
      'title': title,
      'content': content,
      'dateadded': dateadded!.toIso8601String()
    };
  }
}
