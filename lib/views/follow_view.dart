import 'package:flutter/material.dart';
import 'package:tt9_betweener_challenge/views/widgets/search_container_result_widget.dart';

import '../models/user.dart';

class FollowView extends StatelessWidget {
  const FollowView({super.key, required this.title , required this.follow});
final String title ;
final List<UserClass> follow ;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text(title),),
      body: Column(
        children: [
          const SizedBox(height: 32),

          Expanded(
            child: ListView.builder(

              itemCount: follow.length,
              itemBuilder: (context, index) {
                return SearchContainerResultWidget(name: follow[index].name!,isSearch: false,isFollowed: false, );
              },

            ),
          ),
        ],
      ),
    );
  }
}
