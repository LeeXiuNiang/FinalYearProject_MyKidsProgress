<?php
include_once("dbconnect.php");
$id = $_POST['id'];
$marks= $_POST['marks'];
$grade= $_POST['grade'];

$sqlupdate = "UPDATE  tbl_272033_TestResults SET Marks = '$marks', Grade = '$grade' WHERE id = '$id'";
    
    if ($conn->query($sqlupdate) === TRUE) {
        echo "success";
    } else {
        echo "failed";
    }


?>
