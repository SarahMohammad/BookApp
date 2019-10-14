import 'package:flutter/material.dart';
import 'dart:convert';
import 'book_model.dart';
import 'package:http/http.dart' as http;

class BooksPage extends StatefulWidget {
  @override
  _BooksPageState createState() => _BooksPageState();
}

class _BooksPageState extends State<BooksPage> {

  Future book_data;



  Future<BookModel> fetchBooksData() async {
    String apiKey = 'XUdfeJ2nkG65kl7xp1OWZfA3d3GRWtbH';
    String catAPIURL = 'https://api.nytimes.com/svc/books/v3/lists/current/hardcover-fiction.json?';
    String apiKeyString = 'api-key=$apiKey';

    final response =
    await http.get('$catAPIURL$apiKeyString');

    if (response.statusCode == 200) {
      var list =  BookModel.fromJson(json.decode(response.body));
      print(list.toString());
      return BookModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load');
    }
  }


//  var name;
//  void getBooksData() async {
//    var result = await BOOKAPI().getbooksList();
//    Map<String, dynamic> book = jsonDecode(result);
//    setState(() {
//      name = book['results']['books'];
//    });
//    print(name);
//  }
  @override
  void initState() {
    super.initState();
   book_data = fetchBooksData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0 ,
        backgroundColor: Color(0xffabd2da),
        title: Text('Books' ,),
      ),
      backgroundColor: Color(0xffFFCCCC),
      body:  Container(
        child:
        FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return GridView.builder(
                itemCount: snapshot.data.books.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height),
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6.0, vertical: 5.0),
                    child: new Container(
                      decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(
                              snapshot.data.books[index].book_image ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Container(
                color: Colors.black,
                child: Center(
                  child: Text(
                    "loading",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            }
          },
          future: book_data,
        ),
      ),
    );
  }
}
