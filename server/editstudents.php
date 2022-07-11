<?php
include_once("dbconnect.php");
$studentid = $_POST['studentid'];
$name= $_POST['name'];
$gender = $_POST['gender'];
$dob = $_POST['dob'];
$phone = $_POST['phone'];

$sqlupdatestudents = "UPDATE  tbl_272033_StudentDetails SET Name = '$name', Gender = '$gender', DateOfBirth = '$dob', ParentsPhoneNumber = '$phone' WHERE StudentID = '$studentid'";
    

    if ($conn->query($sqlupdatestudents) === TRUE) {
        echo "success";
    } else {
        echo "failed";
    }


?>