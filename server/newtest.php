<?php

include_once("dbconnect.php");
$test = $_POST['test'];
$fmarks = $_POST['fmarks'];
$classid = $_POST['classid'];
$subjectid = $_POST['subjectid'];
						
$sqlinsert = "INSERT INTO tbl_272033_TestDetails(TestName,FullMarks, ClassID,SubjectID) VALUES('$test','$fmarks','$classid','$subjectid')";

if ($conn->query($sqlinsert) === TRUE){
    echo "success";
}else{
    echo "failed";
}


?>