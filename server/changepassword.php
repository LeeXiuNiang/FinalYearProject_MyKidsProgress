<?php
include_once("dbconnect.php");
$role = $_POST['role'];
$email = $_POST['email'];
$newpass = $_POST['newpass'];
$passha1 = sha1($newpass);


$sqlupdatepassword = "UPDATE tbl_user SET password = '$passha1' WHERE user_email = '$email'";
    
if($role=="Parent"){
    $sqlupdateuserpassword = "UPDATE tbl_272033_ParentDetails SET Password = '$passha1' WHERE Email = '$email'";
    $result = $conn->query($sqlupdateuserpassword);
    if ($result===TRUE) {
        echo "success";
    }else{
        echo "failed";
    }
}else{
    $sqlupdatepassword = "UPDATE tbl_272033_StaffDetails SET AccountPassword = '$passha1' WHERE Email = '$email'";
    $result = $conn->query($sqlupdatepassword);
    if ($result===TRUE) {
        echo "success";
    }else{
        echo "failed";
    }
}
?>



