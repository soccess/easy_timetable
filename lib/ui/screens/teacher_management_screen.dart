import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../providers/database_providers.dart';
import '../../database/app_database.dart';
import '../../theme/app_colors.dart';
import '../components/cute_card.dart';

class TeacherManagementScreen extends ConsumerStatefulWidget {
  const TeacherManagementScreen({super.key});

  @override
  ConsumerState<TeacherManagementScreen> createState() => _TeacherManagementScreenState();
}

class _TeacherManagementScreenState extends ConsumerState<TeacherManagementScreen> {
  final TextEditingController _nameController = TextEditingController();
  int _weeklyHours = 20;
  bool _isHomeroom = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final teachersAsync = ref.watch(teachersProvider);

    return SafeArea(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Form
          SizedBox(
            width: 350,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: CuteCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Semantics(
                      label: '새 교사 등록 양식',
                      child: Text(
                        '새 교사 등록',
                        style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Semantics(
                      label: '교사 이름 입력 필드',
                      child: CupertinoTextField(
                        controller: _nameController,
                        placeholder: '교사 이름 입력',
                        padding: const EdgeInsets.all(12),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text('주당 시수: '),
                        Semantics(
                          label: '주당 시수 선택, 현재 $_weeklyHours시간',
                          value: '$_weeklyHours',
                          child: Row(
                            children: [
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: _weeklyHours > 1 ? () => setState(() => _weeklyHours--) : null,
                                child: const ExcludeSemantics(child: Icon(CupertinoIcons.minus_circle)),
                              ),
                              SizedBox(width: 40, child: Center(child: Text('$_weeklyHours'))),
                              CupertinoButton(
                                padding: EdgeInsets.zero,
                                onPressed: _weeklyHours < 40 ? () => setState(() => _weeklyHours++) : null,
                                child: const ExcludeSemantics(child: Icon(CupertinoIcons.add_circled)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text('담임 여부: '),
                        Semantics(
                          label: '담임 여부 선택',
                          checked: _isHomeroom,
                          child: CupertinoSwitch(
                            value: _isHomeroom,
                            onChanged: (val) => setState(() => _isHomeroom = val),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: CupertinoButton(
                        color: AppColors.pastelMint,
                        borderRadius: BorderRadius.circular(20),
                        onPressed: () async {
                          if (_nameController.text.isEmpty) return;
                          final db = ref.read(databaseProvider);
                          await db.into(db.teachers).insert(
                            TeachersCompanion.insert(
                              name: _nameController.text,
                              weeklyTargetHours: _weeklyHours,
                              isHomeroom: _isHomeroom,
                            ),
                          );
                          _nameController.clear();
                        },
                        child: Semantics(
                          label: '교사 등록 버튼',
                          button: true,
                          child: Text(
                            '교사 등록',
                            style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Right DataGrid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: teachersAsync.when(
                data: (teachers) {
                  return SfDataGrid(
                    source: TeacherDataSource(teachers: teachers, ref: ref),
                    allowEditing: true,
                    selectionMode: SelectionMode.single,
                    navigationMode: GridNavigationMode.cell,
                    columnWidthMode: ColumnWidthMode.fill,
                    columns: [
                      GridColumn(
                        columnName: 'name',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.centerLeft,
                          child: const Text('교사명', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                      GridColumn(
                        columnName: 'weeklyHours',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('주당 시수', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                      GridColumn(
                        columnName: 'isHomeroom',
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('담임 여부', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                      GridColumn(
                        columnName: 'delete',
                        allowEditing: false,
                        width: 80,
                        label: Container(
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          child: const Text('삭제', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  );
                },
                loading: () => const Center(child: CupertinoActivityIndicator()),
                error: (e, st) => Center(child: Text('Error: $e')),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TeacherDataSource extends DataGridSource {
  TeacherDataSource({required List<Teacher> teachers, required this.ref}) {
    _teacherData = teachers
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<int>(columnName: 'weeklyHours', value: e.weeklyTargetHours),
              DataGridCell<bool>(columnName: 'isHomeroom', value: e.isHomeroom),
              DataGridCell<Teacher>(columnName: 'delete', value: e),
            ]))
        .toList();
  }

  List<DataGridRow> _teacherData = [];
  final WidgetRef ref;
  dynamic newCellValue;
  TextEditingController editingController = TextEditingController();

  @override
  List<DataGridRow> get rows => _teacherData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((e) {
      if (e.columnName == 'delete') {
        final teacher = e.value as Teacher;
        return Container(
          alignment: Alignment.center,
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              final db = ref.read(databaseProvider);
              db.delete(db.teachers).delete(teacher);
            },
            child: const Icon(CupertinoIcons.trash, color: CupertinoColors.destructiveRed, size: 20),
          ),
        );
      }

      if (e.columnName == 'isHomeroom') {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Text(e.value == true ? 'O' : 'X'),
        );
      }

      return Container(
        alignment: e.columnName == 'weeklyHours' ? Alignment.center : Alignment.centerLeft,
        padding: const EdgeInsets.all(8.0),
        child: Text(e.value.toString()),
      );
    }).toList());
  }

  @override
  Widget? buildEditWidget(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
    final String displayText = dataGridRow.getCells()[rowColumnIndex.columnIndex].value.toString();
    newCellValue = null;

    if (column.columnName == 'isHomeroom') {
      final bool currentValue = dataGridRow.getCells()[rowColumnIndex.columnIndex].value as bool;
      newCellValue = !currentValue; // Toggle value immediately on edit request
      submitCell();
      return null;
    }

    return Container(
      padding: const EdgeInsets.all(8.0),
      alignment: column.columnName == 'weeklyHours' ? Alignment.center : Alignment.centerLeft,
      child: CupertinoTextField(
        autofocus: true,
        controller: editingController..text = displayText,
        keyboardType: column.columnName == 'weeklyHours' ? TextInputType.number : TextInputType.text,
        onChanged: (String value) {
          if (value.isNotEmpty) {
            if (column.columnName == 'weeklyHours') {
              newCellValue = int.tryParse(value);
            } else {
              newCellValue = value;
            }
          } else {
            newCellValue = null;
          }
        },
        onSubmitted: (String value) {
          submitCell();
        },
      ),
    );
  }

  @override
  Future<void> onCellSubmit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex, GridColumn column) async {
    final dynamic oldValue = dataGridRow.getCells()[rowColumnIndex.columnIndex].value;
    if (oldValue == newCellValue || newCellValue == null) {
      return;
    }

    final int dataRowIndex = _teacherData.indexOf(dataGridRow);
    final teacher = dataGridRow.getCells()[3].value as Teacher;
    final db = ref.read(databaseProvider);

    if (column.columnName == 'name') {
      await db.update(db.teachers).replace(teacher.copyWith(name: newCellValue.toString()));
    } else if (column.columnName == 'weeklyHours') {
      await db.update(db.teachers).replace(teacher.copyWith(weeklyTargetHours: newCellValue as int));
    } else if (column.columnName == 'isHomeroom') {
      await db.update(db.teachers).replace(teacher.copyWith(isHomeroom: newCellValue as bool));
    }

    _teacherData[dataRowIndex].getCells()[rowColumnIndex.columnIndex] = DataGridCell(columnName: column.columnName, value: newCellValue);
  }
}
