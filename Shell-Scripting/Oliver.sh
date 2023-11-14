#!/bin/bash

clear
echo "Hello Ma'am/Sir, Can I take your order?"
read -p "Enter your order: " order
echo $order>>Francis.txt
echo "Your order is $order is added on queueing"
echo ------------------
cat Francis.txt
echo ------------------