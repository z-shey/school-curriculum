<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Study Room Reservation System - v1.0.0</title>
    <link rel="stylesheet" href="./assets/css/reset.css">
    <link rel="stylesheet" href="./assets/css/main.css">
</head>
<body>

<?php include 'header.html'; ?>

<main>
    <section class="intro">
        <h2>Register</h2>
        <p>Study Room Reservation System</p>
    </section>

    <section class="register-section">
        <form class="register-form" action="registerHandle.php" method="post">
            <label for="username">Username</label>
            <input type="text" name="username" placeholder="Username">
            <br>
            <label for="email">Email</label>
            <input type="text" name="email" placeholder="Email">
            <br>
            <label for="password">Password</label>
            <input type="password" name="password" placeholder="Password">
            <br>
            <label for="re_password">Check Password</label>
            <input type="password" name="re_password" placeholder="Password">
            <br>
            <label for="gender">Gender</label>
            <div class="radio-group">
                <input type="radio" name="gender" value="male" checked="checked"> Male
                <input type="radio" name="gender" value="female"> Female
            </div>
            <!-- 头像 -->
            <label for="avatar">Avatar</label>
<!--            --><?php
//            for ($i = 1; $i <= 10; $i++) {
//                $headfile = "assets/img/head/" . $i . ".jpg";
//                echo "
//                    <img src='$headfile' alt='head$i' class='head-img' width='50' height='50'>
//                    <input type='radio' name='avatar' value='$headfile' >
//                    ";
//            }
//            ?>
            <br>
            <button type="submit">Register</button>
        </form>

    </section>
</main>

<?php include 'footer.html'; ?>

</body>
</html>