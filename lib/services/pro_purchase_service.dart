import 'package:in_app_purchase/in_app_purchase.dart';
import '../models/pro_store.dart';

class ProPurchaseService {
  final InAppPurchase _iap = InAppPurchase.instance;

  static const String proId = 'pro_monthly';

  Future<void> restore() async {
    final available = await _iap.isAvailable();
    if (!available) return;

    _iap.purchaseStream.listen((purchases) {
      for (final purchase in purchases) {
        if (purchase.productID == proId &&
            purchase.status == PurchaseStatus.purchased) {
          ProStore.isPro = true;
        }
      }
    });
  }
}
