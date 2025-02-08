


import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';

import '../../../../../export.dart';


class SubscriptionController extends GetxController {

  StreamSubscription? _purchaseUpdatedSubscription;
  StreamSubscription? _purchaseErrorSubscription;
  StreamSubscription? _conectionSubscription;

  CustomLoader customLoader = CustomLoader();

  List subscriptionPlansList = [];

  List<IAPItem> _items = [];
  List<PurchasedItem> _purchases = [];

  List<String> _productLists= Platform.isAndroid
      ? [
    'android.test.purchased',
    'point_1000',
    '5000_point',
    'android.test.canceled',
  ]
      : ['com.cooni.point1000', 'com.cooni.point5000'];

  @override
  void onInit() {
    initPlatformState();
    super.onInit();
  }

  @override
  void onReady() {
    hitSubscriptionPlansListAPI();
    super.onReady();
  }
  @override
  void onClose() {
    super.onClose();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _purchaseUpdatedSubscription!.cancel();
    _purchaseErrorSubscription!.cancel();
    _conectionSubscription!.cancel();
    super.dispose();
  }

  //--------------------------- Get Subscription Plans list from console --------------------------- //
  List<IAPItem> getItem(){
    return _items;
  }

  //--------------------------- Setup flutter in app purchase --------------------------- //
  Future initPlatformState() async {
    String? platformVersion;
    try {
      // platformVersion = await FlutterInappPurchase.instance.;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    var result = await FlutterInappPurchase.instance.initialize();
    try {
      String msg = await FlutterInappPurchase.instance.consumeAll();
     debugPrint('consumeAllItems: $msg');
    } catch (err) {
     debugPrint('consumeAllItems error: $err');
    }



    _conectionSubscription =
        FlutterInappPurchase.connectionUpdated.listen((connected) {
         debugPrint('connected: $connected');
        });

    _purchaseUpdatedSubscription =
        FlutterInappPurchase.purchaseUpdated.listen((productItem) async {
         debugPrint('purchase-updated: $productItem');
          try{
            await FlutterInappPurchase.instance.finishTransaction(productItem!,isConsumable: false);
          }catch(e){
            debugPrint(e.toString());
          }
          hitBuySubscriptionPlanAPI(productItem?.productId);


        });

    _purchaseErrorSubscription =
        FlutterInappPurchase.purchaseError.listen((purchaseError) {
         debugPrint('purchase-error: $purchaseError');
        });
    await _getProduct();
    update();
  }

  //--------------------------- Get Subscription Plans subscribed --------------------------- //
  Future _getProduct() async {
    List<IAPItem> items = await FlutterInappPurchase.instance.getSubscriptions(_productLists).onError((error, stackTrace) => toast(error.toString()));
    for (var item in items) {
     debugPrint(' in app purchase ===> ${item.title}');
      this._items.add(item);
    }
    this._items = items;
    this._purchases = [];
    update();
  }

  //--------------------------- Request purchase for specified item --------------------------- //
  void requestPurchase(IAPItem item,) {
    FlutterInappPurchase.instance.requestSubscription(item.productId!,  ).onError((error, stackTrace) => toast(error.toString()));
    update();
  }

  //--------------------------- Get Subscription Plans list Api --------------------------- //
  hitSubscriptionPlansListAPI() {
    customLoader.show(Get.overlayContext);
    FocusManager.instance.primaryFocus!.unfocus();
    APIRepository.subscriptionPlansListApiCall().then((value) async {
      customLoader.hide();
      if ((value.list?.length ?? 0) > 0) {
        subscriptionPlansList = value.list!;
        update();
      }
    }).onError((error, stackTrace) {
      customLoader.hide();
      toast(error);
    });
  }

  //--------------------------- Buy Subscription Plan Api --------------------------- //
  hitBuySubscriptionPlanAPI(id) {
    customLoader.show(Get.overlayContext);
    FocusManager.instance.primaryFocus!.unfocus();
    APIRepository.buySubscriptionPlanApiCall(id).then((value) async {
      customLoader.hide();
      toast(value.message);
      hitSubscriptionPlansListAPI();
    }).onError((error, stackTrace) {
      customLoader.hide();
      toast(error);
    });
  }


}
