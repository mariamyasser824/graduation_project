import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewarding_kids/features/adventures/cubits/adventure_cubit/adventure_cubit.dart';
import 'package:rewarding_kids/features/adventures/cubits/adventure_cubit/adventure_state.dart';
import 'package:rewarding_kids/features/adventures/widgets/adventure_details_card.dart';
import 'package:rewarding_kids/features/adventures/widgets/adventure_header_image.dart';

class AdventureDetailsView extends StatelessWidget {
  const AdventureDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9CDF0),
      body: BlocBuilder<AdventureCubit, AdventureState>(
        builder: (context, state) {
          if (state is AdventureDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AdventureDetailsSuccess) {
            final details = state.details;

            return Stack(
              children: [
                AdventureHeaderImage(image: 'assets/child/adv_backgound.jpg'),

                AdventureDetailsCard(
                  details: details, // 🔥 نبعت الداتا
                ),
              ],
            );
          }

          if (state is AdventureDetailsError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox();
        },
      ),
    );
  }
}
