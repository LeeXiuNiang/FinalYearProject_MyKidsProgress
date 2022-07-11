<?php
include_once("dbconnect.php");

$staffid = $_POST['staffid'];

$sqlloadclassstudents = "SELECT tbl_272033_StudentDetails.StudentID, tbl_272033_StudentDetails.Name FROM tbl_272033_StudentDetails INNER JOIN tbl_272033_ClassDetails ON tbl_272033_StudentDetails.ClassID = tbl_272033_ClassDetails.ClassID WHERE tbl_272033_ClassDetails.TeacherInCharged = '$staffid'  ";

$result = $conn->query($sqlloadclassstudents);

if ($result->num_rows > 0) {
    $response['classstudents'] = array();
    while ($row = $result->fetch_assoc()) {
        $classstudentslist['studentid'] = $row['StudentID'];
        $classstudentslist['studentname'] = $row['Name'];
        array_push($response['classstudents'], $classstudentslist);
    }
    echo json_encode($response);
} else {
    echo "nodata";
}

?>
