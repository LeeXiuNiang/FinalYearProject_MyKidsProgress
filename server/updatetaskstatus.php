<?php
include_once("dbconnect.php");
$id = $_POST['id'];


$sqlupdatestatus = "UPDATE  tbl_272033_TaskStatus SET Status = 'Completed' WHERE id = '$id'";
    
    if ($conn->query($sqlupdatestatus) === TRUE) {
        echo "success";
    } else {
        echo "failed";
    }


?>
