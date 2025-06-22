import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class CommunityMediaPage extends StatelessWidget {
  final Map<String, dynamic> communityData;

  const CommunityMediaPage({super.key, required this.communityData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner with image and buttons
            Stack(
              children: [
                Container(
                  height: 260,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(communityData['imageUrl']),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        communityData['Name'],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        communityData['description'],
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.orange),
                              backgroundColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Text('Follow',
                                style: TextStyle(color: Colors.orange)),
                          ),
                          SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Text(
                              'Message',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Grid layout with 3 asset images
            SizedBox(
              height: 720,
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                physics: NeverScrollableScrollPhysics(),
                children: [
                  _mediaTile(context,'lib/assets/images/Google Images 1.png'),
                  _mediaTile(context,'lib/assets/images/Rectangle 7.png'),
                  _mediaTile(context,'lib/assets/images/Rectangle 8.png'),
                  _mediaTile(context,'lib/assets/images/Google Images 1.png'),
                  _mediaTile(context,'lib/assets/images/Rectangle 7.png'),
                  _mediaTile(context,'lib/assets/images/Rectangle 8.png'),
                  _mediaTile(context,'lib/assets/images/Google Images 1.png'),
                  _mediaTile(context,'lib/assets/images/Rectangle 7.png'),
                  _mediaTile(context,'lib/assets/images/Rectangle 8.png'),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  Widget _mediaTile(BuildContext context,String imagePath) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            backgroundColor: Colors.transparent,
            child: InteractiveViewer(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(imagePath, fit: BoxFit.contain),
              ),
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 170,
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Icon(Icons.play_circle_fill, size: 40, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
