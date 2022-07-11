<?php
include_once("dbconnect.php");

$taskid = $_POST['taskid'];

$sqldelete = "DELETE FROM tbl_272033_TaskDetails WHERE TaskID = '$taskid'";
$stmt = $conn->prepare($sqldelete);
if ($stmt->execute()) {
    echo "success";
} else {
    echo "failed";
}
?>