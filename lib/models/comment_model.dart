class CommentModel {
  String? name;
  String? uId;
  String? avatarImage;
  String? dateTime;
  String? text;
  String? postId;

  // String? commentImage;

  CommentModel(
      {this.name,
      this.uId,
      this.avatarImage,
      this.dateTime,
      this.text,
      this.postId
      //this.commentImage
      });

  CommentModel.fromJson(Map<String, dynamic> json)
      : this(
            name: json['name'],
            uId: json['uId'],
            avatarImage: json['image'],
            dateTime: json['dateTime'],
            text: json['text'],
            postId: json['postId']
            // commentImage: json['commentImage'],
            );

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'uId': uId,
      'image': avatarImage,
      'dateTime': dateTime,
      'text': text,
      'postId': postId
      // 'postImage': postImage
    };
  }
}
