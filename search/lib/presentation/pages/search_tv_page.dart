import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/search.dart';

class SearchTvPage extends StatelessWidget {
  const SearchTvPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                context
                    .read<TvSearchBloc>()
                    .add(TvSearchOnQueryChangeEvent(query));
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<TvSearchBloc, TvSearchState>(
              builder: (context, state) {
                switch (state) {
                  case TvSearchEmpty():
                    return Expanded(
                      child: Center(
                        child: Text('Type to search'),
                      ),
                    );
                  case TvSearchError():
                    return Expanded(
                      child: Center(
                        child: Text(state.message),
                      ),
                    );
                  case TvSearchHasData():
                    final result = state.result;
                    if (result.isEmpty) {
                      return Expanded(
                        child: Center(
                          child: Text('No data found'),
                        ),
                      );
                    }
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          return TvCardList(result[index]);
                        },
                        itemCount: result.length,
                      ),
                    );
                  case TvSearchLoading():
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                    return Expanded(
                      child: Center(
                        child: Text('Something went wrong'),
                      ),
                    );   
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
