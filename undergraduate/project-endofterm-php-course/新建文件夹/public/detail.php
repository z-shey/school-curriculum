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
        <h2>Detail</h2>
        <p>Study Room Reservation System</p>
    </section>

    <?php
    if (isset($_GET['room_id'])) {
        $roomId = $_GET['room_id'];
//    $roomDetails = getRoomDetails($roomId);
        echo "<p>Room ID: $roomId</p>";
    }
    ?>
</main>

<?php include 'footer.html'; ?>

</body>
</html>