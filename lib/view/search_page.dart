import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qrowd/model/event_model.dart';
import 'package:latlong2/latlong.dart';
import 'package:qrowd/view/event_details_page.dart';

// At the top level (outside of any classes)
final typeProvider = FutureProvider<List<String>>((ref) async {
  final snapshot =
      await FirebaseFirestore.instance.collection('Category').get();
  return snapshot.docs
      .map((doc) => (doc.data()['type'] ?? '').toString().toLowerCase())
      .where((name) => name.isNotEmpty)
      .toList();
});

final searchQueryProvider = StateProvider<String>((ref) => '');
final selectedtypeProvider = StateProvider<String>((ref) => '');

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CupertinoSearchTextField(
                      controller: _searchController,
                      placeholder: 'Music, Sports, Live band',
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      onChanged: (value) {
                        ref.read(searchQueryProvider.notifier).state =
                            value.toLowerCase();
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('Cancel', style: TextStyle(color: Colors.black)),
                ],
              ),
              const SizedBox(height: 12),
              // Use Riverpod provider to fetch categories
              Builder(builder: (context) {
                final categoriesAsync = ref.watch(typeProvider);
                return categoriesAsync.when(
                  data: (categories) => SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: categories.map((category) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: ChoiceChip(
                            label: Text(category,
                                style: TextStyle(color: Colors.red)),
                            selected:
                                ref.watch(selectedtypeProvider) == category,
                            onSelected: (selected) {
                              ref.read(selectedtypeProvider.notifier).state =
                                  selected ? category : '';
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  loading: () => Center(child: CircularProgressIndicator()),
                  error: (err, _) => Text('Error loading categories: $err'),
                );
              }),
              const Divider(height: 32),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('events')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    final query = ref.watch(searchQueryProvider);
                    final selectedCategory = ref.watch(selectedtypeProvider);

                    final filteredDocs = snapshot.data!.docs.where((doc) {
                      final data = doc.data() as Map<String, dynamic>;
                      final name =
                          (data['name'] ?? '').toString().toLowerCase();
                      final type =
                          (data['type'] ?? '').toString().toLowerCase();

                      final matchesQuery =
                          query.isEmpty || name.contains(query);
                      final matchesCategory =
                          selectedCategory == '' || type == selectedCategory;

                      return matchesQuery && matchesCategory;
                    }).toList();

                    return ListView.separated(
                      itemCount: filteredDocs.length,
                      separatorBuilder: (_, __) => Divider(),
                      itemBuilder: (context, index) {
                        final doc = filteredDocs[index];
                        final data = doc.data() as Map<String, dynamic>;

                        return ListTile(
                          title: Text(data['name'] ?? 'Unnamed Event'),
                          onTap: () {
                            final event = EventModel(
                              id: doc.id,
                              name: data['name'] ?? '',
                              location: LatLng(
                                (data['latitude'] as num).toDouble(),
                                (data['longitude'] as num).toDouble(),
                              ),
                              imageUrl: data['imageurl'] ?? '',
                              time: data['time'] ?? '',
                              address: data['address'] ?? '',
                              description: data['description'] ?? '',
                              price: (data['price'] as num?)?.toDouble() ?? 0.0,
                              isAvailable: data['isAvailable'] ?? true,
                              date: data['date'] ?? '',
                              type: data['type'] ?? '',
                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => EventDetailPage(event: event),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
