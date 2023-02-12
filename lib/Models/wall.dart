class Wall {
  int? id;
  int? width;
  int? height;
  String? url;
  String? photographer;
  String? photographerUrl;
  int? photographerId;
  String? avgColor;
  Src? src;
  String? alt;

  Wall(
      {this.id,
      this.width,
      this.height,
      this.url,
      this.photographer,
      this.photographerUrl,
      this.photographerId,
      this.avgColor,
      this.src,
      this.alt});

  Wall.fromJson(Map<dynamic, dynamic> json) {
    if (json["id"] is int) {
      id = json["id"];
    }
    if (json["width"] is int) {
      width = json["width"];
    }
    if (json["height"] is int) {
      height = json["height"];
    }
    if (json["url"] is String) {
      url = json["url"];
    }
    if (json["photographer"] is String) {
      photographer = json["photographer"];
    }
    if (json["photographer_url"] is String) {
      photographerUrl = json["photographer_url"];
    }
    if (json["photographer_id"] is int) {
      photographerId = json["photographer_id"];
    }
    if (json["avg_color"] is String) {
      avgColor = json["avg_color"];
    }
    if (json["src"] is Map) {
      src = json["src"] == null ? null : Src.fromJson(json["src"]);
    }
    if (json["alt"] is String) {
      alt = json["alt"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["id"] = id;
    _data["width"] = width;
    _data["height"] = height;
    _data["url"] = url;
    _data["photographer"] = photographer;
    _data["photographer_url"] = photographerUrl;
    _data["photographer_id"] = photographerId;
    _data["avg_color"] = avgColor;
    if (src != null) {
      _data["src"] = src?.toJson();
    }
    _data["alt"] = alt;
    return _data;
  }
}

class Src {
  String? original;
  String? large2X;
  String? large;
  String? medium;
  String? small;
  String? portrait;
  String? landscape;
  String? tiny;

  Src(
      {this.original,
      this.large2X,
      this.large,
      this.medium,
      this.small,
      this.portrait,
      this.landscape,
      this.tiny});

  Src.fromJson(Map<dynamic, dynamic> json) {
    if (json["original"] is String) {
      original = json["original"];
    }
    if (json["large2x"] is String) {
      large2X = json["large2x"];
    }
    if (json["large"] is String) {
      large = json["large"];
    }
    if (json["medium"] is String) {
      medium = json["medium"];
    }
    if (json["small"] is String) {
      small = json["small"];
    }
    if (json["portrait"] is String) {
      portrait = json["portrait"];
    }
    if (json["landscape"] is String) {
      landscape = json["landscape"];
    }
    if (json["tiny"] is String) {
      tiny = json["tiny"];
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> _data = <String, dynamic>{};
    _data["original"] = original;
    _data["large2x"] = large2X;
    _data["large"] = large;
    _data["medium"] = medium;
    _data["small"] = small;
    _data["portrait"] = portrait;
    _data["landscape"] = landscape;
    _data["tiny"] = tiny;
    return _data;
  }
}
