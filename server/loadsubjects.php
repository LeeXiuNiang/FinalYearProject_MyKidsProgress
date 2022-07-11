<?php
include_once("dbconnect.php");

$staffid = $_POST['staffid'];

// $sqlloadsubjects = "SELECT * FROM tbl_272033_ClassesSubjects WHERE TeacherInCharged = '$staffid'  ";

$sqlloadsubjects = "SELECT tbl_272033_ClassesSubjects.id, tbl_272033_ClassesSubjects.Teacher, tbl_272033_ClassesSubjects.SubjectName, tbl_272033_ClassesSubjects.ClassID, tbl_272033_StaffDetails.Name FROM tbl_272033_ClassesSubjects LEFT JOIN tbl_272033_StaffDetails ON tbl_272033_ClassesSubjects.Teacher = tbl_272033_StaffDetails.StaffID WHERE tbl_272033_ClassesSubjects.TeacherInCharged = '$staffid' ORDER BY SubjectName ASC";

$result = $conn->query($sqlloadsubjects);

if ($result->num_rows > 0) {
    $response['subjects'] = array();
    while ($row = $result->fetch_assoc()) {
        $subjectlist['classid'] = $row['ClassID'];
        $subjectlist['subjectname'] = $row['SubjectName'];
        $subjectlist['teacherid'] = $row['Teacher'];
        $subjectlist['teacher'] = $row['Name'];
        $subjectlist['id'] = $row['id'];
        array_push($response['subjects'], $subjectlist);
    }
    echo json_encode($response);
} else {
    echo "nodata";
}

?>