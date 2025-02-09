<!DOCTYPE html>
<html>
<head>
    <title>Block/Unblock Websites</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container">
        <h1>🔒 OpenWrt Blocklist Manager</h1>
        <form method="post">
            <textarea name="domains" placeholder="Enter domains (one per line)..."><?php
                echo file_get_contents('/etc/custom_filter/blocklist.txt');
            ?></textarea>
            <button type="submit">💾 Save Changes</button>
        </form>
        <?php
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $domains = $_POST['domains'];
            file_put_contents('/etc/custom_filter/blocklist.txt', $domains);
            shell_exec('/usr/bin/custom_filter');
            echo '<div class="success">✅ Blocklist updated!</div>';
        }
        ?>
    </div>
</body>
</html>
