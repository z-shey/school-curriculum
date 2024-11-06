<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Study Room Reservation System - v1.0.0</title>
    <link rel="stylesheet" href="./assets/css/reset.css">
    <link rel="stylesheet" href="./assets/css/main.css">
    <script src="./assets/js/main.js"></script>
</head>
<body>

<?php include 'header.html'; ?>

<main>
    <section class="intro">
        <h2>Study Room</h2>
        <p>Study Room Reservation System</p>
    </section>

    <section class="study-room-card-section">
        <?php
        for ($i = 0; $i < 10; $i++) {
            $roomId = "room_" . $i;
            echo '
        <div class="study-room-card">
            <div class="header">
                <h2 class="name">Sunshine Room</h2>
                <span class="status">Normal</span>
            </div>
            <div class="body">
                <p class="location">
                <span>Location</span> 
                Library 3rd floor
                </p>
                <p class="time">
                <span>Opening hours</span> 
                Monday to Friday 08:00-22:00</p>
                <p class="description">The Sunshine room provides a spacious and bright study space, suitable for individual or group study.</p>
            </div>
            <div class="footer">
                <span>0/40</span>
               <div class="button-group">
                    <a class="detail-button" onclick="goToDetail(\'' . $roomId . '\')">Detail</a>
                    <a class="reserve-button">Reserve</a>
                </div>
            </div>
        </div>
        ';
        }
        ?>
    </section>
</main>

<?php include 'footer.html'; ?>

</body>
</html>