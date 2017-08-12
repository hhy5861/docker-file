<?php
class getIP
{   

    function clientIP()
    {   
        $cIP = getenv('REMOTE_ADDR');   
        $cIP1 = getenv('HTTP_X_FORWARDED_FOR');   
        $cIP2 = getenv('HTTP_CLIENT_IP');   
        $cIP1 ? $cIP = $cIP1 : null;   
        $cIP2 ? $cIP = $cIP2 : null;   
        return $cIP;   
    }

    function get_server_ip()
    {
        $server_ip = '';
        if(isset($_SERVER))
        {
            if(isset($_SERVER['SERVER_ADDR']) && $_SERVER['SERVER_ADDR'])
            {
                $server_ip=$_SERVER['SERVER_ADDR'];
            }
            else
            {
                $server_ip=$_SERVER['LOCAL_ADDR'];
            }
        }
        else
        {
            $server_ip = getenv('SERVER_ADDR');
        }

        return $server_ip;
    }
}   
    
$getIP    = new getIP();   
$clientIp = $getIP->clientIP();   
$serverIp = $getIP->get_server_ip();
    
echo 'Client IP is '.$clientIp.'<br />';   
echo 'Server IP is '.$serverIp.'<br />';