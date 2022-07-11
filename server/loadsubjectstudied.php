<?php
include_once("dbconnect.php");

$staffid = $_POST['staffid'];

$sqlloadsubjects = "SELECT * FROM tbl_272033_ClassesSubjects WHERE Teacher = '$staffid'  ";

$sqlloadsubjects = "SELECT tbl_272033_ClassesSubjects.id, tbl_272033_ClassesSubjects.SubjectName, tbl_272033_ClassesSubjects.ClassID, tbl_272033_ClassesSubjects.Teacher FROM tbl_272033_StudentDetails INNER JOIN tbl_272033_ClassesSubjects ON tbl_272033_StudentDetails.ClassID = tbl_272033_ClassesSubjects.ClassID WHERE tbl_272033_StudentDetails.StudentID = '$staffid'  ";

$result = $conn->query($sqlloadsubjects);

if ($result->num_rows > 0) {
    $response['subjects'] = array();
    while ($row = $result->fetch_assoc()) {
        $subjectlist['subjectid'] = $row['id'];
        $subjectlist['classid'] = $row['ClassID'];
        $subjectlist['subjectname'] = $row['SubjectName'];
        $subjectlist['teacher'] = $row['Teacher'];
        array_push($response['subjects'], $subjectlist);
    }
    echo json_encode($response);
} else {
    echo "nodata";
}

?>