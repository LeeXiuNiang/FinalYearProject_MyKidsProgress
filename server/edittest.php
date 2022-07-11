<?php
include_once("dbconnect.php");
$testid = $_POST['testid'];
$test= $_POST['test'];
$fmarks= $_POST['fmarks'];

$sqlupdate = "UPDATE  tbl_272033_TestDetails SET TestName = '$test', FullMarks = '$fmarks' WHERE TestID = '$testid'";
    
    if ($conn->query($sqlupdate) === TRUE) {
        echo "success";
    } else {
        echo "failed";
    }


?>
