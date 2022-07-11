<?php

include_once("dbconnect.php");
$name = $_POST['name'];
$staffID = $_POST['staffID'];
$gender = $_POST['gender'];
$dob = $_POST['dob'];
$phone =  $_POST['phone'];
$email =  $_POST['email'];
$password =  $_POST['password'];
$passha1 = sha1($password);


$sqlcheckstaff = "SELECT * FROM tbl_272033_StaffDetails WHERE StaffID = '$staffID'";
$result = $conn->query($sqlcheckstaff);

if ($result->num_rows > 0) {
    echo "duplicated";
}else{
    
    $sqlinsert = "INSERT INTO tbl_272033_StaffDetails(StaffID,Name, Gender, DateOfBirth,PhoneNumber,Email,AccountPassword,Role,ClassNameIC) VALUES('$staffID','$name','$gender','$dob','$phone','$email','$passha1','Teacher','-')";
    if ($conn->query($sqlinsert) === TRUE){
        echo "success";
    }else{
        echo "failed";
    }
}

?>