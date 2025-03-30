class ItemProfileEntity {
  final String id;
  final String title;
  final String? description;
  final String imageUrl;
  final String userId;

  ItemProfileEntity({
    required this.id,
    required this.title,
    this.description, // Optional, defaults in ItemModel
    required this.imageUrl,
    required this.userId,
  });
}