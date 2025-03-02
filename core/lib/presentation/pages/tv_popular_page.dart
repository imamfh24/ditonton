import 'package:core/presentation/bloc/tv/popular/tv_popular_bloc.dart';
import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvPopularPage extends StatefulWidget {
  const TvPopularPage({super.key});

  @override
  State<TvPopularPage> createState() => _TvPopularPageState();
}

class _TvPopularPageState extends State<TvPopularPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<TvPopularBloc>().add(TvPopularFetch());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvPopularBloc, TvPopularState>(
          builder: (context, state) {
            if (state is TvPopularLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvPopularHasData) {
              return ListView.builder(
                itemBuilder: (context, index) =>
                    TvCardList(state.results[index]),
                itemCount: state.results.length,
              );
            } else if (state is TvPopularError) {
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
