<?php
  

include_once("dbconnect.php");

$sql1 = "SELECT * FROM tbl_272033_StudentDetails";
$sql2 = "SELECT * FROM tbl_272033_StaffDetails";
$sql3 = "SELECT * FROM tbl_272033_ClassDetails";

$result1 = $conn->query($sql1);
$result2 = $conn->query($sql2);
$result3 = $conn->query($sql3);

$rowcount1 = mysqli_num_rows( $result1 );
$rowcount2 = mysqli_num_rows( $result2 );
$rowcount3 = mysqli_num_rows( $result3 );


echo $rowcount1.",".$rowcount2.",".$rowcount3;   

// echo $rowcount;

?>