import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewarding_kids/features/child/cubit/gift_state.dart';
import 'package:rewarding_kids/features/child/data/repos/gift_repo.dart';

class GiftsBloc extends Bloc<GiftsEvent, GiftsState> {
  final GiftsRepository repo;

  GiftsBloc(this.repo) : super(GiftsInitial()) {
    /// 🟡 Available Gifts (Store)
    on<GetGiftsEvent>((event, emit) async {
      emit(GiftsLoading());

      try {
        final gifts = await repo.getAvailableGifts();
        emit(GiftsLoaded(gifts, GiftsMode.store));
      } catch (e) {
        emit(GiftsError(e.toString()));
      }
    });

    /// 🟣 My Rewards
    on<GetRewardsEvent>((event, emit) async {
      emit(GiftsLoading());

      try {
        final gifts = await repo.getMyRewards();
        emit(GiftsLoaded(gifts, GiftsMode.rewards));
      } catch (e) {
        emit(GiftsError(e.toString()));
      } 
    });

    /// 🔴 Buy Gift
    on<BuyGiftEvent>((event, emit) async {
      emit(GiftBuying(event.giftId));

      try {
        final response = await repo.purchaseGift(event.giftId);
        final remainingPoints = response['data']['remainingPoints'];

        emit(GiftPurchaseSuccess(remainingPoints));

        /// 🔥 مهم: refresh store list بعد الشراء
        final gifts = await repo.getAvailableGifts();
        emit(GiftsLoaded(gifts, GiftsMode.store));
      } catch (e) {
        if (e.toString().toLowerCase().contains("point")) {
          emit(NotEnoughPoints("Not enough points"));
        } else {
          emit(GiftsError(e.toString()));
        }

        /// 🔥 fallback refresh
        final gifts = await repo.getAvailableGifts();
        emit(GiftsLoaded(gifts, GiftsMode.store));
      }
    });
  }
}
