class UserReserve {
  int? prix;
  String? itemName;
  String? description;

  UserReserve({
    this.itemName,
    this.prix,
    this.description,
  });

  factory UserReserve.toMap(Map) {
    return UserReserve(
      itemName: Map['itemName'],
      prix: Map['prix'],
      description: Map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'prix': prix,
      'itemName': itemName,
      'description': description,
    };
  }
}
