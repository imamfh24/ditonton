import 'package:core/presentation/provider/tv_airing_today_notifier.dart';
import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvAiringTodayPage extends StatefulWidget {
  const TvAiringTodayPage({super.key});


  @override
  State<TvAiringTodayPage> createState() => _TvAiringTodayPageState();
}

class _TvAiringTodayPageState extends State<TvAiringTodayPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<TvAiringTodayNotifier>().fetchTvAiringToday());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airing Today TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TvAiringTodayNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return TvCardList(data.tvAiringToday[index]);
                },
                itemCount: data.tvAiringToday.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
