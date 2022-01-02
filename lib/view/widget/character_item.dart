import 'package:breaking/constants/my_colors.dart';
import 'package:breaking/data/models/characters_model.dart';
import 'package:flutter/material.dart';

class CharacterItem extends StatelessWidget {
  final CharacterModel characterModel;
  
  const CharacterItem({ Key? key , required this.characterModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsetsDirectional.all(4),
      decoration:  BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: GridTile(
        child: Container(
          color: MyColors.myGrey,
          child: characterModel.image.isNotEmpty ?
          FadeInImage.assetNetwork(
            width: double.infinity,
            height: double.infinity,
            placeholder: 'assets/images/loading.gif', image: characterModel.image, fit: BoxFit.cover, )
            : Image.asset('assets/images/placeholder.gif'),
        ),
        footer: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          color: Colors.black54,
          alignment: Alignment.bottomCenter,
          child: Text(
            '${characterModel.name}',
          style: const TextStyle(
            height: 1.3,
            fontSize: 16,
            color: MyColors.myWhite,
            fontWeight: FontWeight.bold,

          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          textAlign: TextAlign.center,
  ),
        ),
      ),
    );
  }
}