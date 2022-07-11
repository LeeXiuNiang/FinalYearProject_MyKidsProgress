<?php
include_once("dbconnect.php");
$taskid = $_POST['taskid'];
$task= $_POST['task'];
$due= $_POST['due'];
$notes= $_POST['notes'];

$sqlupdate = "UPDATE  tbl_272033_TaskDetails SET TaskTitle = '$task', DueDate = '$due', Notes = '$notes' WHERE TaskID = '$taskid'";
    
    if ($conn->query($sqlupdate) === TRUE) {
        echo "success";
    } else {
        echo "failed";
    }


?>
