<?php
include_once("dbconnect.php");

$classid = $_POST['classid'];
$staffid = $_POST['staffid'];

$sqldelete = "DELETE FROM tbl_272033_ClassDetails WHERE ClassID = '$classid'";
$stmt = $conn->prepare($sqldelete);
$sqldelete2 = "DELETE FROM tbl_272033_ClassesSubjects WHERE ClassID = '$classid'";
$stmt2 = $conn->prepare($sqldelete2);
$sqlupdate = "UPDATE  tbl_272033_StaffDetails SET ClassNameIC = '-' WHERE StaffID = '$staffid'";
$stmt3 = $conn->prepare($sqlupdate);
if ($stmt->execute() AND $stmt2->execute() AND $stmt3->execute()) {
    echo "success";
} else {
    echo "failed";
}
?>