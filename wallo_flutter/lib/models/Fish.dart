class Fish {
  Fish({this.name, this.confidence});

  String name;
  double confidence;
  // String description;

  factory Fish.fromJson(Map<String, dynamic> json) {
    return Fish(name: json["fishName"]);
  }

  factory Fish.fromString(String data) {
    var fishData = data.split(":");
    return Fish(
        name: fishData[0] != null ? fishData[0] : null,
        confidence: fishData[1] != null ? double.parse(fishData[1]) : null);
  }

  factory Fish.initial() {
    return Fish(name: null, confidence: null);
  }

  @override
  String toString() {
    return 'Fish : name = $name, confidence = $confidence';
  }
}
