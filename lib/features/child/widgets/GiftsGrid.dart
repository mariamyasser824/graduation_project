import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewarding_kids/features/child/cubit/gift_bloc.dart';
import 'package:rewarding_kids/features/child/cubit/gift_state.dart';
import 'package:rewarding_kids/features/child/data/models/gift_model.dart';
import 'package:rewarding_kids/features/child/widgets/GiftCard.dart';

class GiftsGrid extends StatelessWidget {
  final List<GiftModel> gifts;
  final String buttonText;
  final BoxFit fit;

  const GiftsGrid({
    super.key,
    required this.gifts,
    required this.buttonText,
    required this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.65,
      ),
      itemCount: gifts.length,
      itemBuilder: (context, index) {
        final gift = gifts[index];

        return BlocBuilder<GiftsBloc, GiftsState>(
          builder: (context, state) {
            final isLoading = state is GiftBuying && state.giftId == gift.id;

            return GiftCard(
              title: gift.name,
              imageUrl: gift.image,
              points: gift.points,
              buttonText: isLoading ? 'Loading...' : buttonText,
              onPressed: isLoading
                  ? null
                  : () {
                      context.read<GiftsBloc>().add(BuyGiftEvent(gift.id));
                    },
              fit: fit,
            );
          },
        );
      },
    );
  }
}
