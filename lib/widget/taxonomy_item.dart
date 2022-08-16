import 'package:cima_app/models/texonomy_model.dart';
import 'package:flutter/material.dart';
class TaxonomyItem extends StatelessWidget {
  final TaxonomyModel taxonomyModel;
  const TaxonomyItem({Key? key,required this.taxonomyModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      margin: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(14, 19, 49, 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child:  GridTile(
        child: Container(
          color:const Color.fromRGBO(14, 19, 49, 1),
          child: taxonomyModel.thumbnailUrl!.isNotEmpty ?
          //عقبال مالصورة تيجى يعرض الlooding
          FadeInImage.assetNetwork(
            width: double.infinity,
            height: double.infinity,
            placeholder: 'assets/images/loading.gif',
            image:taxonomyModel.thumbnailUrl!,
            fit: BoxFit.cover,

          ):Image.asset('assets/images/svg.png'),
        ),
        footer: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          color: Colors.black45,
          alignment: Alignment.bottomCenter,
          child: Text(taxonomyModel.title!,style: const TextStyle(
            height: 1.3,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

