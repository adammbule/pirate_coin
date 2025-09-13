import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Piratecoin/features/Shows/presentation/bloc/trending_shows_bloc.dart';
import 'package:Piratecoin/widgets/show_list_widget.dart';

class TrendingShowScreen extends StatelessWidget {
  const TrendingShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TrendingShowsBloc()..add(FetchTrendingShows()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Trending Shows'),
        ),
        body: BlocBuilder<TrendingShowsBloc, TrendingShowsState>(
          builder: (context, state) {
            if (state is TrendingShowsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TrendingShowsLoaded) {
              return const ShowListWidget(
                Shows: [],
              );
            } else if (state is TrendingShowsError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
