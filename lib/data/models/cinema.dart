class Cinema {
  final String? id;
  final String? displayName;
  final String? link;
  final String? address;

  const Cinema({
    required this.id,
    required this.displayName,
    required this.link,
    required this.address,
  });

  Cinema.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        displayName = json['displayName'],
        link = json['link'],
        address = json['address'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['displayName'] = displayName;
    data['link'] = link;
    data['address'] = address;
    return data;
  }
}
