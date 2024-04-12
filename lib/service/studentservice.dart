import 'package:project2/dbase/repository.dart';
import 'package:project2/screen3.dart';

class StudentService {
  late Repository repository;
  StudentService() {
    repository = Repository();
  }

  // Save Student... !
  SaveStudent(Student student) async {
    return await repository.insertData('students', student.StudentMap());
  }

// Read All Students...!
  readAllStudents() async {
    return await repository.readData('Students');
  }

  deleteUser(studentId) async {
    return await repository.deleteDataById('students', studentId);
  }

  // To updateDetail...!
  UpdateStudent(Student student) async {
    return await repository.updataData('Students', student.StudentMap());
  }
}
