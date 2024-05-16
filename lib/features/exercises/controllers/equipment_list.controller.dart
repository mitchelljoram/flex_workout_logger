
import 'package:flex_workout_logger/features/exercises/domain/entities/equipment.entity.dart';
import 'package:flex_workout_logger/features/exercises/infrastructure/providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'equipment_list.controller.g.dart';

/// Controller for the movement pattern list
@riverpod
class EquipmentListController extends _$EquipmentListController {
  @override
  FutureOr<List<EquipmentEntity>> build() async {
    final res = await ref
        .watch(equipmentRepositoryProvider)
        .getEquipment();
    return res.fold((l) => throw l, (r) => r);
  }

  /// Add an entity to list
  void addEquipment(EquipmentEntity entity) {
    final items = state.valueOrNull ?? [];

    state = const AsyncValue.loading();

    items.add(entity);
    state = AsyncValue.data(items);
  }

  /// Update an entity in the list
  void editEquipment(EquipmentEntity entity) {
    final items = state.valueOrNull ?? [];

    state = const AsyncValue.loading();

    final i = items.indexWhere((element) => element.id == entity.id);
    if (i != -1) {
      items
        ..removeAt(i)
        ..insert(i, entity);
    }

    state = AsyncValue.data(items);
  }

  /// Delete an entity in the list
  void deleteEquipment(EquipmentEntity entity) {
    final items = state.valueOrNull ?? [];

    state = const AsyncValue.loading();

    items.remove(entity);
    state = AsyncValue.data(items);
  }
}
