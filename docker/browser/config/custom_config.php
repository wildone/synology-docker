<?php

$config = array();

error_log("HTTP_PROXY: " . getenv('HTTP_PROXY'), 0);

$config['curl'] = array(
    CURLOPT_PROXY => getenv('HTTP_PROXY'),
    CURLOPT_CONNECTTIMEOUT => 5
);

return $config;
