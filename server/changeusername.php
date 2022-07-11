<?php
include_once("dbconnect.php");
$role = $_POST['role'];
$email = $_POST['email'];
$newname = $_POST['newname'];

if($role=="Parent"){
    $sqlupdateusername = "UPDATE tbl_272033_ParentDetails SET Name = '$newname' WHERE Email = '$email'";
    $result = $conn->query($sqlupdateusername);
    if ($result===TRUE) {
        echo "success";
    }else{
        echo "failed";
    }
}else{
    $sqlupdatename = "UPDATE tbl_272033_StaffDetails SET Name = '$newname' WHERE Email = '$email'";
    $result = $conn->query($sqlupdatename);
    if ($result===TRUE) {
        echo "success";
    }else{
        echo "failed";
    }
}

?>