import 'package:flutter/material.dart';

import '../../../models/messItem.dart';

class RecCard extends StatelessWidget {
  final MessItem data;
  final Color color;
  const RecCard({
    Key? key,
    required this.data,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: (data.checkEnd == 1)
                      ? NetworkImage(data.userPic)
                      : const NetworkImage(
                          'https://tse4.mm.bing.net/th?id=OIP.gP1tVKJUehx7kX43qmrSswHaHa&pid=Api&P=0&w=172&h=172',
                        ),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (data.border1 == 30)
                    ? Row(
                        children: [
                          const SizedBox(width: 10),
                          Text(
                            data.username,
                            style: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      )
                    : Container(),
                (data.typeOfMessage == 0)
                    ? Container(
//          margin: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.only(
                            topRight: const Radius.circular(30),
                            topLeft: Radius.circular(data.border1 as double),
                            bottomRight: const Radius.circular(30),
                            bottomLeft: Radius.circular(data.border2 as double),
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        child: Text(
                          data.tittle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      )
                    : (data.typeOfMessage == 1)
                        ? InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => Dialog(
                                  backgroundColor: Colors.transparent,
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width - 10,
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 255, 252, 227),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width -
                                          20,
                                      height:
                                          MediaQuery.of(context).size.height /
                                                  3 -
                                              10,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(data.tittle),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: MediaQuery.of(context).size.height / 5,
                              width: MediaQuery.of(context).size.width / 2.2,
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 222, 236, 238),
                                borderRadius: BorderRadius.only(
                                  topRight: const Radius.circular(30),
                                  topLeft:
                                      Radius.circular(data.border1 as double),
                                  bottomRight: const Radius.circular(30),
                                  bottomLeft:
                                      Radius.circular(data.border2 as double),
                                ),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(data.tittle),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(
                            height: 50,
                            width: 50,
                            child: Image(
                              fit: BoxFit.fill,
                              image: NetworkImage(data.tittle),
                            ),
                          ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
