class BookModel {

  final List<Model> books;
  BookModel({this.books});

  factory BookModel.fromJson(Map<String, dynamic> json) {
    var bookList = json['results']['books'] as List;
    List<Model> booksList =
    bookList.map((i) => Model.fromJson(i)).toList();

    return BookModel(
        books: booksList
    );
  }
}
class Model {
  final String description , title , author , book_image , amazon_product_url;

  Model({this.description, this.title, this.author , this.book_image , this.amazon_product_url});

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      description: json['description'],
      title: json['title'],
      author: json['author'],
      book_image: json['book_image'],
      amazon_product_url: json['amazon_product_url'],
    );
  }
}