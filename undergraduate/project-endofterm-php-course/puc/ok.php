<?php
header('Content-Type: text/html; charset=utf-8');

if (!empty($_POST)) {
    $fields = array('name', 'gender', 'birthday', 'address', 'telephone', 'qq','head');
    $save_data = array();

    foreach ($fields as $k => $v) {

        $save_data[$v] = isset($_POST[$v]) ? $_POST[$v] : "";
    }

    foreach ($save_data as $key => $value) {
        echo $key . ":" . htmlspecialchars($value);
        echo "<br>";
    }
}
?>