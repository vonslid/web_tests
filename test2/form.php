<?php

function fix_html($str)
{
    $str = strip_tags($str);
    $str = htmlentities($str);
    $str = nl2br($str);
    $str = stripslashes($str);
    return $str;
}

if (isset($_POST['name']) and !empty($_POST['name']))
{
    $name = fix_html($_POST['name']);
    echo " - Имя: " . $name . "<br>";
}
else
    echo " - Имя не указано.<br>";
echo "<br>";


if (isset($_POST['email']) and !empty($_POST['email']))
{
    $email = fix_html($_POST['email']);
    echo " - Email: " . $email . "<br>";
    if(preg_match("|^([a-z0-9_\.\-]{1,20})@([a-z0-9\.\-]{1,20})\.([a-z]{2,4})|is", strtolower($email)))
        echo "Email корректен.<br>";
    else
        echo "Email не корректен.<br>";
}else
    echo " - Email не указан.<br>";
echo "<br>";


if (isset($_POST['phone']) and !empty($_POST['phone']))
{
    $phone = fix_html($_POST['phone']);
    echo " - Телефон: " . $phone . "<br>";
    if(preg_match("/^(\+7|8)\d{10}$/is", strtolower($phone)))
        echo "Телефон корректен.<br>";
    else
        echo "Телефон не корректен.<br>";
}
else
    echo " - Телефон не указан.<br>";
echo "<br>";


if (isset($_POST['comment']) and !empty($_POST['comment']))
{
    $comment = fix_html($_POST['comment']);
    echo " - Сообщение: " . $comment . "<br>";
}
else
    echo " - Сообщение пусто.<br>";
echo "<br>";


if (isset($_FILES['file']['name']) and is_uploaded_file($_FILES['file']['tmp_name']))
{
    $dest = getcwd() . "/" . basename($_FILES['file']['name']);
    if(move_uploaded_file($_FILES['file']['tmp_name'], $dest)) echo " - Файл успешно загружен в $dest<br>";
    else
    {
        echo " - Не удалось переместить файл в $dest<br>";
        echo "Код ошибки: " . $_FILES['file']['error'] . "<br>";
    }
}
else
{
    echo " - Файл не загружен.<br>";
    echo "Код ошибки: " . $_FILES['file']['error'] . "<br>";
}

echo "<br><br><br><br><br>";

?>