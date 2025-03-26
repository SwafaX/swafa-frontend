class ProfileEntity {
  final String id;
  final String name;
  final String? description; // Optional, with default in ProfileModel
  final String avatar;
  final int? numSwaps; // Optional, with default in ProfileModel, changed to int
  final List<String>? itemImages; // Optional, with default in ProfileModel

  ProfileEntity({
    required this.id,
    required this.name,
    this.description, // Not required, defaults to 'No description available'
    required this.avatar,
    this.numSwaps, // Not required, defaults to 0
    this.itemImages, // Not required, defaults to []
  });
}