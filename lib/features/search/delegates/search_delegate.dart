import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:twitter_clone/core/common/error_text.dart';
import 'package:twitter_clone/core/common/loader.dart';
import 'package:twitter_clone/features/profiles/controller/profile_controller.dart';
import 'package:twitter_clone/theme/palette.dart';

class SearchProfilesDelegate extends SearchDelegate {
  final WidgetRef ref;
  SearchProfilesDelegate({required this.ref});


  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = ref.read(themeProvider);
    return ThemeData(
      appBarTheme: AppBarTheme(
        backgroundColor: theme.colorScheme.background
      ),
      primaryColor: theme.colorScheme.background,
      scaffoldBackgroundColor: theme.colorScheme.background,
    );
  }

  @override
  TextStyle get searchFieldStyle => const TextStyle(
    color: Palette.darkGreyColor,
    fontWeight: FontWeight.w600,
  );


  @override
  List<Widget>? buildActions(BuildContext context) {
    final theme = ref.read(themeProvider);
    return [
      IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(
          Icons.close,
          color: theme.colorScheme.onSurface,
        ),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return null;
  }

  @override
  Widget buildResults(BuildContext context) {
    return const SizedBox();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final theme = ref.read(themeProvider);
    return ref.watch(searchProfileByUsernameProvider(query)).when(
        data: (profiles) {
          return ListView.builder(
            itemCount: profiles.length,
            itemBuilder: (context, index) {
              final profile = profiles[index];
              return ListTile(
                onTap: (){
                  Routemaster.of(context).push('/profile-screen/${profile.uid}');
                },
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(profile.displayPic),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(profile.name, style: TextStyle(
                      color: theme.colorScheme.onPrimary,
                    ),),
                    Text('@${profile.username}', style: const TextStyle(
                      color: Palette.darkGreyColor,
                    ),),
                  ],
                ),
              );
            },
          );
        },
        error: (error, stackTrace) => Center(
              child: ErrorText(error: error.toString()),
            ),
        loading: () => const Center(
              child: Loader(),
            ));
  }
}
