import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Welcome to Flutter',
      home: new RandomWords(),
    );
  }
}

class RandomWords extends StatefulWidget {
  @override
  createState() => new RandomWordState();


}

class RandomWordState extends State<RandomWords>  {

  var suggestions = <WordPair>[];

  var biggerFont = const TextStyle(fontSize: 18.0);

  var saved = new Set<WordPair>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Start Up Name Generator"),
        actions: <Widget>[
          new IconButton(icon: new Icon(Icons.list), onPressed: pushSaved),
        ],
      ),
      body: buildSuggestions(),
    );
  }

  Widget buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return new Divider();

        var index = i ~/ 2;

        if(index >= suggestions.length)
          suggestions.addAll(generateWordPairs().take(10));

        return buildRow(suggestions[index]);
      }
    );
  }

  Widget buildRow(WordPair pair) {
    var alreadySaved = saved.contains(pair);

    return new ListTile(
      title: new Text(
        pair.asPascalCase,
        style: biggerFont,
      ),
      trailing: new Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.purple : null,
      ),
      onTap: () {
        setState(() {
          alreadySaved ? saved.remove(pair) : saved.add(pair);
        });
      },
    );
  }

  void pushSaved() {
    Navigator.of(context).push(
      new MaterialPageRoute(
          builder: (context) {
            var tiles = saved.map(
                (pair) {
                  return new ListTile(
                    title: new Text(
                      pair.asPascalCase,
                      style: biggerFont,
                    ),
                  );
                },
            );

            var dividend = ListTile
            .divideTiles(
                context: context,
                tiles: tiles,)
            .toList();

            return new Scaffold(
              appBar: new AppBar(
                title: new Text("STAAAAAAAAN"),
              ),
              body: new ListView(children: dividend,),
            );
          })
    );
  }
}

