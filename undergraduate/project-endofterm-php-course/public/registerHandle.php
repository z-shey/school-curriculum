<?php
session_start();

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = isset($_POST['username']) ? $_POST['username'] : '';
    $email = isset($_POST['email']) ? $_POST['email'] : '';
    $password = isset($_POST['password']) ? $_POST['password'] : '';
    $re_password = isset($_POST['re_password']) ? $_POST['re_password'] : '';

    echo "Username: " . $username . "<br>";
    echo "Email: " . $email . "<br>";
    echo "Password: " . $password . "<br>";
    echo "Re-Password: " . $re_password . "<br>";

    echo "<br>";

    // Check function for username
    function checkUsernameFunction($username)
    {
        if (strlen($username) >= 3) {
            return true;
        }
        return false;
    }

    if (checkUsernameFunction($username)) {
        echo "Username is valid.<br>";
    } else {
        echo "Username is not valid.<br>";
    }

    // Check function for email
    function checkEmailFunction($email)
    {
        if (filter_var($email, FILTER_VALIDATE_EMAIL)) {
            return true;
        } else {
            return false;
        }
    }

    if (checkEmailFunction($email)) {
        echo "Email is valid.<br>";
    } else {
        $_SESSION['error'] = "OK, Error Message: Invalid email address";
        header("Location: error.php");
        exit;
    }

    // Check function for password and re-password
    function checkPasswordFunction($password, $re_password)
    {
        if ($password === $re_password) {
            return true;
        }

        return false;
    }

    if (checkPasswordFunction($password, $re_password)) {
        echo "Password is valid.<br>";
    } else {
        $_SESSION['error'] = "OK, Error Message: Your password and re-password do not equal, please try again.";
        header("Location: error.php");
        exit;
    }

} else {
    // 如果不是 POST 请求，可能需要处理错误或重定向回登录页面
    echo "Invalid request method.<br>";

}
?>