import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
void main() => runApp(MyApp());
class RandomEnglishWords extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RandomEnglishWordsState();
    //! return a state's object. where is the state's class?
  }
}

// state
class RandomEnglishWordsState extends State<RandomEnglishWords> {
   final _words = <WordPair>[]; //! Words displayed in ListView, 1 row contains 1 word
   final _checkWords = new Set<WordPair>(); //! set contains "no duplicate items"
  @override
  Widget build(BuildContext context) {
   //! now we replace this with a scaffold widget which contains a ListView
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Demo ListView'),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), 
          onPressed: _pushToSavedWordsScreen)
        ],
      ),
   
      body: new ListView.builder(itemBuilder: (context,index){
        //! this is an anoymous function
        //!index = 0,1,2,3...
        //! this is function return each Row = "a Widget"
        if(index >= _words.length){
          _words.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_words[index], index);//! Where is _builRow?
      }),
    );
  }
   //! onPressed sử lý sự kiện khi người dùng nhấn vào icon đó
    _pushToSavedWordsScreen(){
      //! to navigate, you must have a "route"
      final pageRoute = new MaterialPageRoute(builder: (context){
        //! map function = Convert this list to another list(maybe different object's type)
        //! _checkedWords(list of WordPair) => map =>
        //! converted to a lazy list(Iterable) of ListTile
        final listTiles = _checkWords.map((wordPair){
          return new ListTile(
              title: new Text(wordPair.asUpperCase,
              style: new TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),)
          );
        });
      //! now return a widget, we choose "Scaffold"
      return new Scaffold(
        appBar: new AppBar(
          title: new Text("Check words"), //! title App
        ),
        body: new ListView(children: listTiles.toList(),), //! lazy list(Iterable) => List
      );
      });
      Navigator.of(context).push(pageRoute);
    }


  Widget _buildRow(WordPair wordPair, int index){
  // this widget is for each row
  final textColor = index % 2 == 0 ? Colors.orange : Colors.purple;
  final isChecked = _checkWords.contains(wordPair);
  return new ListTile(
    // leading= left, leading = right. Is it correct ? Not yet
    leading: new Icon(
      isChecked ? Icons.check_box: Icons.check_box_outline_blank,
      color:textColor,
      ),
    title: new Text(
      wordPair.asUpperCase,
      style: new TextStyle(fontSize: 18.0,color: textColor),
    ),
    onTap: (){
      setState(() {
        // this is an anonymous fuction
        if(isChecked){
          _checkWords.remove(wordPair); //remove item in a set.
        }
        else
        {
          _checkWords.add(wordPair); // add item to a set
        }
      });
    },
  );
}
}


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //! build function return a "Widget"
    //! final giống như const là hằng số không thể thay đổi được
    return MaterialApp(
      //! widget with "Matterial Design"
      //! thiết kế kiểu dạng vật liệu
      title: "This is my first Flutter App",
      home: new RandomEnglishWords()
    );
  }
}
