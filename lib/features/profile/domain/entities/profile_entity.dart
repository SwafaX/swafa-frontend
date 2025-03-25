class ProfileEntity {
  final String id;
  final String name;
  final String desciption;
  final String avatar;
  final String numSwaps;
  final List<String> itemImages;

  ProfileEntity({
    required this.id,
    required this.name,
    required this.desciption,
    required this.avatar,
    required this.numSwaps,
    required this.itemImages,
  });
}
