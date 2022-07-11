<?php
include_once("dbconnect.php");

$staffid = $_POST['staffid'];

$sqlloadsubjects = "SELECT * FROM tbl_272033_ClassesSubjects WHERE Teacher = '$staffid'  ";

$result = $conn->query($sqlloadsubjects);

if ($result->num_rows > 0) {
    $response['subjects'] = array();
    while ($row = $result->fetch_assoc()) {
        $subjectlist['subjectid'] = $row['id'];
        $subjectlist['classid'] = $row['ClassID'];
        $subjectlist['subjectname'] = $row['SubjectName'];
        array_push($response['subjects'], $subjectlist);
    }
    echo json_encode($response);
} else {
    echo "nodata";
}

?>