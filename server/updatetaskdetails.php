<?php
include_once("dbconnect.php");
$subjectid = $_POST['subjectid'];

$sqlupdatedetails = "UPDATE tbl_272033_TaskStatus SET Status ='New', SubjectID = $subjectid WHERE Status = '' AND SubjectID = '0'";
    
    if ($conn->query($sqlupdatedetails) === TRUE) {
        echo "success";
    } else {
        echo "failed";
    }


?>
