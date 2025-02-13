import 'package:e_commerce/data/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class ReviewWidget extends StatelessWidget {
  const ReviewWidget({super.key, required this.review});
  final Review review;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Icon(
            MingCute.star_fill,
            color: Colors.yellow,
            size: 25,
          ),
          const SizedBox(width: 5),
          Text(
            review.rating.toString(),
            style: ShadTheme.of(context).textTheme.h4,
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    review.reviewerName,
                    style: ShadTheme.of(context).textTheme.small,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    "${review.date.month} ${review.date.year}",
                    style: ShadTheme.of(context).textTheme.muted,
                  ),
                ],
              ),
              Text(
                review.comment,
                style: ShadTheme.of(context).textTheme.muted,
              ),
            ],
          )
        ],
      ),
    );
  }
}
