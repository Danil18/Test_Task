<?php
  function check_access($db, $key){

    $sql = 'SELECT count(id) FROM access_keys WHERE a_key = :key';
    $result = $db->prepare($sql);
    $result->bindParam(':key', $key, PDO::PARAM_INT);
    $result->execute();

    if (!($result->fetch()[0] > 0)){
      http_response_code(423);
      $report = [
        "status" => false,
        "message" => "access_denied"
      ];
      exit(json_encode($report));
    }
  }

?>
