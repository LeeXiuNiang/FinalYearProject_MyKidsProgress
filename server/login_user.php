<?php
error_reporting(0);
include_once("dbconnect.php");
$email = $_POST['email'];
$password = sha1($_POST['password']);
$role = $_POST['role'];

if($role=="Parent"){
    $sqlloginuser = "SELECT * FROM tbl_272033_ParentDetails WHERE Email = '$email' AND Password = '$password' AND otp = '0'";
    $result = $conn->query($sqlloginuser);
    if ($result->num_rows > 0) {
    while ($row = $result ->fetch_assoc()){
        echo $data = "success,".$row["Name"].",".$row["StudentID"];
        //echo "success";
    }
    }else{
        echo "failed";
    }
}elseif($role=="Teacher"){
    $sqlloginstaff = "SELECT * FROM tbl_272033_StaffDetails WHERE Email = '$email' AND AccountPassword = '$password' AND Role = 'Teacher'";
    $result = $conn->query($sqlloginstaff);
    if ($result->num_rows > 0) {
    while ($row = $result ->fetch_assoc()){
        echo $data = "success,".$row["Name"].",".$row["StaffID"];
        //echo "success";
    }
    }else{
        echo "failed";
    }
}elseif($role=="Principal"){
    $sqlloginstaff = "SELECT * FROM tbl_272033_StaffDetails WHERE Email = '$email' AND AccountPassword = '$password' AND Role = 'Principal'";
    $result = $conn->query($sqlloginstaff);
    if ($result->num_rows > 0) {
    while ($row = $result ->fetch_assoc()){
        echo $data = "success,".$row["Name"].",".$row["StaffID"];
        //echo "success";
    }
    }else{
        echo "failed";
    }
}

// if ($result->num_rows > 0) {
//     while ($row = $result ->fetch_assoc()){
//         echo $data = "success,".$row["Name"];
//         //echo "success";
//     }
// }else{
//     echo "failed";
// }

// $sqllogin = "SELECT * FROM tbl_272033_ParentDetails WHERE Email = '$email' AND Password = '$password' AND otp = '0'";
// $result = $conn->query($sqllogin);

// if ($result->num_rows > 0) {
//     while ($row = $result ->fetch_assoc()){
//         echo $data = "success,".$row["Name"];
//         //echo "success";
//     }
// }else{
//     echo "failed";
// }

?>