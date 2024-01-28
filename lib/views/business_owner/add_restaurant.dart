import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_panda6/views/business_owner/models/request/restaurant_request.dart';
import 'package:food_panda6/views/business_owner/viewmodels/image_viewmodel.dart';
import 'package:food_panda6/views/business_owner/viewmodels/restaurant_viewmodel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../data/response/status.dart';
import '../home/models/restaurant.dart';

class AddRestaurant extends StatefulWidget {
  AddRestaurant({this.restaurant, this.isFromUpdate});

  bool? isFromUpdate;
  Datum? restaurant;

  @override
  State<AddRestaurant> createState() => _AddRestaurantState();
}

class _AddRestaurantState extends State<AddRestaurant> {
  bool isPicked = false;
  var imageFile;
  final _imageViewModel = ImageViewModel();
  final nameController = TextEditingController();
  final categoryController = TextEditingController();
  final discountController = TextEditingController();
  final deliveryFeeController = TextEditingController();
  final deliveryTimeController = TextEditingController();
  final _restaurantViewModel = RestaurantViewmodel();
  var imageId;
  var restaurantId;

  @override
  void initState() {
    super.initState();
    checkIfFromUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              // Image Picker
              Align(
                alignment: Alignment.center,
                child: ChangeNotifierProvider(
                  create: (context) => _imageViewModel,
                  child: Consumer<ImageViewModel>(
                    builder: (ctx, viewModel, _) {
                      if(widget.isFromUpdate!){
                        return InkWell(
                          onTap: () {
                            _getImageFromSource(source: 'camera');
                          },
                          child: Image.network(
                            'https://cms.istad.co${widget.restaurant!.attributes!.picture!.data!.attributes!.url!}',
                            fit: BoxFit.contain,
                          ),
                        );
                      }
                      if (viewModel.response.status == null) {
                        return InkWell(
                          onTap: () {
                            _getImageFromSource(source: 'camera');
                          },
                          child: Image.network(
                            'https://www.shutterstock.com/image-vector/default-ui-image-placeholder-wireframes-600nw-1037719192.jpg',
                            fit: BoxFit.contain,
                          ),
                        );
                      }
                      switch (viewModel.response.status!) {
                        case Status.LOADING:
                          return const Center(
                              child: CircularProgressIndicator());
                        case Status.COMPLETED:
                          imageId = viewModel.response.data[0].id;
                          return InkWell(
                            onTap: () {
                              _getImageFromSource(source: 'camera');
                            },
                            child: SizedBox(
                                width: 350,
                                height: 250,
                                child: Image.network(
                                    'https://cms.istad.co${viewModel.response.data[0].url!}')),
                          );
                        case Status.ERROR:
                          return Text(viewModel.response.message!);
                      }
                    },
                  ),
                ),
              ),
              // Name
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                    hintText: 'Name', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              // Category
              TextField(
                controller: categoryController,
                decoration: InputDecoration(
                    hintText: 'Category', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              // Discount
              TextField(
                controller: discountController,
                decoration: InputDecoration(
                    hintText: 'Discount', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              // Delivery Fee
              TextField(
                controller: deliveryFeeController,
                decoration: InputDecoration(
                    hintText: 'Delivery Fee', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              // Delivery Time
              TextField(
                controller: deliveryTimeController,
                decoration: InputDecoration(
                    hintText: 'Time', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              ChangeNotifierProvider(
                create: (context) => _restaurantViewModel,
                child: Consumer<RestaurantViewmodel>(
                  builder: (ctx, viewModel, _) {
                    if(viewModel.response.status == null) {
                      return ElevatedButton(
                          onPressed: () {
                            _saveRestaurant();
                          },
                          child: widget.isFromUpdate! ? Text('Update') : Text('Save'));
                    }
                    switch (viewModel.response.status!) {
                      case Status.LOADING:
                        return const Center(child: CircularProgressIndicator());
                      case Status.COMPLETED:
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ScaffoldMessenger.of(ctx).showSnackBar(
                              const SnackBar(content: Text('Post Success'))
                          );
                        });
                        return ElevatedButton(
                            onPressed: () {
                              _saveRestaurant();
                            },
                            child: Text('Save'));
                      case Status.ERROR:
                        return Text(viewModel.response.message!);
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _getImageFromSource({source}) async {
    // print('picking image ');
    XFile? pickedFile = await ImagePicker().pickImage(
        source: source == "gallery" ? ImageSource.gallery : ImageSource.camera);
    if (pickedFile != null) {
      // uploading image to server
      _imageViewModel.uploadImage(pickedFile.path);
      // setState(() {
      //   isPicked = true;
      //   imageFile = File(pickedFile.path);
      // });
      // print('Picked Image : ${File(pickedFile.path)}');
    }
  }

  void _saveRestaurant() {
    var restaurantRequest = RestaurantRequest(
        data: DataRequest(
            name: nameController.text,
            category: categoryController.text,
            discount: int.parse(discountController.text),
            deliveryFee: double.parse(deliveryFeeController.text),
            deliveryTime: int.parse(deliveryTimeController.text),
            picture: imageId.toString()));
    _restaurantViewModel.postRestaurant(restaurantRequest,
              isUpdate: widget.isFromUpdate,
              id: restaurantId
        );
  }

  void checkIfFromUpdate() {
    if(widget.isFromUpdate!){
      nameController.text = widget.restaurant!.attributes!.name!;
      categoryController.text = widget.restaurant!.attributes!.category!;
      discountController.text = widget.restaurant!.attributes!.discount!.toString();
      deliveryFeeController.text = widget.restaurant!.attributes!.deliveryFee.toString();
      deliveryTimeController.text = widget.restaurant!.attributes!.deliveryTime.toString();
      imageId = widget.restaurant!.attributes!.picture!.data!.id;
      restaurantId = widget.restaurant!.id;
    }
  }
}
