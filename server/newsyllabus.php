<?php

include_once("dbconnect.php");
$no = $_POST['no'];
$chapter = $_POST['chapter'];
$classid = $_POST['classid'];
$subjectid = $_POST['subjectid'];
						
$sqlinsert = "INSERT INTO tbl_272033_SyllabusDetails(ChapterNumber,ChapterTitle, ChapterStatus, ClassID,SubjectID) VALUES('$no','$chapter','Not Started','$classid','$subjectid')";
if ($conn->query($sqlinsert) === TRUE){
    echo "success";
}else{
    echo "failed";
}
?>