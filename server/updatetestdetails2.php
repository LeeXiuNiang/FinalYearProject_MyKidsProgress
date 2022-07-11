<?php
include_once("dbconnect.php");
$subjectid = $_POST['subjectid'];
$testid = $_POST['testid'];

$sqlupdatedetails = "UPDATE tbl_272033_TestResults SET TestID = '$testid', Grade ='-' WHERE Grade = 'N/A' AND SubjectID = '$subjectid'";
    
    if ($conn->query($sqlupdatedetails) === TRUE) {
        echo "success";
    } else {
        echo "failed";
    }


?>