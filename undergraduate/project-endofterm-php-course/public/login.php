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
        <h2>Login</h2>
        <p>Study Room Reservation System</p>
    </section>

    <section class="login-section">
        <form class="login-form" action="loginHandle.php" method="post">
            <label for="username">Username</label>
            <input type="text" name="username" placeholder="Username" required>
            <br>
            <label for="password">Password</label>
            <input type="password" name="password" placeholder="Password" required>
            <br>
            <button type="submit">Login</button>
            <button type="reset">Reset</button>
        </form>
    </section>
</main>

<?php include 'footer.html'; ?>

</body>
</html>