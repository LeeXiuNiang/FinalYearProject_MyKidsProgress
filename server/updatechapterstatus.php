<?php
include_once("dbconnect.php");
$chapterid = $_POST['chapterid'];
$status= $_POST['status'];

$sqlupdatestatus = "UPDATE  tbl_272033_SyllabusDetails SET ChapterStatus = '$status' WHERE ChapterID = '$chapterid'";
    
    if ($conn->query($sqlupdatestatus) === TRUE) {
        echo "success";
    } else {
        echo "failed";
    }


?>
