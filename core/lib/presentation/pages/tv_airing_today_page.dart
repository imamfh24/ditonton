import 'package:core/presentation/bloc/tv/airing_today/tv_airing_today_bloc.dart';
import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TvAiringTodayPage extends StatefulWidget {
  const TvAiringTodayPage({super.key});

  @override
  State<TvAiringTodayPage> createState() => _TvAiringTodayPageState();
}

class _TvAiringTodayPageState extends State<TvAiringTodayPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<TvAiringTodayBloc>().add(TvAiringTodayFetch());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airing Today TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TvAiringTodayBloc, TvAiringTodayState>(
          builder: (context, state) {
            if (state is TvAiringTodayLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TvAiringTodayHasData) {
              return ListView.builder(
                itemBuilder: (context, index) =>
                    TvCardList(state.results[index]),
                itemCount: state.results.length,
              );
            } else if (state is TvAiringTodayError) {
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
