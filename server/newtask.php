<?php

include_once("dbconnect.php");
$task = $_POST['task'];
$notes = $_POST['notes'];
$due = $_POST['due'];
$classid = $_POST['classid'];
$subjectid = $_POST['subjectid'];
						
$sqlinsert = "INSERT INTO tbl_272033_TaskDetails(TaskTitle,DueDate, Notes, ClassID,SubjectID) VALUES('$task','$due','$notes','$classid','$subjectid')";

if ($conn->query($sqlinsert) === TRUE){
    echo "success";
}else{
    echo "failed";
}

// $sqltaskid="SELECT tbl_272033_TaskDetails.TaskID FROM tbl_272033_TaskDetails WHERE tbl_272033_TaskDetails.TaskTitle = '$task' AND tbl_272033_TaskDetails.DueDate = '$due' AND tbl_272033_TaskDetails.Notes = '$notes' AND tbl_272033_TaskDetails.ClassID = '$classid' ANDtbl_272033_TaskDetails.SubjectID = '$subjectid'";

// $result = $conn->query($sqltaskid);

// $sqladd1 = "INSERT INTO tbl_272033_TaskStatus (StudentID, SubjectID)
//               SELECT StudentID,SubjectID  FROM tbl_272033_StudentDetails
//               WHERE ClassID='$classid'";
              
// $sqlupdate = "UPDATE tbl_272033_TaskStatus SET TaskID = '$sqltaskid', status = 'Pending' WHERE status = ''";

// $stmtadd1 = $conn->prepare($sqladd1);
//   $stmtadd1->execute();

//   $stmtup = $conn->prepare($sqlupdate);
//   $stmtup->execute();
              

?>