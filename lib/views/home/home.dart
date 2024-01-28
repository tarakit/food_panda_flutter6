import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:food_panda6/data/response/status.dart';
import 'package:food_panda6/views/business_owner/add_restaurant.dart';
import 'package:food_panda6/views/home/skeletons/restaurant_ske.dart';
import 'package:food_panda6/views/home/viewmodels/restaurant_vm.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'widgets/drawer.dart';
import 'widgets/restaurant.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final boxDecoration = BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.circular(20));

  var _restaurantViewModel = RestaurantViewModel();

  @override
  void initState() {
    super.initState();
    _restaurantViewModel.getAllRestaurant();

    //Remove this method to stop OneSignal Debugging
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

    OneSignal.initialize("b603d396-bee7-4014-b984-f7bdaccc2c0f");

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    OneSignal.Notifications.requestPermission(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('2 St 24'),
            Text('Phnom Penh', style: TextStyle(fontSize: 12)),
          ],
        ),
        // leadingWidth: 35,
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(
                    builder: (context) => AddRestaurant(isFromUpdate: false)));
          }, icon: Icon(Icons.favorite)),
          IconButton(onPressed: () {}, icon: Icon(Icons.shopping_basket))
        ],
      ),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Food Delivery
            Container(
              margin: EdgeInsets.all(13),
              width: double.infinity,
              // height: 220,
              decoration: boxDecoration,
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 15, left: 15, right: 5, bottom: 5),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Food Delivery',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold)),
                      const Text('Order food you love',
                          style: TextStyle(fontSize: 13)),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Image.asset(
                          'assets/images/burger.png',
                          fit: BoxFit.contain,
                          width: 100,
                          height: 100,
                        ),
                      )
                    ]),
              ),
            ),
            // Second Section
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.only(left: 15, right: 7.5),
                    height: 300,
                    decoration: boxDecoration,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 300,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            margin: EdgeInsets.only(
                                right: 15,
                                left: 7.5,
                                bottom: 7.5
                              ),
                            decoration: boxDecoration,
                            width: double.infinity,
                            // height: 50,
                          ),
                        ),

                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: EdgeInsets.only(right: 15, left: 7.5,
                            top: 7.5),
                            decoration: boxDecoration,
                            width: double.infinity,
                            // height: 50,
                          ),
                        ),

                      ],
                    ),
                  )
                ),
              ],
            ),
            // Top Restaurants
            const Padding(
              padding: EdgeInsets.only(left: 15, bottom: 10),
              child: Text('Top Restaurant', style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold),),
            ),
            SizedBox(
              height: 350,
              child: ChangeNotifierProvider(
                create: (context) => _restaurantViewModel,
                child: Consumer<RestaurantViewModel>(
                  builder: (context, viewModel, _){
                    switch(viewModel.response.status!){
                      case Status.LOADING:
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (context, index) => RestaurantCardSkeleton()
                        );
                      case Status.COMPLETED:
                        return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              var restaurant = viewModel.response.data!.data![index];
                              return RestaurantCard(restaurant: restaurant);
                            }
                        );
                      case Status.ERROR:
                        return Text('Error');
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

