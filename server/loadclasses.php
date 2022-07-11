<?php
include_once("dbconnect.php");

$name = $_POST['name'];

if ($name == "") {
    // $sqlloadclasses ="SELECT * FROM tbl_272033_ClassDetails ORDER BY ClassID DESC";
    $sqlloadclasses = "SELECT tbl_272033_ClassDetails.ClassID, tbl_272033_ClassDetails.ClassName, tbl_272033_ClassDetails.TeacherInCharged, tbl_272033_ClassDetails.Subject1, tbl_272033_ClassDetails.Subject2, tbl_272033_ClassDetails.Subject3, tbl_272033_ClassDetails.Subject4, tbl_272033_ClassDetails.Subject5, tbl_272033_StaffDetails.Name FROM tbl_272033_ClassDetails LEFT JOIN tbl_272033_StaffDetails ON tbl_272033_ClassDetails.TeacherInCharged = tbl_272033_StaffDetails.StaffID ORDER BY ClassName ASC";
} else {
    // $sqlloadclasses = "SELECT * FROM tbl_272033_ClassDetails WHERE ClassName LIKE '%$name%'";
    $sqlloadclasses = "SELECT tbl_272033_ClassDetails.ClassID, tbl_272033_ClassDetails.ClassName, tbl_272033_ClassDetails.TeacherInCharged, tbl_272033_ClassDetails.Subject1, tbl_272033_ClassDetails.Subject2, tbl_272033_ClassDetails.Subject3, tbl_272033_ClassDetails.Subject4, tbl_272033_ClassDetails.Subject5, tbl_272033_StaffDetails.Name FROM tbl_272033_ClassDetails LEFT JOIN tbl_272033_StaffDetails ON tbl_272033_ClassDetails.TeacherInCharged = tbl_272033_StaffDetails.StaffID WHERE ClassName LIKE '%$name%'";
}

$result = $conn->query($sqlloadclasses);

if ($result->num_rows > 0) {
    $response['classes'] = array();
    while ($row = $result->fetch_assoc()) {
        $classlist['classid'] = $row['ClassID'];
        $classlist['name'] = $row['ClassName'];
        $classlist['teacher'] = $row['TeacherInCharged'];
        $classlist['sub1'] = $row['Subject1'];
        $classlist['sub2'] = $row['Subject2'];
        $classlist['sub3'] = $row['Subject3'];
        $classlist['sub4'] = $row['Subject4'];
        $classlist['sub5'] = $row['Subject5'];
        $classlist['teachername'] = $row['Name'];
        array_push($response['classes'], $classlist);
    }
    echo json_encode($response);
} else {
    echo "nodata";
}

?>
