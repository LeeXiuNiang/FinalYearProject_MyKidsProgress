<?php
include_once("dbconnect.php");

$classid = $_POST['classid'];
$subjectid = $_POST['subjectid'];

$sqlloadtests = "SELECT * FROM tbl_272033_TestDetails WHERE ClassID = '$classid' AND SubjectID = '$subjectid'";

$result = $conn->query($sqlloadtests);

if ($result->num_rows > 0) {
    $response['tests'] = array();
    while ($row = $result->fetch_assoc()) {
        $testlist['testid'] = $row['TestID'];
        $testlist['test'] = $row['TestName'];
        $testlist['fmarks'] = $row['FullMarks'];
        array_push($response['tests'], $testlist);
    }
    echo json_encode($response);
} else {
    echo "nodata";
}

?>