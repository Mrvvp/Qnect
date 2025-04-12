
import 'package:flutter/material.dart';
import 'package:qrowd/view/create_community.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final List<Map<String, dynamic>> communities = [];

  void addCommunity(Map<String, dynamic> community) {
    setState(() {
      communities.add(community);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Communities'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateCommunityPage(
                    onCreate: addCommunity,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: communities.isEmpty
          ? const Center(child: Text('No communities yet. Add one!'))
          : ListView.builder(
              itemCount: communities.length,
              itemBuilder: (context, index) {
                return buildCommunityCard(context, communities[index]);
              },
            ),

    );
  }

  Widget buildCommunityCard(BuildContext context, Map<String, dynamic> community) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          community['image'] != null
              ? Image.file(
                  community['image'],
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : const SizedBox(height: 200, child: Icon(Icons.image)),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  community['name'],
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(community['description']),
                const SizedBox(height: 16.0),
                Text('Culture: ${community['culture']}'),
                Text('Mission: ${community['mission']}'),

                Text('Members: ${community['members']}'),
              ],
            ),
          ),
        ],
      ),
    );
  }

}

