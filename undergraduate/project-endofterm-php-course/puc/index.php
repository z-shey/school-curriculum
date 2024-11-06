<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>请输入您的信息进行注册</title>
    <link href="styledform.css" type="text/css" rel="stylesheet">
</head>
<body>
<form name="form1" action="char4_1ok.php" method="post">
    <div class="tableRow">
        <p></p>
        <p class="heading">请输入您的个人信息</p>
    </div>
    <div class="tableRow">
        <p>姓名：</p>
        <p><input type="text" name="name"></p>
    </div>
    <div class="tableRow">
        <p>性别：</p>
        <p><input type="radio" name="gender" value="男" checked>男
            <input type="radio" name="gender" value="女">女
        </p>
    </div>
    <div class="tableRow">
        <p>出生年月：</p>
        <p><input type="date" name="birthday"> </p>
    </div>
    <div class="tableRow">
        <p>地址：</p>
        <p><input type="text" name="address"></p>
    </div>
    <div class="tableRow">
        <p>电话：</p>
        <p><input type="text" name="telephone"></p>
    </div>
    <div class="tableRow">
        <p>QQ:</p>
        <p><input type="text" name="qq"></p>
    </div>
    <div class="tableRow label">
        <p>请选择头像:</p>
        <p>
            <?php
            for ($i = 1; $i < 20; $i++) {
                $headfile = "head" . $i . ".jpg";
                echo "<img src='headimg/" . $headfile . "' width='50' height='50' /> <input type='radio' name='head' value='" . $headfile . "' />";
                if ($i % 5 == 0) {
                    echo "<br />";
                }
            }
            ?>
        </p>
    </div>
    <div class="tableRow">
        <p></p>
        <p><input type="submit" value="提交">
            <input type="reset" value="重置">
        </p>
    </div>
</form>
</body>
</html>