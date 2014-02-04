<?php

	// Note: have change php.ini to be able to upload larger files
	// upload_max_filesize = 50M
	// post_max_size = 192M
	
	require_once "../StyleJS/json/JSON.php";
	$json = new Services_JSON();
	
	//expecting waveform-compare is set up
 	$output = array();
    $command = "cd /tmp && waveform-compare " . escapeshellarg($_FILES['inputWaveFile1']['tmp_name']) . " " . escapeshellarg($_FILES['inputWaveFile2']['tmp_name']);
   	exec($command, $output);
  			 
 	$formatted = "";
   	foreach ( $output as $line ) {
   		// append each line, but make it HTML-friendly first
   		$formatted .= htmlspecialchars ( $line ) . "<br>";
   	}

 	$result = $json->encode("<br>Processed<br>" . $formatted);
 	print($result);
				
?>