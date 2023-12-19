class PrintModel {

  final String judul;
  final String name;
  final String description;
  final String price;
  final String date;

  PrintModel({
    required this.judul,
    required this.name,
    required this.description,
    required this.price,
    required this.date,
  });

  factory PrintModel.fromJson(Map<String, dynamic> json) {
    return PrintModel(
      judul: json['judul'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      date: json['date'],
    );
  }
}
