#!/bin/bash

systemctl restart mysql
systemctl restart web-golang
systemctl restart nginx 

