import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class RestaurantCardSkeleton extends StatelessWidget {
  const RestaurantCardSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        margin: EdgeInsets.only(left: 15),
        width: MediaQuery.of(context).size.width * .75,
        height: 350,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      color: Colors.white,
                      width: MediaQuery.of(context).size.width * .75,
                      height: 220,
                    )),
                Positioned(
                  top: 15,
                  child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          // color: Colors.pink,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8))),
                      child: Text('15%',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold))),
                ),

                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          // color: Colors.pink,
                          borderRadius: BorderRadius.circular(18)),
                      child: Text('25mn',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold))),
                )
              ],
            ),
            SizedBox(height: 8),
            Text('Tube Coffee', style: TextStyle(fontWeight: FontWeight.bold,
                fontSize: 20
            ),),
            SizedBox(height: 5),
            Text('\$\$\$ Coffee'),
            SizedBox(height: 5),
            Text('\$ 0.75 delivery fee')
          ],
        ),
      ),
    );
  }
}
