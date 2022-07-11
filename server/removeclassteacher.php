<?php
include_once("dbconnect.php");
$classid = $_POST['classid'];
$teacherid = $_POST['teacherid'];
$sub = $_POST['sub'];

$sqlremove = "UPDATE tbl_272033_ClassesSubjects SET Teacher = '-' WHERE ClassID = '$classid' AND Teacher = '$teacherid' AND SubjectName = '$sub'";
    

    if ($conn->query($sqlremove) === TRUE) {
        echo "success";
    } else {
        echo "failed";
    }


?>