<?php
include_once("dbconnect.php");

$studentid = $_POST['studentid'];

$sqldelete = "DELETE FROM tbl_272033_StudentDetails WHERE StudentID = '$studentid'";
$stmt = $conn->prepare($sqldelete);
if ($stmt->execute()) {
    echo "success";
} else {
    echo "failed";
}
?>