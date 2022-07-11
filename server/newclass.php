<?php

include_once("dbconnect.php");
$name = $_POST['name'];
$classID = $_POST['classID'];
$teacher = $_POST['teacher'];
$sub1 = $_POST['sub1'];
$sub2 = $_POST['sub2'];
$sub3 = $_POST['sub3'];
$sub4 = $_POST['sub4'];
$sub5 = $_POST['sub5'];

$sqlcheckclass = "SELECT * FROM tbl_272033_ClassDetails WHERE ClassID = '$classID'";
$result1 = $conn->query($sqlcheckclass);

$sqlcheckteachers = "SELECT * FROM tbl_272033_StaffDetails WHERE StaffID = '$teacher'";
$result = $conn->query($sqlcheckteachers);

if ($result1->num_rows > 0) {
    echo "duplicated";
}else{
    if ($result->num_rows > 0) {
        $sqlinsert = "INSERT INTO tbl_272033_ClassDetails(ClassID, ClassName, TeacherInCharged, Subject1, Subject2, Subject3, Subject4, Subject5) VALUES('$classID','$name','$teacher','$sub1','$sub2', '$sub3', '$sub4', '$sub5')";
        if ($conn->query($sqlinsert) === TRUE){
            $sqlupdate = "UPDATE tbl_272033_StaffDetails SET ClassNameIC ='$name' WHERE StaffID ='$teacher'";
            if ($conn->query($sqlupdate) === TRUE) {
                echo "success";
            } else {
                echo "failed";
            }
            // echo "success";
        }else{
            echo "failed";
        }
        
    }else{
        echo "noresult";
    }

}						
// $sqlinsert = "INSERT INTO ClassDetails(ClassID, ClassName, TeacherInCharged, Subject1, Subject2, Subject3, Subject4, Subject5) VALUES('$classID','$name','$teacher','$sub1','$sub2', '$sub3', '$sub4', '$sub5')";
// if ($conn->query($sqlinsert) === TRUE){
//     echo "success";
// }else{
//     echo "failed";
// }
?>