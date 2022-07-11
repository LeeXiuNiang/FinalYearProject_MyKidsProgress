<?php
include_once("dbconnect.php");

$subjectid = $_POST['subjectid'];
$classid = $_POST['classid'];
$studentid = $_POST['studentid'];

$sqlloadstudents = "SELECT tbl_272033_StudentDetails.StudentID, tbl_272033_StudentDetails.Name, tbl_272033_TestResults.Marks, tbl_272033_TestResults.Grade, tbl_272033_TestResults.id FROM tbl_272033_StudentDetails INNER JOIN tbl_272033_TestResults ON tbl_272033_StudentDetails.StudentID = tbl_272033_TestResults.StudentID WHERE tbl_272033_StudentDetails.ClassID = '$classid' AND tbl_272033_StudentDetails.StudentID = '$studentid'";

$result = $conn->query($sqlloadstudents);

if ($result->num_rows > 0) {
    $response['tasktudents'] = array();
    while ($row = $result->fetch_assoc()) {
        $taskstudentslist['studentid'] = $row['StudentID'];
        $taskstudentslist['studentname'] = $row['Name'];
        $taskstudentslist['marks'] = $row['Marks'];
        $taskstudentslist['grade'] = $row['Grade'];
        $taskstudentslist['id'] = $row['id'];
        array_push($response['tasktudents'], $taskstudentslist);
    }
    echo json_encode($response);
} else {
    echo "nodata";
}

?>