class Transactions {
  final int? keyID;
  final String title;
  final String authors;
  final String genres;
  final String status;
  final String synopsis;
  final String imageUrl;

  Transactions({
    this.keyID,
    required this.title,
    required this.authors,
    required this.genres,
    required this.status,
    required this.synopsis,
    required this.imageUrl,
  });
}
