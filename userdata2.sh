#!/bin/bash
yum update -y

# Install Apache web server
yum install -y httpd

# Start and enable Apache
systemctl start httpd
systemctl enable httpd

# Create Hello World page
cat <<EOF > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
  <title>Hello World</title>
</head>
<body style="text-align:center; margin-top:100px;">
  <h1>Hello from Ameer</h1>
  <p>Deployed using Terraform User Data</p>
</body>
</html>
EOF
