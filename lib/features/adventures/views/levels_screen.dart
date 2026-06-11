import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rewarding_kids/features/adventures/cubits/adventure_cubit/adventure_cubit.dart';
import 'package:rewarding_kids/features/adventures/cubits/adventure_cubit/adventure_state.dart';
import 'package:rewarding_kids/features/adventures/widgets/Ievel_body.dart';

class LevelsScreen extends StatefulWidget {
  const LevelsScreen({super.key, this.id});

  final String? id;

  @override
  State<LevelsScreen> createState() => _LevelsScreenState();
}

class _LevelsScreenState extends State<LevelsScreen> {
  @override
  void initState() {
    super.initState();

    if (widget.id != null) {
      context.read<AdventureCubit>().getDetails(widget.id!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<AdventureCubit, AdventureState>(
          builder: (context, state) {
            if (state is AdventureDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is AdventureDetailsSuccess) {
              return LevelBody();
            }

            if (state is AdventureDetailsError) {
              return Center(child: Text(state.message));
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
