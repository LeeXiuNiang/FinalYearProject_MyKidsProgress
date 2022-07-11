<?php

include_once("dbconnect.php");
$classID = $_POST['classID'];
$teacher = $_POST['teacher'];
$sub = $_POST['sub'];

$sqlinsert = "INSERT INTO tbl_272033_ClassesSubjects(SubjectName, ClassID, TeacherInCharged, Teacher) VALUES('$sub','$classID','$teacher','-')";
    if ($conn->query($sqlinsert) === TRUE){
        echo "success";
    }else{
        echo "failed";
    }


?>