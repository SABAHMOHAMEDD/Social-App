class StoryModel {
  String? name;
  String? uId;
  String? avatarImage;
  String? dateTime;
  String? text;
  String? postImage;

  StoryModel(
      {this.name,
        this.uId,
        this.avatarImage,
        this.dateTime,
        this.text,
        this.postImage});

  StoryModel.fromJson(Map<String, dynamic> json)
      : this(
    name: json['name'],
    uId: json['uId'],
    avatarImage: json['image'],
    dateTime: json['dateTime'],
    text: json['text'],
    postImage: json['postImage'],
  );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'uId': uId,
      'image': avatarImage,
      'dateTime': dateTime,
      'text': text,
      'postImage': postImage
    };
  }
}
