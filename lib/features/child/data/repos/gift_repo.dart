import 'package:rewarding_kids/core/network/api_constants.dart';
import 'package:rewarding_kids/core/network/api_service.dart';
import 'package:rewarding_kids/features/child/data/models/gift_model.dart';

class GiftsRepository {
  final ApiService api;

  GiftsRepository(this.api);

  /// 🟢 GET Gifts

  Future<List<GiftModel>> getAvailableGifts() async {
    final response = await api.get(ApiConstants.getAvailableGifts);

    final List data = response['data']['items'];
    return data.map((e) => GiftModel.fromJson(e)).toList();
  }

  /// 🔴 Purchase Gift
  Future<dynamic> purchaseGift(String giftId) async {
    final response = await api.post(ApiConstants.purchaseGift(giftId), {});

    return response; // 🔥 مهم
  }

  /// 🟣 GET My Gifts
  Future<List<GiftModel>> getMyRewards() async {
    final response = await api.get(ApiConstants.getmyRewards);

    final List data = response['data'];
    return data.map((e) => GiftModel.fromJson(e)).toList();
  }
}
