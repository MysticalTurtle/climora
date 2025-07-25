import 'package:climora/domain/entities/geocoding.dart';
import 'package:climora/presentation/modules/weather/page/weather_page.dart';
import 'package:flutter/material.dart';

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({required this.location, super.key});

  final GeocodingLocation location;

  @override
  Widget build(BuildContext context) {
    const borderRadius = 20.0;
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push<void>(
          MaterialPageRoute(
            builder: (_) => WeatherPage(initialLocation: location),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              theme.colorScheme.primary.withAlpha(204),
              theme.colorScheme.primary.withAlpha(153),
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withAlpha(77),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(borderRadius),
            onTap: () {
              Navigator.of(context).push<void>(
                MaterialPageRoute(
                  builder: (_) => WeatherPage(initialLocation: location),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Location icon
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(50),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Location name
                  Text(
                    location.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // Country/State info
                  if (location.country.isNotEmpty) ...[
                    Text(
                      (location.state?.isNotEmpty ?? false)
                          ? '${location.state}, ${location.country}'
                          : location.country,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withAlpha(230),
                        fontWeight: FontWeight.w500,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 8),
                  // Tap hint
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.touch_app,
                        size: 16,
                        color: Colors.white.withAlpha(179),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'View weather',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withAlpha(179),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
