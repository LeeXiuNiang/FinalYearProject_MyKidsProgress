<?php
include_once("dbconnect.php");
$subjectid = $_POST['subjectid'];
$taskid = $_POST['taskid'];

$sqlupdatedetails = "UPDATE tbl_272033_TaskStatus SET TaskID = '$taskid', Status ='Pending', SubjectID = $subjectid WHERE Status = 'New' AND SubjectID = '$subjectid'";
    
    if ($conn->query($sqlupdatedetails) === TRUE) {
        echo "success";
    } else {
        echo "failed";
    }


?>
