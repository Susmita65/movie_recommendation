class User {
  final String moviename;
  final String url;
  final String id;
  User(this.moviename, this.url, this.id);
  //constructor jasle json lai object instance ma change garya  xa hai
  User.fromJson(Map<String, dynamic> json)
      : moviename = json['moviename'],
        url = json['url'],
        id = json['id'];

  //method jasle object lai json ma change garya xa hai
  Map<String, dynamic> toJson() =>
      {'moviename': moviename, 'url': url, 'phone': id};
}
