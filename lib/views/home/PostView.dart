import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/cubit/search_cubit.dart';
import 'package:htb_mobile/data/models/global_items.dart';

class PostView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Testing"),
        ),
        body: BlocBuilder<SearchCubit, GlobalItems>(
          builder: (ctx, posts) {
            if (posts.result.items == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text("posts[index].title"),
                  ),
                );
              },
              itemCount: 3,
            );
          },
        ));
  }
}
