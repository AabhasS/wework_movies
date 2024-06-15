import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class AddressWidget extends StatelessWidget {
  const AddressWidget({super.key, required this.placemark});

  final Placemark placemark;

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
              placemark.name ?? '--',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w500),
            )
          ],
        ),
        Text(
          '${placemark.street},'
          ' ${placemark.locality}',
          style: Theme.of(context).textTheme.bodySmall,
        )
      ],
    );
  }
}
