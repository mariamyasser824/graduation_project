import 'package:rewarding_kids/features/child/data/models/gift_model.dart';

abstract class GiftsState {}

class GiftsInitial extends GiftsState {}

class GiftsLoading extends GiftsState {}

enum GiftsMode {
  rewards, // Gifts from parent
  store, // Available gifts
}

class GiftsLoaded extends GiftsState {
  final List<GiftModel> gifts;
  final GiftsMode mode;

  GiftsLoaded(this.gifts, this.mode);
}

class GiftsError extends GiftsState {
  final String message;

  GiftsError(this.message);
}

/// 🔥 Loading لعنصر معين
class GiftBuying extends GiftsState {
  final String giftId;

  GiftBuying(this.giftId);
}

/// ❌ مش كفاية points
class NotEnoughPoints extends GiftsState {
  final String message;

  NotEnoughPoints(this.message);
}

/// ✅ نجاح الشراء + باقي النقاط
class GiftPurchaseSuccess extends GiftsState {
  final int remainingPoints;

  GiftPurchaseSuccess(this.remainingPoints);
}

abstract class GiftsEvent {}

class GetGiftsEvent extends GiftsEvent {}

class BuyGiftEvent extends GiftsEvent {
  final String giftId;

  BuyGiftEvent(this.giftId);
}

class GetRewardsEvent extends GiftsEvent {}
