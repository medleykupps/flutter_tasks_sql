
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tasks_sql/tasks/task-list-model.dart';
import 'package:tasks_sql/tasks/tasks-repository.dart';

// Define a mock to utilise the Tasks repository
class MockTasksRepository extends Mock implements TasksRepository {}

void main() {

  group('TaskListModel', () {

    test('should add task', () async {

      TestWidgetsFlutterBinding.ensureInitialized();
      
      // Set up mock results
      final repository = new MockTasksRepository();
      when(repository.getNextId()).thenAnswer((_) async => 1);
      when(repository.insert(any)).thenAnswer((_) async => true);

      final taskList = TaskList.withDependencies(repository);
      
      final result = await taskList.add('Test 01', 'This is test item number 1');

      expect(result, isNotNull);
      expect(result.id, 1);

      print('${result.id} ${result.name}');

    });

  });

}
