<?php

include_once("dbconnect.php");
$name = $_POST['name'];
$studentID = $_POST['studentID'];
$gender = $_POST['gender'];
$dob = $_POST['dob'];
$phone =  $_POST['phone'];
						
$sqlinsert = "INSERT INTO tbl_272033_StudentDetails(StudentID,Name, Gender, DateOfBirth,ParentsPhoneNumber,ClassID) VALUES('$studentID','$name','$gender','$dob','$phone','-')";
$sqlcheckstudents = "SELECT * FROM tbl_272033_StudentDetails WHERE StudentID = '$studentID'";
$result = $conn->query($sqlcheckstudents);

if ($result->num_rows > 0) {
    echo "duplicated";
}else{
    if ($conn->query($sqlinsert) === TRUE){
        echo "success";
    }else{
        echo "failed";
    }
}
?>