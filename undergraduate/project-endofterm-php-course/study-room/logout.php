<?php
session_start(); // 开启会话

// 销毁会话变量
$_SESSION = array();

// 销毁会话
session_destroy();

// 重定向到登录页面
header("Location: login.php");
exit;
?>