<?php
include_once("dbconnect.php");

$classid = $_POST['classid'];
$subjectid = $_POST['subjectid'];

$sqlloadsubjects = "SELECT * FROM tbl_272033_SyllabusDetails WHERE ClassID = '$classid' AND SubjectID = '$subjectid' ORDER BY ChapterNumber ASC";

$result = $conn->query($sqlloadsubjects);

if ($result->num_rows > 0) {
    $response['syllabus'] = array();
    while ($row = $result->fetch_assoc()) {
        $syllabuslist['chapterid'] = $row['ChapterID'];
        $syllabuslist['chapno'] = $row['ChapterNumber'];
        $syllabuslist['chapter'] = $row['ChapterTitle'];
        $syllabuslist['status'] = $row['ChapterStatus'];
        array_push($response['syllabus'], $syllabuslist);
    }
    echo json_encode($response);
} else {
    echo "nodata";
}

?>