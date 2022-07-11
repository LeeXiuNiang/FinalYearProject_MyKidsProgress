<?php

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require '/home/crimsonw/public_html/s272033/mykidsprogress/php/PHPMailer/src/Exception.php';
require '/home/crimsonw/public_html/s272033/mykidsprogress/php/PHPMailer/src/PHPMailer.php';
require '/home/crimsonw/public_html/s272033/mykidsprogress/php/PHPMailer/src/SMTP.php';

include_once("dbconnect.php");

$email = $_POST['email'];
$name = $_POST['username'];
$phoneNumber = $_POST['phone'];
$studentID = $_POST['studentID'];
$password = $_POST['password'];
$passha1 = sha1($password);
$otp = rand(1000,9999);

$sqlcheckstudents = "SELECT * FROM tbl_272033_StudentDetails WHERE StudentID = '$studentID'";
$result = $conn->query($sqlcheckstudents);

if ($result->num_rows > 0) {
    $sqlregister = "INSERT INTO tbl_272033_ParentDetails(Email, Name, PhoneNumber, Password, StudentID, otp) VALUES('$email','$name','$phoneNumber','$passha1','$studentID','$otp')";
        if($conn->query($sqlregister) === TRUE){
            sendEmail($otp,$email);
            echo "success";
        }else{
            echo "failed";
        }
}else{
    echo "noresult";
}

function sendEmail($otp,$email){
    $mail = new PHPMailer(true);
    $mail->SMTPDebug = 0;                                               //Disable verbose debug output
    $mail->isSMTP();                                                    //Send using SMTP
    $mail->Host       = 'mail.crimsonwebs.com';                         //Set the SMTP server to send through
    $mail->SMTPAuth   = true;                                           //Enable SMTP authentication
    $mail->Username   = 'noreply@crimsonwebs.com';                  //SMTP username
    $mail->Password   = 'xS)1DEbCZCwO';                                 //SMTP password
    $mail->SMTPSecure = 'none';         
    $mail->Port       = 25;
    
    $from = "noreply@crimsonwebs.com";
    $to = $email;
    $subject = "From MyKidsProgress. Verify your account";
    $message = "<p>Your account has been created. Please click the following link to verify your account.</p><br><br>
    <a href='https://crimsonwebs.com/s272033/mykidsprogress/php/verify_account.php?email=".$email."&key=".$otp."'>Click Here to verify your account</a>";
    
    $mail->setFrom($from,"MyKidsProgress");
    $mail->addAddress($to);                                             //Add a recipient
    
    //Content
    $mail->isHTML(true);                                                //Set email format to HTML
    $mail->Subject = $subject;
    $mail->Body    = $message;
    $mail->send();
}


?>