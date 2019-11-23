# 1.Query the existence of 1 course
SELECT * FROM course WHERE id=1;

# 2.Query the presence of both 1 AND 2 courses
SELECT * FROM course WHERE id=1 or id=2;

# 3.Query the student number AND student name AND average score of students whose average score is 60 or higher.

SELECT studentId, name, avg_score FROM 
(SELECT studentId, AVG(score) AS avg_score FROM student_course GROUP BY studentId) AS R
inner JOIN student ON student.id=R.studentid
WHERE R.avg_score >= 60;

# 4.Query the SQL statement of student information that does not have grades in the student_course table

SELECT id, name, age, sex 
FROM student 
LEFT JOIN student_course ON student.id=student_course.studentId
WHERE student_course.studentid IS NULL;

# 5.Query all SQL with grades

SELECT student.*, student_course.courseId, student_course.score, course.name as course_name, course.teacherId, teacher.name as teacher_name
FROM student 
JOIN student_course ON student.id=student_course.studentId
JOIN course ON student_course.courseId=course.id
JOIN teacher ON course.teacherId=teacher.id
WHERE student_course.studentid IS NOT NULL;

# 6.Inquire about the information of 
classmates who have numbered 1 
AND also studied the course numbered 2

SELECT id, name, age, sex FROM student
JOIN ( 
  SELECT studentId FROM student_course
  WHERE courseId=2 AND studentId=1 ) as R
ON student.id = R.studentId;

# 7.Retrieve 1 student score 
with less than 60 scores 
in descending order

SELECT score FROM student_course
WHERE student_course.score < 60
ORDER BY student_course.score DESC
LIMIT 1;

# 8.Query the average grade of each course. 
The results are ranked in 
descending order of average grade. 
When the average grades are the same, 
they are sorted in ascending ORDER BY course number.

SELECT courseId, AVG(score) as avg_score 
FROM student_course
GROUP BY student_course.courseId 
ORDER BY avg_score DESC, student_course.courseId asc;


# 9.Query the name AND score of a student 
whose course name is "Math" 
AND whose score is less than 60

SELECT student.name, student_course.score FROM student_course
LEFT JOIN student ON student_course.studentId=student.id
LEFT JOIN course ON student_course.courseId=course.id
WHERE course.name="Math" AND student_course.score < 60;