<?php
include_once("dbconnect.php");

$name = $_POST['name'];

if ($name == "") {
    $sqlloadteachers ="SELECT * FROM tbl_272033_StaffDetails WHERE Role='Teacher' ORDER BY StaffID ASC";
} else {
    $sqlloadteachers = "SELECT * FROM tbl_272033_StaffDetails WHERE Name LIKE '%$name%'";
}

$result = $conn->query($sqlloadteachers);

if ($result->num_rows > 0) {
    $response['teachers'] = array();
    while ($row = $result->fetch_assoc()) {
        $teacherlist['staffid'] = $row['StaffID'];
        $teacherlist['name'] = $row['Name'];
        $teacherlist['gender'] = $row['Gender'];
        $teacherlist['dob'] = $row['DateOfBirth'];
        $teacherlist['phone'] = $row['PhoneNumber'];
        $teacherlist['email'] = $row['Email'];
        $teacherlist['classname'] = $row['ClassNameIC'];
        array_push($response['teachers'], $teacherlist);
    }
    echo json_encode($response);
} else {
    echo "nodata";
}

?>
