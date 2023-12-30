class StoryModel {
  String? name;
  String? uId;
  String? avatarImage;
  String? dateTime;
  String? text;
  String? storyImage;

  StoryModel(
      {this.name,
      this.uId,
      this.avatarImage,
      this.dateTime,
      this.text,
      this.storyImage});

  StoryModel.fromJson(Map<String, dynamic> json)
      : this(
          name: json['name'],
          uId: json['uId'],
          avatarImage: json['image'],
          dateTime: json['dateTime'],
          text: json['text'],
          storyImage: json['storyImage'],
        );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'uId': uId,
      'image': avatarImage,
      'dateTime': dateTime,
      'text': text,
      'storyImage': storyImage
    };
  }
}
