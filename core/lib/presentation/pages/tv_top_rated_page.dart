import 'package:core/presentation/bloc/tv/top_rated/tv_top_rated_bloc.dart';
import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvTopRatedPage extends StatefulWidget {
  const TvTopRatedPage({super.key});

  @override
  State<TvTopRatedPage> createState() => _TvTopRatedPageState();
}

class _TvTopRatedPageState extends State<TvTopRatedPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<TvTopRatedBloc>().add(TvTopRatedFetch());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TV Top Rated'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvTopRatedBloc, TvTopRatedState>(
          builder: (context, state) {
            if (state is TvTopRatedLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvTopRatedHasData) {
              return ListView.builder(
                itemBuilder: (context, index) =>
                    TvCardList(state.results[index]),
                itemCount: state.results.length,
              );
            } else if (state is TvTopRatedError) {
              return Expanded(
                child: Center(
                  child: Text(state.message),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}
