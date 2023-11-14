#!/bin/sh

a=0
while [ $a -lt 2 ]; do
echo "================================================="

echo "Login and Register"
echo ">>> 1) REGISTER"
echo ">>> 2) LOGIN"
echo ">>> 3) EXIT"

echo "================================================="
read -p "Enter a number: " input

Register() {
	clear
	echo "[[ Registration ]]"
	read -p "Input your username: " name
	read -sp "Input your password: " pass
	echo " "
	clear
	echo " // Press 1 for ADMIN // "
	echo " // Press 2 for USER // "
	read -p "Press 1 or 2: " AU
	
	if grep -q "$name" DB.txt; then
		echo "Already Exists"
	else
		echo "Successfully Registered"
	fi
	echo $name:$pass:$AU>>DB.txt
}

Login() {
	clear
	d=0
	while [ $d -lt 2 ]; do
		echo "[[ LOGIN ]]"
	
		read -p "Enter your username: " uname
		read -sp "Enter your password: " pass
	
		clear
	
		echo "// Press 1 for ADMIN //"
		echo "// Press 2 for USER //"
		read -p "Enter a choice: " AU
	
		echo " "
	
		if grep -q "$uname:$pass:$AU" DB.txt; then
			echo ">>>>> SUCCESSFULLY LOGGED IN <<<<<"
			echo " "
			break
		else
			echo ">>>>> INVALID USERNAME OR PASSWORD <<<<<"
			echo " "
			continue
			clear
		fi
	done
	
	if [ $AU -eq 1 ]; then
		b=0
		while [ $b -lt 2 ]; do
		echo " "
		echo "[[ Hello, Administrator: $uname ]]"
		echo ">> 1) Display User Data"
		echo ">> 2) Edit USER Data Information"
		echo ">> 3) Delete USER Data Information"
		echo ">> 4) Exit"
		
		echo "========================================="
		echo "     [[ ENTER YOUR CHOICE ]]"
		echo "========================================="
		read -p "Select a number to process: " choice
		
		if [ $choice -eq 1 ]; then
			clear
			cat DB.txt
		elif [ $choice -eq 2 ]; then
			read -p "Enter your old username: " oldname
			read -p "Enter your old password: " oldpass
			read -p "Enter your permission number: " oldAU
			if grep -q "$oldname:$oldpass:$oldAU" DB.txt; then
				read -p "Enter your new username: " newname
				read -p "Enter your new password: " newpass
				read -p "Enter your permission number: " newAU
				
				sed -i "s/$oldname:$oldpass:$oldAU/$newname:$newpass:$newAU/;" DB.txt
			else
				echo " [[ ERROR ]]"
			fi
		elif [ $choice -eq 3 ]; then
			read -p "Enter your username: " dname
			read -p "Enter your password: " dpass
			read -p "Enter your permission number: " dAU
			if grep -q "$dname:$dpass:$dAU" DB.txt; then
				sed -i "/$dname:$dpass:$dAU/d" DB.txt
			else
				echo "[[ ERROR ]]"
			fi
		elif [ $choice -eq 4 ]; then
			exit
		else
			echo "out of bounds"
		fi
		done
	elif [ $AU -eq 2 ]; then
		c=0
		while [ $c -lt 2 ]; do
		echo "=================================="
		echo "       [[ WELCOME, $uname ]]"
		echo "=================================="
		echo ">> 1) Display Car Information"
		echo ">> 2) Add information"
		echo ">> 3) Edit or Delete Car Information"
		echo "=================================="
		read -p "Enter a choice: " c1
		
		if [ $c1 -eq 1 ]; then
			cat Info.txt
		elif [ $c1 -eq 2 ]; then
			clear
			echo " "
			echo " ">>Info.txt
			read -p "Number: " n
			echo "Number: "$n>>Info.txt
			read -p "Car model: " car
			echo "Car model: "$car>>Info.txt
			read -p "Price: " price
			echo "Price: "$price>>Info.txt
			read -p "Code number: " code
			echo "Code number: "$code>>Info.txt
		elif [ $c1 -eq 3 ]; then
			nano Info.txt
		else
			exit
		fi
		done
	else
		exit
	fi		
}

if [ $input -eq "1" ]; then
	Register
elif [ $input -eq "2" ]; then
	Login
elif [ $input -eq "3" ]; then
	echo " "
	echo ">>>[[SUCCESSFULLY TERMINATED]]<<<"
	echo " "
	exit
else
	echo "Out of bounds"
fi

done
