import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../features/home/presentations/views_models/get_direction_cubit/get_direction_cubit.dart';

class CustomRatingBar extends StatefulWidget {
 final double rate ;
   CustomRatingBar({
    Key? key, required this.rate,
  }) : super(key: key);

  @override
  State<CustomRatingBar> createState() => _CustomRatingBarState();
}

class _CustomRatingBarState extends State<CustomRatingBar> {
  @override
  Widget build(BuildContext context) {
   
    return RatingBar.builder(
        itemSize: 22.r,
        initialRating:widget.rate.toDouble(),
        minRating: 0,
        direction: Axis.horizontal,
        glowColor: Colors.white,
        allowHalfRating: true,
        itemCount: 5,
        itemPadding: const EdgeInsets.symmetric(horizontal: .5),
        itemBuilder: (context, _) =>
        const Icon(Icons.star, color: Colors.amber,),
        onRatingUpdate: (rating) {
     
        },
      );
  
  }
}