<?php
include_once("dbconnect.php");

$subjectid = $_POST['subjectid'];
$classid = $_POST['classid'];
$studentid = $_POST['studentid'];

$sqlloadstudents = "SELECT tbl_272033_StudentDetails.StudentID, tbl_272033_StudentDetails.Name, tbl_272033_TaskStatus.Status, tbl_272033_TaskStatus.id FROM tbl_272033_StudentDetails INNER JOIN tbl_272033_TaskStatus ON tbl_272033_StudentDetails.StudentID = tbl_272033_TaskStatus.StudentID WHERE tbl_272033_StudentDetails.ClassID = '$classid'AND tbl_272033_StudentDetails.StudentID = '$studentid'";

$result = $conn->query($sqlloadstudents);

if ($result->num_rows > 0) {
    $response['tasktudents'] = array();
    while ($row = $result->fetch_assoc()) {
        $taskstudentslist['studentid'] = $row['StudentID'];
        $taskstudentslist['studentname'] = $row['Name'];
        $taskstudentslist['status'] = $row['Status'];
        $taskstudentslist['id'] = $row['id'];
        array_push($response['tasktudents'], $taskstudentslist);
    }
    echo json_encode($response);
} else {
    echo "nodata";
}

?>
