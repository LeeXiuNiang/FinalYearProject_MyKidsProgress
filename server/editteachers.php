<?php
include_once("dbconnect.php");
$staffid = $_POST['staffid'];
$name= $_POST['name'];
$gender = $_POST['gender'];
$dob = $_POST['dob'];
$phone = $_POST['phone'];
$email = $_POST['email'];

$sqlupdateteachers = "UPDATE  tbl_272033_StaffDetails SET Name = '$name', Gender = '$gender', DateOfBirth = '$dob', PhoneNumber = '$phone', Email = '$email' WHERE StaffID = '$staffid'";;
    

    if ($conn->query($sqlupdateteachers) === TRUE) {
        echo "success";
    } else {
        echo "failed";
    }


?>