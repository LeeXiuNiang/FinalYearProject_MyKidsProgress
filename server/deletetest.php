<?php
include_once("dbconnect.php");

$testid = $_POST['testid'];

$sqldelete = "DELETE FROM tbl_272033_TestDetails WHERE TestID = '$testid'";
$stmt = $conn->prepare($sqldelete);
if ($stmt->execute()) {
    echo "success";
} else {
    echo "failed";
}
?>