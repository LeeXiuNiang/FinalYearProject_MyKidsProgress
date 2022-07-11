<?php

use PHPMailer\PHPMailer\PHPMailer;
use PHPMailer\PHPMailer\Exception;

require '/home/crimsonw/public_html/s272033/mykidsprogress/php/PHPMailer/src/Exception.php';
require '/home/crimsonw/public_html/s272033/mykidsprogress/php/PHPMailer/src/PHPMailer.php';
require '/home/crimsonw/public_html/s272033/mykidsprogress/php/PHPMailer/src/SMTP.php';

include_once("dbconnect.php");

$email = $_POST['email'];
$newotp = rand(1000,9999);
$newpass = random_password(10);
$passha = sha1($newpass);

$sql = "SELECT * FROM tbl_272033_ParentDetails WHERE Email = '$email'";
    $result = $conn->query($sql);
    if ($result->num_rows > 0) {
        $sqlupdate = "UPDATE tbl_272033_ParentDetails SET otp = '$newotp', Password = '$passha' WHERE Email = '$email'";
        if ($conn->query($sqlupdate) === TRUE){
                sendEmail($newotp,$newpass,$email);
                echo 'success';
        }else{
                echo 'failed';
        }
    }else{
        echo "failed";
    }
    
function sendEmail($otp,$newpass,$email){
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
    $subject = "From MyKidsProgress. Reset your account";
    $message = "<p>Your account password has been reset. Please login again using the information below. You may change your password afterwards in My Profile.</p><br><br><h3>Password:".$newpass."</h3><br><br>
    <a href='https://crimsonwebs.com/s272033/mykidsprogress/php/verify_account.php?email=".$email."&key=".$otp."'>Click Here to reactivate your account</a>";
    
    $mail->setFrom($from,"MyKidsProgress");
    $mail->addAddress($to);                                             //Add a recipient
    
    //Content
    $mail->isHTML(true);                                                //Set email format to HTML
    $mail->Subject = $subject;
    $mail->Body    = $message;
    $mail->send();
}

function random_password($length){
    //A list of characters that can be used in our random password
    $characters = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    //Create blank string
    $password = '';
    //Get the index of the last character in our $characters string
    $characterListLength = mb_strlen($characters, '8bit') - 1;
    //Loop from 1 to the length that was specified
    foreach(range(1,$length) as $i){
        $password .=$characters[rand(0,$characterListLength)];
    }
    return $password;
}


?>