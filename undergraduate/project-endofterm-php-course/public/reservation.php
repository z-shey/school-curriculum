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
        <h2>Reservation</h2>
        <p>Study Room Reservation System</p>
    </section>

    <section class="reservation-list-section">
        <?php
        for ($i = 0; $i < 10; $i++) {
            $roomId = "room_" . $i;
            echo '
        <div class="reservation-list">
            <div>number</div>
            <div>Room</div>
            <div>Position</div>
            <div>Time</div>
            <div>Reserve Status</div>
            <div>Operation</div>
        </div>
        ';
        }
        ?>
    </section>
</main>

<?php include 'footer.html'; ?>

</body>
</html>