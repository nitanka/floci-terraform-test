#!/bin/bash
set -euo pipefail

yum update -y
yum install -y httpd

systemctl enable httpd
systemctl start httpd

echo "Hello from ${region}" > /var/www/html/index.html
