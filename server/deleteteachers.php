<?php
include_once("dbconnect.php");

$staffid = $_POST['staffid'];

$sqldelete = "DELETE FROM tbl_272033_StaffDetails WHERE staffid = '$staffid'";
$sqlupdate = "UPDATE  tbl_272033_ClassDetails SET TeacherInCharged = '-' WHERE TeacherInCharged = '$staffid'";
$stmt = $conn->prepare($sqldelete);
if ($stmt->execute()) {
    $stmt1 = $conn->prepare($sqlupdate);
    $stmt1->execute();
    echo "success";
} else {
    echo "failed";
}
?>