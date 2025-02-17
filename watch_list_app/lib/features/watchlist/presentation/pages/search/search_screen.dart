import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_list_app/core/utils/extensions/object_extension.dart';
import 'package:watch_list_app/features/watchlist/data/models/watchlist_model/watchlist_response.dart';
import 'package:watch_list_app/features/watchlist/presentation/bloc/watchlist_event.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/widget_sizes.dart';
import '../../bloc/watchlist_bloc.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({
    super.key,
    required this.symbolList,
    required this.watchListIndex,
  });

  final List<SymbolDetails> symbolList;
  final int watchListIndex;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<SymbolDetails>? searchList;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    searchList = widget.symbolList.sublist(0, 5);
    searchController.addListener(() {
      filterItems();
    });
    super.initState();
  }

  void filterItems() {
    setState(() {
      searchList = widget.symbolList
          .where((item) => item.dispSym!
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        leadingWidth: WidgetSizes.s35,
        centerTitle: false,
        title: Text(
          AppConstants.Search,
          style: theme.textTheme.titleMedium!
              .copyWith(color: colorScheme.onSurface),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: AppConstants.searchForSym,
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: searchList?.length ?? 0,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                      contentPadding: const EdgeInsets.only(
                        left: WidgetSizes.paddingMedium,
                      ),
                      title: Text(
                        searchList?[index].dispSym ?? '',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.inverseSurface,
                        ),
                      ),
                      subtitle: Text(
                        searchList?[index].exc ?? '',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: colorScheme.inverseSurface,
                        ),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          if (searchList.isNotNull) {
                            BlocProvider.of<WatchlistBloc>(context).add(
                                addSymbol(
                                    widget.watchListIndex, searchList![index]));
                                    Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                    if (index < (searchList?.length ?? 0) - 1)
                      Divider(
                        endIndent: WidgetSizes.paddingMedium,
                        indent: WidgetSizes.paddingMedium,
                        height: WidgetSizes.s1,
                        thickness: 0.5,
                        color: colorScheme.outlineVariant,
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
