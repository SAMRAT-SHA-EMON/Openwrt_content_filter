<?php
// Handle form submission
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['domains'])) {
    // Sanitize input (allow only domains and whitespace)
    $domains = preg_replace('/[^a-zA-Z0-9.\-\n]/', '', $_POST['domains']);
    file_put_contents('/etc/custom_filter/blocklist.txt', $domains);
    
    // Update DNS rules
    shell_exec('/usr/bin/custom_filter');
    header("Refresh:0"); // Reload the page
}

// Read blocklist
$blocklist = file_get_contents('/etc/custom_filter/blocklist.txt');
?>
<!DOCTYPE html>
<html>
<head>
    <title>OpenWrt Blocklist Manager</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container">
        <h1>Block/Unblock Websites</h1>
        <form method="post">
            <textarea name="domains" placeholder="Enter domains (one per line)..."><?= htmlspecialchars($blocklist) ?></textarea>
            <button type="submit">Save Changes</button>
        </form>
    </div>
</body>
</html>