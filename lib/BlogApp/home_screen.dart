import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'post_details_screen.dart';
import 'create_post_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> users = [];
  List<Map<String, dynamic>> posts = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    //Data From User API
    final usersResponse = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    //Data From Posts API
    final postsResponse = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (usersResponse.statusCode == 200 && postsResponse.statusCode == 200) {
      setState(() {
        users = List<Map<String, dynamic>>.from(json.decode(usersResponse.body));
        posts = List<Map<String, dynamic>>.from(json.decode(postsResponse.body));
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  void _deletePost(int postId) {
    setState(() {
      posts.removeWhere((post) => post['id'] == postId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Blog App'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DropdownButtonFormField(
            items: users.map((user) {
              return DropdownMenuItem(
                value: user['id'],
                child: Text(user['name']),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                posts = List<Map<String, dynamic>>.from(posts.where((post) => post['userId'] == value));
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(posts[index]['title']),
                  subtitle: Text(posts[index]['body']),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deletePost(posts[index]['id']),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PostDetailsScreen(post: posts[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreatePostScreen(),
            ),
          ).then((value) {
            if (value != null) {
              // Add the new post to the list
              setState(() {
                posts.add(value);
              });
            }
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
