class Note {
  final int id;
  final String title;
  final String description;
  final String photo_id;
  final double price;
  bool isFavorite;

  Note({
    required this.id,
    required this.title,
    required this.description,
    required this.photo_id,
    required this.price,
    this.isFavorite = false,
  });
}
