<?php

include_once("dbconnect.php");
$classid = $_POST['classid'];
$student = $_POST['student'];

$sqlcheckstudents = "SELECT * FROM tbl_272033_StudentDetails WHERE StudentID = '$student'";
$result = $conn->query($sqlcheckstudents);

$sqlupdate = "UPDATE tbl_272033_StudentDetails SET ClassID = '$classid' WHERE StudentID = '$student'";
if ($result->num_rows > 0) {
    if ($conn->query($sqlupdate) === TRUE){
        echo "success";
    }else{
        echo "failed";
    }
}else{
    echo "noresult";
}
?>