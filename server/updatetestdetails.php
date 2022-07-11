<?php
include_once("dbconnect.php");
$subjectid = $_POST['subjectid'];

$sqlupdatedetails = "UPDATE tbl_272033_TestResults SET Grade ='N/A', SubjectID = $subjectid WHERE Grade = ''AND Marks = '0' AND SubjectID = '0'";
    
    if ($conn->query($sqlupdatedetails) === TRUE) {
        echo "success";
    } else {
        echo "failed";
    }


?>
