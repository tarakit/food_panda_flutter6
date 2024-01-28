import 'package:flutter/material.dart';
import 'package:food_panda6/data/response/status.dart';
import 'package:food_panda6/views/business_owner/add_restaurant.dart';
import 'package:food_panda6/views/home/models/restaurant.dart';
import 'package:food_panda6/views/home/viewmodels/restaurant_vm.dart';
import 'package:provider/provider.dart';

class RestaurantCard extends StatelessWidget {
  RestaurantCard({
      this.restaurant
  });

  Datum? restaurant;
  var restaurantViewModel = RestaurantViewModel();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                width: double.infinity,
                height: 150,
                color: Colors.pinkAccent.shade100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Are you sure to remove this Restaurant?',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                    ChangeNotifierProvider(
                      create: (context) => restaurantViewModel,
                      child: Consumer<RestaurantViewModel>(
                        builder: (context, viewmodel, _){
                          if(viewmodel.response.status == Status.COMPLETED){
                            print('delete complete');
                            Navigator.pop(context);
                          }
                          return TextButton(onPressed: (){
                            restaurantViewModel.deleteRestaurant(restaurant!.id);
                          }, child: Text('Yes'));
                        },
                      ),
                    ),
                    TextButton(onPressed: (){}, child: Text('No'))
                  ],
                ),
              ) ;
            }
        );
      },
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => AddRestaurant(isFromUpdate: true, restaurant: restaurant)));
      },
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
                      height: 260,
                      width: MediaQuery.of(context).size.width * .75,
                      child: Image.network(
                        'https://cms.istad.co${restaurant!.attributes!.picture!.data!.attributes!.url!}',
                        fit: BoxFit.fill,
                      ),
                    )),
                Positioned(
                  top: 15,
                  child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.pink,
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
                          color: Colors.pink,
                          borderRadius: BorderRadius.circular(18)),
                      child: Text('${restaurant!.attributes!.deliveryTime!}mn',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold))),
                )
              ],
            ),
            SizedBox(height: 8),
            Text(restaurant!.attributes!.name.toString(), style: TextStyle(fontWeight: FontWeight.bold,
                fontSize: 20
            ),),
            SizedBox(height: 5),
            Text('\$\$\$ ${restaurant!.attributes!.category}'),
            SizedBox(height: 5),
            Text('\$ ${restaurant!.attributes!.deliveryFee} delivery fee')
          ],
        ),
      ),
    );
  }
}
