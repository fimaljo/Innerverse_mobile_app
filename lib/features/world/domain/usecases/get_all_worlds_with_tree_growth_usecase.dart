import 'package:dartz/dartz.dart';
import 'package:innerverse/features/world/domain/repositories/world_repository.dart';
import 'package:innerverse/features/world/domain/usecases/base_usecase.dart';
import 'package:innerverse/features/world/domain/usecases/calculate_world_tree_growth_usecase.dart';
import 'package:innerverse/features/world/domain/failures/world_failure.dart';
import 'package:innerverse/features/world/domain/entities/world.dart';

class WorldWithTreeGrowth {
  const WorldWithTreeGrowth({
    required this.world,
    required this.treeGrowthData,
  });

  final World world;
  final WorldTreeGrowthData treeGrowthData;
}

class GetAllWorldsWithTreeGrowthUseCase
    implements BaseUseCase<List<WorldWithTreeGrowth>, NoParams, WorldFailure> {
  GetAllWorldsWithTreeGrowthUseCase({
    required WorldRepository worldRepository,
    required CalculateWorldTreeGrowthUseCase calculateWorldTreeGrowthUseCase,
  })  : _worldRepository = worldRepository,
        _calculateWorldTreeGrowthUseCase = calculateWorldTreeGrowthUseCase;

  final WorldRepository _worldRepository;
  final CalculateWorldTreeGrowthUseCase _calculateWorldTreeGrowthUseCase;

  @override
  Future<Either<WorldFailure, List<WorldWithTreeGrowth>>> call(
      NoParams params) async {
    try {
      final worldsResult = await _worldRepository.getAllWorlds();

      return worldsResult.fold(
        (failure) => left(failure),
        (worlds) async {
          final worldsWithTreeGrowth = <WorldWithTreeGrowth>[];

          for (final world in worlds) {
            final treeGrowthResult =
                await _calculateWorldTreeGrowthUseCase(world.id);

            treeGrowthResult.fold(
              (failure) => left(failure),
              (treeGrowthData) {
                worldsWithTreeGrowth.add(WorldWithTreeGrowth(
                  world: world,
                  treeGrowthData: treeGrowthData,
                ));
              },
            );
          }

          return right(worldsWithTreeGrowth);
        },
      );
    } catch (e) {
      return left(WorldFailure.storageError());
    }
  }
}
