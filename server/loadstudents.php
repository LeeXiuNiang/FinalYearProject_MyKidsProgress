<?php
include_once("dbconnect.php");

$name = $_POST['name'];

if ($name == "") {
    // $sqlloadstudents ="SELECT * FROM tbl_272033_StudentDetails ORDER BY StudentID ASC";
    $sqlloadstudents = "SELECT tbl_272033_StudentDetails.StudentID, tbl_272033_StudentDetails.Name, tbl_272033_StudentDetails.Gender, tbl_272033_StudentDetails.DateOfBirth, tbl_272033_StudentDetails.ParentsPhoneNumber, tbl_272033_StudentDetails.ClassID, tbl_272033_ClassDetails.ClassName FROM tbl_272033_StudentDetails LEFT JOIN tbl_272033_ClassDetails ON tbl_272033_StudentDetails.ClassID = tbl_272033_ClassDetails.ClassID ORDER BY StudentID ASC";
} else {
    // $sqlloadstudents = "SELECT * FROM tbl_272033_StudentDetails WHERE Name LIKE '%$name%'";
    $sqlloadstudents = "SELECT tbl_272033_StudentDetails.StudentID, tbl_272033_StudentDetails.Name, tbl_272033_StudentDetails.Gender, tbl_272033_StudentDetails.DateOfBirth, tbl_272033_StudentDetails.ParentsPhoneNumber, tbl_272033_StudentDetails.ClassID, tbl_272033_ClassDetails.ClassName FROM tbl_272033_StudentDetails LEFT JOIN tbl_272033_ClassDetails ON tbl_272033_StudentDetails.ClassID = tbl_272033_ClassDetails.ClassID WHERE Name LIKE '%$name%'";
}

$result = $conn->query($sqlloadstudents);

if ($result->num_rows > 0) {
    $response['students'] = array();
    while ($row = $result->fetch_assoc()) {
        $studentlist['studentid'] = $row['StudentID'];
        $studentlist['name'] = $row['Name'];
        $studentlist['gender'] = $row['Gender'];
        $studentlist['dob'] = $row['DateOfBirth'];
        $studentlist['phone'] = $row['ParentsPhoneNumber'];
        $studentlist['classid'] = $row['ClassID'];
        $studentlist['classname'] = $row['ClassName'];
        array_push($response['students'], $studentlist);
    }
    echo json_encode($response);
} else {
    echo "nodata";
}

?>
