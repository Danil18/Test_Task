<?php
include "Db.php";
include "functions/access_check.php";

function route($method, $urlData, $formData) {

    if ($method === 'GET' && count($urlData) === 1) {
      if(is_numeric($urlData[0])){

            $readerID = $urlData[0];

            $db = Db::getConnection();

            $sql = 'SELECT books.id, title, author FROM reader '
            .'INNER JOIN give_books ON reader.id = give_books.id_reader '
            .'INNER JOIN books ON books.id = give_books.id_books '
            .'WHERE status = "reading" and reader.id = :id';

            $result = $db->prepare($sql);
            $result->bindParam(':id', $readerID, PDO::PARAM_INT);
            $result->execute();

            $booksList = array();
            $i = 0;
            while ($row = $result->fetch()) {
              $booksList[$i]['id'] = $row['id'];
              $booksList[$i]['title'] = $row['title'];
              $booksList[$i]['author'] = $row['author'];
              $i++;
            }

            if (!$booksList) {
              http_response_code(404);
              $report = [
                "status" => false,
                "message" => "Data not found"
              ];
              echo json_encode($report);
            }
            else {
              http_response_code(200);
              echo json_encode($booksList);
            }

            return;
        }
    }


    if ($method === 'POST' && count($urlData) === 1 && count($formData) === 2) {
        if(is_numeric($urlData[0]) && is_numeric($formData['bookID'])){

              $readerID = $urlData[0];
              $bookID = $formData['bookID'];

              $db = Db::getConnection();

              check_access($db, md5($formData['access_key']));

              $sql = 'INSERT INTO give_books (id_reader, id_books, status) '
              .'VALUES (:readerID, :bookID, "reading")';

              $result = $db->prepare($sql);
              $result->bindParam(':readerID', $readerID, PDO::PARAM_INT);
              $result->bindParam(':bookID', $bookID, PDO::PARAM_INT);
              $result->execute();

              $id = $db->lastInsertId();

              if ($id == 0) {
                http_response_code(400);
                $report = [
                  "status" => false,
                  "message" => "adding failed"
                ];
                echo json_encode($report);
              }
              else {
                http_response_code(201);
                $report = [
                  "status" => true,
                  "add_post_id" => $db->lastInsertId()
                ];
                echo json_encode($report);
              }

              return;
          }
    }


    if ($method === 'PATCH' && count($urlData) === 1 && count($formData) === 2) {
        if(is_numeric($urlData[0]) && is_numeric($formData['bookID'])){

              $readerID = $urlData[0];
              $bookID = $formData['bookID'];

              $db = Db::getConnection();

              check_access($db, md5($formData['access_key']));

              $sql = 'UPDATE give_books SET status = "returned" WHERE '
              .'id_books = :bookID AND id_reader = :readerID AND status = "reading"';

              $result = $db->prepare($sql);
              $result->bindParam(':readerID', $readerID, PDO::PARAM_INT);
              $result->bindParam(':bookID', $bookID, PDO::PARAM_INT);
              $result->execute();

              if($result->rowCount() > 0){
                http_response_code(200);
                $report = [
                  "status" => true,
                  "message" => "status updated"
                ];
                echo json_encode($report);
              }
              else{
                http_response_code(400);
                $report = [
                  "status" => false,
                  "message" => "error status updated"
                ];
                echo json_encode($report);
              }


              return;
          }
    }

    http_response_code(400);
    $report = [
      "status" => false,
      "message" => "Bad Request"
    ];
    echo json_encode($report);
}
?>
