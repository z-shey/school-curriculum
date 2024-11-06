<?php
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = isset($_POST['username']) ? $_POST['username'] : '';
    $password = isset($_POST['password']) ? $_POST['password'] : '';

    echo "Username: " . $username . "<br>";
    echo "Password: " . $password . "<br>";

//    TODO
} else {
    // 如果不是 POST 请求，可能需要处理错误或重定向回登录页面
    echo "Invalid request method.";
}
?>
