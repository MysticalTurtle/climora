import 'package:climora/presentation/modules/search/cubit/search_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppSearchBar extends StatefulWidget {
  const AppSearchBar({this.requestFocus = false, super.key});

  final bool requestFocus;

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    if (widget.requestFocus) _focusNode.requestFocus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        focusNode: _focusNode,
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Search location',
          prefixIcon: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  _controller.clear();
                  context.read<SearchCubit>().clear();
                },
                icon: const Icon(Icons.clear),
                tooltip: 'Clear search',
              ),
            ],
          ),
        ),
        onSubmitted: (query) {
          context.read<SearchCubit>().searchLocations(query);
          FocusScope.of(context).unfocus();
        },
        onChanged: (query) {
          // Optional: Search as user types (debounced)
          if (query.trim().isEmpty) {
            context.read<SearchCubit>().clear();
          }
        },
      ),
    );
  }
}
