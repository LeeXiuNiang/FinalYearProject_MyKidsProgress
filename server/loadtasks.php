<?php
include_once("dbconnect.php");

$classid = $_POST['classid'];
$subjectid = $_POST['subjectid'];

$sqlloadtasks = "SELECT * FROM tbl_272033_TaskDetails WHERE ClassID = '$classid' AND SubjectID = '$subjectid' ORDER BY TaskID DESC";

$result = $conn->query($sqlloadtasks);

if ($result->num_rows > 0) {
    $response['tasks'] = array();
    while ($row = $result->fetch_assoc()) {
        $tasklist['taskid'] = $row['TaskID'];
        $tasklist['task'] = $row['TaskTitle'];
        $tasklist['due'] = $row['DueDate'];
        $tasklist['notes'] = $row['Notes'];
        array_push($response['tasks'], $tasklist);
    }
    echo json_encode($response);
} else {
    echo "nodata";
}

?>