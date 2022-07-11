<?php
include_once("dbconnect.php");
$studentid = $_POST['studentid'];

$sqlremove = "UPDATE tbl_272033_StudentDetails SET ClassID = '-' WHERE StudentID = '$studentid'";
    

    if ($conn->query($sqlremove) === TRUE) {
        echo "success";
    } else {
        echo "failed";
    }


?>