import 'package:flutter/material.dart';
import 'package:tiktok_clone/screens/profileUser/widgets/displayVideo.dart';

import '../../../models/video.dart';

class VideoFavCard extends StatelessWidget {
  final Video data;
  const VideoFavCard({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 255, 252, 227),
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              backgroundColor: Colors.transparent,
              child: DisPlayVideo(
                size: MediaQuery.of(context).size,
                video: data,
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      data.thumbNailsPath,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.person,
                        color: Color.fromARGB(255, 32, 211, 234),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        data.username,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      const Text(' '),
                      Text(
                        data.caption,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 3),
                  RichText(
                    text: TextSpan(
                      text: '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      children: [
                        const TextSpan(
                          text: 'View ',
                          style: TextStyle(
                            color: Color.fromARGB(255, 32, 211, 234),
                          ),
                        ),
                        const TextSpan(
                          text: '20.11k',
                          style: TextStyle(color: Colors.black),
                        ),
                        const TextSpan(
                          text: '|',
                          style: TextStyle(color: Colors.grey),
                        ),
                        const TextSpan(
                          text: 'Likes ',
                          style: TextStyle(
                            color: Color.fromARGB(255, 32, 211, 234),
                          ),
                        ),
                        TextSpan(
                          text: data.likes.length.toString(),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(
                Icons.favorite,
                color: Color.fromARGB(255, 250, 45, 108),
              )
            ],
          ),
        ),
      ),
    );
  }
}
