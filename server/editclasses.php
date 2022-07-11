<?php
// include_once("dbconnect.php");
// $classid = $_POST['classid'];
// $name= $_POST['name'];
// $teacher = $_POST['teacher'];
// $oldteacher = $_POST['oldteacher'];
// $sub1 = $_POST['sub1'];
// $sub2 = $_POST['sub2'];
// $sub3 = $_POST['sub3'];
// $sub4 = $_POST['sub4'];
// $sub5 = $_POST['sub5'];

// $sqlcheckteachers = "SELECT * FROM tbl_272033_StaffDetails WHERE StaffID = '$teacher'";
// $result = $conn->query($sqlcheckteachers);

// $sqlupdateclasses = "UPDATE  tbl_272033_ClassDetails SET ClassName = '$name', TeacherInCharged = '$teacher', Subject1 = '$sub1', Subject2 = '$sub2', Subject3 = '$sub3', Subject4 = '$sub4', Subject5 = '$sub5' WHERE ClassID = '$classid'";
    
// if ($result->num_rows > 0) {
//     if ($conn->query($sqlupdateclasses) === TRUE) {
//         $sqlupdate = "UPDATE tbl_272033_StaffDetails SET ClassNameIC ='$name' WHERE StaffID ='$teacher'";
//             if ($conn->query($sqlupdate) === TRUE) {
//                 $sqlupdate2 = "UPDATE tbl_272033_StaffDetails SET ClassNameIC ='-' WHERE StaffID ='$oldteacher'";
//                 if ($conn->query($sqlupdate2) === TRUE) {
//                     echo "success";
//                 } else {
//                     echo "failed";
//                 }
//             } else {
//                 echo "failed";
//             }
//     } else {
//         echo "failed";
//     }
// }else{
//         echo "noresult";
// }

include_once("dbconnect.php");
$classid = $_POST['classid'];
$name= $_POST['name'];
$teacher = $_POST['teacher'];
$oldteacher = $_POST['oldteacher'];
$sub1 = $_POST['sub1'];
$sub2 = $_POST['sub2'];
$sub3 = $_POST['sub3'];
$sub4 = $_POST['sub4'];
$sub5 = $_POST['sub5'];

$sqlcheckteachers = "SELECT * FROM tbl_272033_StaffDetails WHERE StaffID = '$teacher'";
$result = $conn->query($sqlcheckteachers);

$sqlupdateclasses = "UPDATE  tbl_272033_ClassDetails SET ClassName = '$name', TeacherInCharged = '$teacher', Subject1 = '$sub1', Subject2 = '$sub2', Subject3 = '$sub3', Subject4 = '$sub4', Subject5 = '$sub5' WHERE ClassID = '$classid'";
    
if ($result->num_rows > 0) {
    if ($conn->query($sqlupdateclasses) === TRUE) {
        echo "success";
    } else {
        echo "failed";
    }
}else{
        echo "noresult";
}


?>