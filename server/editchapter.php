<?php
include_once("dbconnect.php");
$chapterid = $_POST['chapterid'];
$chapterno= $_POST['chapterno'];
$chapter= $_POST['chapter'];

$sqlupdatechapter = "UPDATE  tbl_272033_SyllabusDetails SET ChapterNumber = '$chapterno', ChapterTitle = '$chapter' WHERE ChapterID = '$chapterid'";
    
    if ($conn->query($sqlupdatechapter) === TRUE) {
        echo "success";
    } else {
        echo "failed";
    }


?>
