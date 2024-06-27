import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:wemovies/src/repositories/view_models/location_view_model.dart';

class AddressWidget extends StatelessWidget {
  const AddressWidget({super.key, required this.location});

  final LocationViewModel location;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.location_on_outlined,
              size: 14,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              location.name ?? '--',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w500),
            )
          ],
        ),
        Text(
         location.details,
          style: Theme.of(context).textTheme.bodySmall,
        )
      ],
    );
  }
}
