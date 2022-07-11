<?php
include_once("dbconnect.php");

$chapterid = $_POST['chapterid'];

$sqldelete = "DELETE FROM tbl_272033_SyllabusDetails WHERE ChapterID = '$chapterid'";
$stmt = $conn->prepare($sqldelete);
if ($stmt->execute()) {
    echo "success";
} else {
    echo "failed";
}
?>