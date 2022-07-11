<?php

include_once("dbconnect.php");
$classid = $_POST['classid'];
$sub = $_POST['sub'];
$teachersub = $_POST['teachersub'];

$sqlcheckteachers = "SELECT * FROM tbl_272033_StaffDetails WHERE StaffID = '$teachersub'";
$result = $conn->query($sqlcheckteachers);

$sqlupdate = "UPDATE tbl_272033_ClassesSubjects SET Teacher = '$teachersub' WHERE SubjectName = '$sub' AND ClassID = '$classid'";
if ($result->num_rows > 0) {
    if ($conn->query($sqlupdate) === TRUE){
        echo "success";
    }else{
        echo "failed";
    }
}else{
        echo "noresult";
}
?>