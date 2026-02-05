import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:riki_and_morti/domain/entities/character_entity.dart';

class CharacterCard extends StatelessWidget {
  final CharacterEntity character;
  final VoidCallback onFavoriteTap;

  const CharacterCard({
    super.key,
    required this.character,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: CachedNetworkImage(
                    imageUrl: character.image,
                    fit: BoxFit.cover,
                    placeholder: (_, _) => const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    errorWidget: (_, _, _) => const Center(
                      child: Icon(Icons.broken_image, size: 40),
                    ),
                  ),
                ),
                Positioned(
                  top: -1,
                  right: -1,
                  child: IconButton(
                    icon: Icon(
                      character.isFavourite
                      ? Icons.star :
                      Icons.star_border,
                      color: Colors.yellow,
                      size: 50,
                    ),
                    onPressed: onFavoriteTap,
                  ),
                ),
              ],
            ),
          ),

          // Info
          _Info(character: character),
        ],
      ),
    );
  }
}

class _Info extends StatelessWidget {
  const _Info({
    required this.character,
  });

  final CharacterEntity character;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(character.id.toString()),
          Text(
            character.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 4),
          Text(
            '${character.status} • ${character.species} • ${character.gender}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          Text(
            character.location.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
