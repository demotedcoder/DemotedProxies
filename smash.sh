#!/bin/bash

echo "
   _               _         _                 _
 _| |___ _____ ___| |_ ___ _| |___ ___ ___ _ _|_|___ ___
| . | -_|     | . |  _| -_| . | . |  _| . |_'_| | -_|_ -|
|___|___|_|_|_|___|_| |___|___|  _|_| |___|_,_|_|___|___|
                              |_|
                        by demotedc0der
"

bold=$(tput bold)
normal=$(tput sgr0)

function Scrape() {
    echo "Enter the type of Proxies you want to Scrape: HTTP, SOCKS4, SOCKS5"
    read type
    if [[ ${type^^} == "HTTP" ]]
        then
            if [ ! -f  ./Sources/HTTP.txt ]
                then
                    echo "File (HTTP.txt) does not exist in Source Folder"
            else
                    echo -e "\nScraping Started...\n"
                     while read -r line
                        do
                           curl -sS "$line" >> HTTPproxies.txt
                        done < ./Sources/HTTP.txt
                    cat ./HTTPproxies.txt | sort -u > HTTPprx.txt
                    rm ./HTTPproxies.txt
                    echo -e "${bold}[!] DONE [!] \nCheck out HTTPprx.txt file${normal}."
            fi
    elif [[ ${type^^} == "SOCKS4" ]]
        then
            if [ ! -f  ./Sources/SOCKS4.txt ]
                then
                    echo "File (SOCKS4.txt) does not exist in Source Folder"
            else
                    echo -e "\nScraping Started...\n"
                     while read -r line
                        do
                           curl -sS "$line" >> SOCKS4proxies.txt
                        done < ./Sources/SOCKS4.txt
                    cat ./SOCKS4proxies.txt | sort -u > SOCKS4prx.txt
                    rm ./SOCKS4proxies.txt
                    echo -e "${bold}[!] DONE [!] \nCheck out SOCKS4prx.txt file${normal}."
            fi
    elif [[ ${type^^} == "SOCKS5" ]]
        then
             if [ ! -f  ./Sources/SOCKS5.txt ]
                then
                    echo "File (SOCKS5.txt) does not exist in Source Folder"
            else
                    echo -e "\nScraping Started...\n"
                     while read -r line
                        do
                           curl -sS "$line" >> SOCKS5proxies.txt
                        done < ./Sources/SOCKS5.txt
                    cat ./SOCKS5proxies.txt | sort -u > SOCKS5prx.txt
                    rm ./SOCKS5proxies.txt
                    echo -e "${bold}[!] DONE [!] \nCheck out SOCKS5prx.txt file${normal}."
            fi
    else
            echo "Please the input should be, HTTP, SOCKS4 or SOCKS5"
            Scrape
    fi
}

function Checker() {
  echo "Enter the type of Proxies you want to Check: HTTP, SOCKS4, SOCKS5"
  read type
  REQUIRED_PKG="nmap"
  PKG_OK=$(dpkg-query -W --showformat='${Status}\n' $REQUIRED_PKG | grep "install ok installed")
  echo -e "\nChecking for $REQUIRED_PKG: $PKG_OK"
    if [ "" = "$PKG_OK" ]; then
    echo "The $REQUIRED_PKG should be installed. Setting up $REQUIRED_PKG."
    sudo apt-get --yes install $REQUIRED_PKG
    fi

    if [[ ${type^^} == "HTTP" ]]
        then
            if [ ! -f  ./HTTPprx.txt ]
                then
                    echo -e "${bold}\nFile (HTTPprx.txt) does not exist in the Current Directory\nFirst you need to scrape!${normal}"
                    bash smash.sh
            else
                    if [ ! -d ./Alive ];then
                        mkdir ./Alive
                    fi
                    echo -e "\nChecking Started...\nIt may take a while, To verify that the Scraping Process is in execution you can check ${bold}./Alive/HTTPprxAlive.txt${normal} file increasing its size."
                    while read -r line
                        do
                                ip=`echo $line | cut -d : -f 1`
                                port=`echo $line | cut -d : -f 2`
                                result=$(nmap -T5 $ip -p $port)
                                if [[ $result == *"opened"* ]] || [[ $result == *"filtered"* ]]
                                    then
                                        echo $line >> ./Alive/HTTPprxAlive.txt
                                fi
                    done < ./HTTPprx.txt
                    cat ./Alive/HTTPprxAlive.txt | sort -u > ./Alive/HTTPworking.txt
                    rm ./Alive/HTTPprxAlive.txt
                    echo -e "${bold}[!] DONE [!] \nCheck out ./Alive/HTTPworking.txt file${normal}."
            fi
    elif [[ ${type^^} == "SOCKS4" ]]
        then
            if [ ! -f  ./SOCKS4prx.txt ]
                    then
                        echo -e "${bold}\nFile (SOCKS4prx.txt) does not exist in the Current Directory\nFirst you need to scrape!${normal}"
                        bash smash.sh
                else
                        if [ ! -d ./Alive ];then
                            mkdir ./Alive
                        fi
                        echo -e "\nChecking Started...\nIt may take a while, To verify that the Scraping Process is in execution you can check ${bold}./Alive/SOCKS4prxAlive.txt${normal} file increasing its size."
                        while read -r line
                            do
                                    ip=`echo $line | cut -d : -f 1`
                                    port=`echo $line | cut -d : -f 2`
                                    result=$(nmap -T5 $ip -p $port)
                                    if [[ $result == *"opened"* ]] || [[ $result == *"filtered"* ]]
                                        then
                                            echo $line >> ./Alive/SOCKS4prxAlive.txt
                                    fi
                        done < ./SOCKS4prx.txt
                        cat ./Alive/SOCKS4prxAlive.txt | sort -u > ./Alive/SOCKS4working.txt
                        rm ./Alive/SOCKS4prxAlive.txt
                        echo -e "${bold}[!] DONE [!] \nCheck out ./Alive/SOCKS4working.txt file${normal}."
                fi
    elif [[ ${type^^} == "SOCKS5" ]]
        then
            if [ ! -f  ./SOCKS5prx.txt ]
                    then
                        echo -e "${bold}\nFile (SOCKS5prx.txt) does not exist in the Current Directory\nFirst you need to scrape!${normal}"
                        bash smash.sh
                else
                        if [ ! -d ./Alive ];then
                            mkdir ./Alive
                        fi
                        echo -e "\nChecking Started...\nIt may take a while, To verify that the Scraping Process is in execution you can check ${bold}./Alive/SOCKS5prxAlive.txt${normal} file increasing its size."
                        while read -r line
                            do
                                    ip=`echo $line | cut -d : -f 1`
                                    port=`echo $line | cut -d : -f 2`
                                    result=$(nmap -T5 $ip -p $port)
                                    if [[ $result == *"opened"* ]] || [[ $result == *"filtered"* ]]
                                        then
                                            echo $line >> ./Alive/SOCKS5prxAlive.txt
                                    fi
                        done < ./SOCKS5prx.txt
                        cat ./Alive/SOCKS5prxAlive.txt | sort -u > ./Alive/SOCKS5working.txt
                        rm ./Alive/SOCKS5prxAlive.txt
                        echo -e "${bold}[!] DONE [!] \nCheck out ./Alive/SOCKS5working.txt file${normal}."
                fi
    else
            echo "Please the input should be, HTTP, SOCKS4 or SOCKS5"
            Scrape
    fi
}

echo -e "Select an option\n a) Scrape\n b) Checker\n c) Exit"
read option

case $option in
    a)
        Scrape
        ;;
    b)
        Checker
        ;;
    c)
        exit
        ;;
    *)
        echo -e "${bold}\n\n[!] Please type a valid input [!]${normal}"
        bash smash.sh
        ;;
esac