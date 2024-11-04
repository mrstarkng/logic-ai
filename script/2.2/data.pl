:- discontiguous female/1.
:- discontiguous male/1.

% Students
student(john).
student(emma).
student(liam).
student(olivia).
student(charlie).
student(sophia).
student(noah).
student(isabella).
student(logan).
student(ava).

% Teachers
teacher(mr_smith).
teacher(mrs_jones).
teacher(mr_davis).
teacher(miss_wilson).
teacher(mr_brown).

% Students and their genders
male(john).
female(emma).
male(liam).
female(olivia).
male(charlie).
female(sophia).
male(noah).
female(isabella).
male(logan).
female(ava).

% Teachers and their genders
male(mr_smith).
female(mrs_jones).
male(mr_davis).
female(miss_wilson).
male(mr_brown).


% Classes
class(ClassName, SubjectName).
class(math_class, math).
class(science_class, science).
class(english_class, english).


% Subjects
subject(math).
subject(science).
subject(english).

% Grades
grade(john, math, 85).
grade(john, science, 92).
grade(emma, math, 55).
grade(emma, science, 33).
grade(emma, english, 51).
grade(liam, math, 78).
grade(liam, science, 80).
grade(liam, english, 54).
grade(olivia, science, 92).
grade(olivia, english, 90).
grade(charlie, math, 82).
grade(charlie, science, 85).
grade(charlie, english, 78).
grade(sophia, math, 45).
grade(sophia, science, 57).
grade(sophia, english, 67).
grade(noah, math, 88).
grade(noah, english, 90).
grade(isabella, math, 62).
grade(isabella, english, 31).
grade(logan, math, 78).
grade(logan, science, 85).
grade(logan, english, 48).
grade(ava, math, 95).
grade(ava, science, 92).

enrolled(john, math_class).
enrolled(john, science_class).
enrolled(emma, math_class).
enrolled(emma, science_class).
enrolled(emma, english_class).
enrolled(liam, math_class).
enrolled(liam, science_class).
enrolled(liam, english_class).
enrolled(olivia, science_class).
enrolled(olivia, english_class).
enrolled(charlie, math_class).
enrolled(charlie, science_class).
enrolled(charlie, english_class).
enrolled(sophia, math_class).
enrolled(sophia, science_class).
enrolled(sophia, english_class).
enrolled(noah, math_class).
enrolled(noah, english_class).
enrolled(isabella, math_class).
enrolled(isabella, english_class).
enrolled(logan, math_class).
enrolled(logan, science_class).
enrolled(logan, english_class).
enrolled(ava, math_class).
enrolled(ava, science_class).

teaches(mr_smith, math).
teaches(mrs_jones, math).
teaches(mrs_jones, science).
teaches(mr_davis, english).
teaches(miss_wilson, math).
teaches(miss_wilson, english).
teaches(mr_brown, science).
teaches(mr_brown, english).

activity(football).
activity(basketball).
activity(chess_club).
activity(debate_team).
activity(drama_club).

participates_in(john, football).
participates_in(emma, chess_club).
participates_in(liam, basketball).
participates_in(olivia, debate_team).
participates_in(john, debate_team).
participates_in(charlie, drama_club).
participates_in(charlie, football).
participates_in(charlie, basketball).
participates_in(sophia, football).
participates_in(noah, chess_club).
participates_in(isabella, basketball).
participates_in(emma, basketball).
participates_in(logan, debate_team).
participates_in(ava, drama_club).

male_student(Student) :-
    student(Student),
    male(Student).

female_student(Student) :-
    student(Student),
    female(Student).

female_teacher(Teacher) :-
    female(Teacher),
    teacher(Teacher).

male_teacher(Teacher) :-
    male(Teacher),
    teacher(Teacher).

% Enrolled in a subject
enrolled_in_subject(Student, Subject) :-
    enrolled(Student, Class),
    class(Class, Subject).

% Passed a subject
passed(Student, Subject) :-
    grade(Student, Subject, Grade),
    Grade >= 50.

% High grade in a subject
high_grade(Student, Subject) :-
    grade(Student, Subject, Grade),
    Grade >= 90.

% Needs tutoring in a subject
needs_tutoring(Student, Subject) :-
    grade(Student, Subject, Grade),
    Grade < 65.

% Fails a subject
fails(Student, Subject) :-
    grade(Student, Subject, Grade),
    Grade < 50.

% Teaches multiple subjects
teaches_multiple_subjects(Teacher) :-
    teaches(Teacher, Subject1),
    teaches(Teacher, Subject2),
    Subject1 \= Subject2. % Check for distinct subjects

assessment(Student, Subject, AssessmentType, Score) :-
    grade(Student, Subject, Score),
    AssessmentType = 'test'.

class_roster(Class, Roster) :-
    class(Class, _),
    findall(Student, enrolled(Student, Class), Roster).

teaches_class(Teacher, Class) :-
    teaches(Teacher, Subject),
    class(Class, Subject),
    findall(Student, enrolled(Student, Class), _).

class_information(Class, Teacher) :-
    class(Class, Subject),
    teaches(Teacher, Subject).

student_in_class(Student, Class) :-
    enrolled(Student, Class).

class_size(Class, Size) :-
    findall(Student, enrolled(Student, Class), Students),
    length(Students, Size).

classes_taught_by_teacher(Teacher, Classes) :-
    findall(Class, teaches_class(Teacher, Class), Classes).

class_average_grade(Class, Subject, AverageGrade) :-
    findall(Grade, (enrolled(Student, Class), grade(Student, Subject, Grade)), Grades),
    length(Grades, NumGrades),
    sum_list(Grades, Total),
    AverageGrade is Total / NumGrades.

students_participating_in_activity(Activity, Students) :-
    findall(Student, participates_in(Student, Activity), Students).

students_in_class_with_grade_above(Class, Subject, Grade, Students) :-
    findall(Student, (enrolled(Student, Class), grade(Student, Subject, StudentGrade), StudentGrade > Grade), Students).

teachers_teaching_subject(Subject, Teachers) :-
    findall(Teacher, teaches(Teacher, Subject), Teachers).

student_activities(Student, Activities) :-
    findall(Activity, participates_in(Student, Activity), Activities).

student_grade_above_average(Student, Subject) :-
    grade(Student, Subject, Grade),
    class(Class, Subject),
    class_average_grade(Class, Subject, AverageGrade),
    Grade > AverageGrade.

students_taking_subject(Subject, Students) :-
    findall(Student, enrolled(Student, Class), AllStudents),
    findall(Student, (member(Student, AllStudents), enrolled_in_subject(Student, Subject)), Students).

passed_subjects(Student, PassedSubjects) :-
    findall(Subject, (enrolled_in_subject(Student, Subject), passed(Student, Subject)), AllPassedSubjects),
    list_to_set(AllPassedSubjects, PassedSubjects).

students_passing_class(Class, PassedStudents) :-
    findall(Student, (enrolled(Student, Class), \+ fails(Student, Class)), AllPassedStudents),
    list_to_set(AllPassedStudents, PassedStudents).

teacher_average_grade(Teacher, Subject, AverageGrade) :-
    findall(Grade, (teaches_class(Teacher, Class), class(Class, Subject), grade(Student, Subject, Grade)), Grades),
    length(Grades, NumGrades),
    sum_list(Grades, Total),
    AverageGrade is Total / NumGrades.

student_activities_count(Student, Count) :-
    findall(Activity, participates_in(Student, Activity), Activities),
    length(Activities, Count).

student_subjects_count(Student, Count) :-
    setof(Subject, enrolled_in_subject(Student, Subject), Subjects),
    length(Subjects, Count).

student_grades(Student, Grades) :-
    findall((Subject, Grade), grade(Student, Subject, Grade), Grades).

student_average_grade(Student, AverageGrade) :-
    findall(Grade, grade(Student, _, Grade), Grades),
    length(Grades, NumGrades),
    sum_list(Grades, Total),
    AverageGrade is Total / NumGrades.






