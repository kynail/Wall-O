
class Avatar {
  Avatar({
    this.type = "",
    this.seed = "",
  });

  String type;
  String seed;

  factory Avatar.fromJson(Map<String, dynamic> json) {
    return Avatar(type: json['type'], seed: json['seed']);
  }

  @override
  String toString() {
    return 'Avatar: {type: $type, seed: $seed}';
  }
}
