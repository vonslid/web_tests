#!/usr/bin/env php
<?php

echo "\n -- Parentheses counter 0.1 --";
echo "\n --       vonslid 2018      --\n\n";

if ($argc < 2 || empty($argv[1])) {
    die("ERROR: Pass not an empty string to arguments!\n");
}

echo "INPUT: " . $argv[1] . "\n";

function Parentheses($brackets)
{
    $opened = 0;
    $at_least_one = FALSE;

    for ($i = 0; $i < strlen($brackets); $i++)
    {
        if ($brackets[$i] === '(') {
            $at_least_one = TRUE;
            $opened++;
        } 
        elseif ($brackets[$i] === ')') {
            $at_least_one = TRUE;
            $opened--;
        }

        if ($opened < 0) break;
    }

    return $at_least_one and $opened == 0;
}

echo Parentheses($argv[1]) ? "OK: Parentheses match!\n\n" : "FAIL: Parentheses do not match or there are not any!\n\n";
