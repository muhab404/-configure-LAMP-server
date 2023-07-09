<!DOCTYPE html>
<html>
<head>
    <title>Hello World!</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            padding: 40px;
            font-family: Arial, sans-serif;
        }
        h1 {
            color: #007bff;
            margin-bottom: 20px;
        }
        .visitor-info {
            margin-top: 40px;
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Hello World!</h1>
        <div class="visitor-info">
            <?php
            $conn = mysqli_connect('localhost', 'myuser', 'mypassword', 'mydatabase');
            if ($conn) {
                $ip = $_SERVER['REMOTE_ADDR'];
                $time = date('Y-m-d H:i:s');
                echo "<p>Visitor's IP address: $ip</p>";
                echo "<p>Current time: $time</p>";
                mysqli_close($conn);
            } else {
                echo "<p>Failed to connect to the database.</p>";
            }
            ?>
        </div>
    </div>
</body>
</html>
