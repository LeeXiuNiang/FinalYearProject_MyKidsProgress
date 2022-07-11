<?php

include_once("dbconnect.php");
$subjectid = $_POST['subjectid'];
$classid = $_POST['classid'];

$sqlinsert = "INSERT INTO tbl_272033_TestResults (StudentID)
              SELECT StudentID FROM tbl_272033_StudentDetails
              WHERE ClassID='$classid'";

if ($conn->query($sqlinsert) === TRUE){
    echo "success";
}else{
    echo "failed";
}
              

?>