import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import '../../business_logic/cubit/characters_cubit.dart';
import '../../constants/my_colors.dart';
import '../../data/models/characters_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterDetailsScreen extends StatelessWidget {
  final CharacterModel characterModel;
  const CharacterDetailsScreen({Key? key, required this.characterModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
       BlocProvider.of<CharactersCubit>(context).getQuotes(characterModel.name);

    return Scaffold(
      backgroundColor: MyColors.myGrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo('Job : ' , characterModel.jobs.join(' / ')),
                      buildDivider(330),
                       characterInfo('Appeared in : ' , characterModel.categoryForTwoSeries),
                      buildDivider(270),
                      characterInfo('Seasons : ' , characterModel.appearanceOfseasons.join(' / ')),
                      buildDivider(300),
                      characterInfo('Status : ' , characterModel.statusIfDeadOrAlive),
                      buildDivider(300),
                       characterModel.betterCallSaulAppearnce.isEmpty ? Container():
                      characterInfo('Better Call Saul Seasons : ' , characterModel.betterCallSaulAppearnce.join(' / ')),
                      characterModel.betterCallSaulAppearnce.isEmpty ? Container():
                      buildDivider(150),
                      characterInfo('Actor : ' , characterModel.actorName),
                      buildDivider(330),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<CharactersCubit,CharactersState>(
                        builder: (context, state) {
                          return checkIfQuotesAreLoaded(state) ;
                        },
                      )
                    ],
                  ),
                ),
               const SizedBox(height: 500,),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGrey,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          characterModel.nickName,
          style: const TextStyle(
            color: MyColors.myWhite,
          ),
        ),
        background: Hero(
          tag: characterModel.charId,
          child: Image.network(
            characterModel.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: const TextStyle(
                color: MyColors.myWhite,
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(
              color: MyColors.myWhite,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      color: MyColors.myYellow,
      height: 30,
      endIndent: endIndent,
      thickness: 2,
    );
  }
}

Widget checkIfQuotesAreLoaded(CharactersState state) {
  if (state is QuotesLoaded) {
    return displayRandomQuoteOrEmptySpace(state);
    
  } else {
    return showProgressIndicator();
  }
} 

Widget displayRandomQuoteOrEmptySpace(state) {
  var quotes = (state).quotes;
  if(quotes.length != 0){
    int randomQuoteIndex =Random().nextInt(quotes.length - 1);
    return Center(
      child: DefaultTextStyle(
        textAlign: TextAlign.center,
        style:const TextStyle(fontSize: 20,color: MyColors.myWhite,shadows: [
          Shadow(
            blurRadius: 7,
            color: MyColors.myYellow,
            offset: Offset(0,0)
          )
        ],),
        child: AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            FlickerAnimatedText(quotes[randomQuoteIndex].quote)
          ],
        ),
      ),
    );
  }else{
    return Container();
  }
}

Widget showProgressIndicator() {
  return const Center(
    child: CircularProgressIndicator(color: MyColors.myYellow ,),
  );

}


