import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:layout/pages/detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แอพความรู้เกี่ยวกับคอมพิวเตอร์'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: DefaultAssetBundle.of(context).loadString('assets/data.json'),
          builder: (context, snapshot) {
            var data = json.decode(snapshot.data.toString()); // [{}, {}, {}]
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return myBox(
                  data[index]['title'],
                  data[index]['subtitle'],
                  data[index]['image_url'],
                  data[index]['detail'],
                );
              },
              itemCount: data.length,
            );
          },
        ),
      ),
    );
  }

  Widget myBox(String title, String subtitle, String image_url, String detail) {
    var v1, v2, v3, v4;
    v1 = title;
    v2 = subtitle;
    v3 = image_url;
    v4 = detail;
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(20),
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
          image: NetworkImage(image_url),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.25), BlendMode.darken),
          opacity: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 25, color: Colors.white)),
          const SizedBox(height: 10),
          Text(subtitle,
              style: const TextStyle(fontSize: 18, color: Colors.white)),
          TextButton(
            onPressed: () {
              setState(() {
                print('Next Page');
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailPage(v1, v2, v3, v4)));
              });
            },
            child: Text('Next Page', style: TextStyle(fontSize: 20)),
          )
        ],
      ),
    );
  }
}
