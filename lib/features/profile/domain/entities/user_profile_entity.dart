class UserProfileEntity {
  final String id;
  final String name;
  final String avatar;
  final String description;
  final int numSwaps;


  UserProfileEntity({
    required this.id,
    required this.name,
    required this.avatar,
    required this.description,
    required this.numSwaps, // Optional, defaults in ItemModel
  });
}