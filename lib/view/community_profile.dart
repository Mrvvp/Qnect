import 'package:flutter/material.dart';

class CommunityMediaPage extends StatelessWidget {
  const CommunityMediaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
                      image: AssetImage(
                          'lib/assets/images/Dark Party event banner 1.png'),
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
                        'Lorem ipsum dolor',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Nunc nullam id imperdiet pellentesque quam.',
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
                  _mediaTile('lib/assets/images/Google Images 1.png'),
                  _mediaTile('lib/assets/images/Rectangle 7.png'),
                  _mediaTile('lib/assets/images/Rectangle 8.png'),
                  _mediaTile('lib/assets/images/Google Images 1.png'),
                  _mediaTile('lib/assets/images/Rectangle 7.png'),
                  _mediaTile('lib/assets/images/Rectangle 8.png'),
                  _mediaTile('lib/assets/images/Google Images 1.png'),
                  _mediaTile('lib/assets/images/Rectangle 7.png'),
                  _mediaTile('lib/assets/images/Rectangle 8.png'),
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

  Widget _mediaTile(String imagePath) {
    return ClipRRect(
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
    );
  }
}
