import 'package:flutter/material.dart';
import 'package:ungshoppee/models/order_model.dart';
import 'package:ungshoppee/models/product_model.dart';
import 'package:ungshoppee/utility/my_style.dart';

class Detail extends StatefulWidget {
  final ProductModel productModel;

  Detail({Key key, this.productModel}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  // Field
  ProductModel currentProductModel;
  OrderHelper orderHelper = OrderHelper();

  // Method
  @override
  void initState() {
    super.initState();
    currentProductModel = widget.productModel;
  }

  Widget orderButton() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        addValueToSQLite();

        // Navigator.of(context).pop();
      },
    );
  }

  Future<void> addValueToSQLite() async {
    OrderModel orderModel = OrderModel(
      idOrder: currentProductModel.id,
      order: currentProductModel.nameFood,
      price: currentProductModel.price,
    );

    
    orderHelper.insertOrder(orderModel);

    List<OrderModel> orderModels = await orderHelper.getAllSQLite();
    print('orderModel.length ====>>> ${orderModels.length}');

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: orderButton(),
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              currentProductModel.nameFood,
              style: MyStyle().headTextStyle,
            ),
            Text(
              currentProductModel.detail,
              style: MyStyle().bodyTextStyle,
            ),
            Text(
              'Price = ${currentProductModel.price}',
              style: MyStyle().headColorTextStyle,
            )
          ],
        ),
      ),
    );
  }
}
