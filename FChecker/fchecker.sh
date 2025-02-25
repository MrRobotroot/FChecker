#!/bin/bash

# Color codes
BrightRed="\e[1;91m"
BrightGreen="\e[1;92m"
BrightYellow="\e[1;93m"
BrightWhite="\e[1;97m"
Cyan="\e[1;96m"

clear

# Function to install dependencies
install_dependencies() {
    echo -e "${BrightWhite}[${BrightYellow}*${BrightWhite}] ${BrightYellow}Bağımlılıkları denetleme ve yükleme..."

    # For Termux
    if [ -d "/data/data/com.termux/files/usr" ]; then
        echo -e "${BrightWhite}[${BrightGreen}*${BrightWhite}] ${BrightGreen}Algılanan Termux ortamı"
        
        # Install curl if missing
        if ! command -v curl &> /dev/null; then
            echo -e "${BrightWhite}[${BrightRed}!${BrightWhite}] ${BrightRed}curl bulunamadı, yükleniyor..."
            pkg install curl -y
        fi

        # Install grep if missing
        if ! command -v grep &> /dev/null; then
            echo -e "${BrightWhite}[${BrightRed}!${BrightWhite}] ${BrightRed}grep bulunamadı, yükleniyor..."
            pkg install grep -y
        fi

        # Install wget if missing
        if ! command -v wget &> /dev/null; then
            echo -e "${BrightWhite}[${BrightRed}!${BrightWhite}] ${BrightRed}wget bulunamadı, yükleniyor..."
            pkg install wget -y
        fi

    else
        # For Linux environments
        echo -e "${BrightWhite}[${BrightGreen}*${BrightWhite}] ${BrightGreen}Algılanan Linux ortamı"

        # Check for curl and install if missing
        if ! command -v curl &> /dev/null; then
            echo -e "${BrightWhite}[${BrightRed}!${BrightWhite}] ${BrightRed}curl bulunamadı, yükleniyor..."
            if [ -x "$(command -v apt-get)" ]; then
                sudo apt-get install curl -y
            elif [ -x "$(command -v yum)" ]; then
                sudo yum install curl -y
            else
                echo -e "${BrightWhite}[${BrightRed}!${BrightWhite}] ${BrightRed}Paket yöneticisi bulunamadı. Lütfen curl'u manuel olarak kurun."
                exit 1
            fi
        fi

        # Check for wget and install if missing
        if ! command -v wget &> /dev/null; then
            echo -e "${BrightWhite}[${BrightRed}!${BrightWhite}] ${BrightRed}wget bulunamadı, yükleniyor..."
            if [ -x "$(command -v apt-get)" ]; then
                sudo apt-get install wget -y
            elif [ -x "$(command -v yum)" ]; then
                sudo yum install wget -y
            else
                echo -e "${BrightWhite}[${BrightRed}!${BrightWhite}] ${BrightRed}Paket yöneticisi bulunamadı. Lütfen wget'i elle kurun.."
                exit 1
            fi
        fi

        # Check for grep and install if missing
        if ! command -v grep &> /dev/null; then
            echo -e "${BrightWhite}[${BrightRed}!${BrightWhite}] ${BrightRed}grep not bulunamadı, yükleniyor..."
            if [ -x "$(command -v apt-get)" ]; then
                sudo apt-get install grep -y
            elif [ -x "$(command -v yum)" ]; then
                sudo yum install grep -y
            else
                echo -e "${BrightWhite}[${BrightRed}!${BrightWhite}] ${BrightRed}Paket yöneticisi bulunamadı. Lütfen grep'i manuel olarak kurun."
                exit 1
            fi
        fi
    fi
}

# Display banner
display_banner() {
    clear

    echo -e "${BrightGreen}"
    cat << "EOF"
     
  ______ _____ _               _             
 |  ____/ ____| |             | |            
 | |__ | |    | |__   ___  ___| | _____ _ __ 
 |  __|| |    | '_ \ / _ \/ __| |/ / _ \ '__|
 | |   | |____| | | |  __/ (__|   <  __/ |   
 |_|    \_____|_| |_|\___|\___|_|\_\___|_|   
                                             
                                          
                        Kurucu:MR-ROBOT       
                                                                                                                      
EOF

    echo -e "${Cyan}* E-posta, Telefon Numarası ve Bağlantı Kazıyıcı Aracı. \033[0m"
    echo -e "${BrightYellow}* Copyright © Mr-Robot, 2025\033[0m"
    echo -e "${BrightYellow}* GitHub: https://github.com/MrRobotroot\033[0m\n"
}

# Main function to handle input and validations
main_function() {
    sleep 0.5
    read -p $'\e[1;97m[\e[1;92m*\e[1;97m]\e[1;92m Başlamak için URL girin : \e[1;97m' target_url
    url_pattern='(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]'
    if [[ $target_url =~ $url_pattern ]]; then 
        read -p $'\e[1;97m[\e[1;92m*\e[1;97m]\e[1;92m Web sitesinden e-postaları bulmak istermisiniz? (y/n) : \e[1;97m' email_option
        read -p $'\e[1;97m[\e[1;92m*\e[1;97m]\e[1;92m  Web sitesinden telefon numaralarını bulmak istermisiniz? (y/n) : \e[1;97m' phone_option
        read -p $'\e[1;97m[\e[1;92m*\e[1;97m]\e[1;92m Web sitesinden sosyal medya bağlantılarını ve diğer bağlantıları bulmak istermisiniz? (y/n) : \e[1;97m' social_media_option
        if [[ "$email_option" =~ ^[Yy]$ || "$phone_option" =~ ^[Yy]$ || "$social_media_option" =~ ^[Yy]$ ]]; then
            echo -e "${BrightWhite}[${BrightRed}!${BrightWhite}] ${BrightRed}Bilgi toplaması başlıyor.."
            scrape_function
        fi
        sleep 0.4
        echo -e "${BrightWhite}[${BrightRed}!${BrightWhite}] ${BrightRed}Çıkılıyor....\n"
        exit
    else
        echo -e "${BrightWhite}[${BrightRed}!${BrightWhite}] ${BrightRed}Geçersiz URL. Lütfen tekrar deneyin."
        main_function
    fi
}

# Scrape data based on user inputs
scrape_function() {
    curl -s $target_url > temp_file.txt
    [[ "$email_option" =~ ^[Yy]$ ]] && email_scrape
    [[ "$phone_option" =~ ^[Yy]$ ]] && phone_scrape
    [[ "$social_media_option" =~ ^[Yy]$ ]] && social_media_scrape
    rm temp_file.txt
    if [[ -f "email_output.txt" || -f "phone_output.txt" || -f "social_media_output.txt" ]]; then
        sleep 0.4
        read -p $'\e[1;97m[\e[1;92m*\e[1;97m]\e[1;92m Çıktıyı kaydetmek istiyor musunuz? (y/n) : \e[1;97m' save_option
        [[ "$save_option" =~ ^[Yy]$ ]] && save_data
    fi
    sleep 0.4
    echo -e "${BrightWhite}[${BrightRed}!${BrightWhite}] ${BrightRed}Çıkılıyor....\n"
    rm email_output.txt phone_output.txt social_media_output.txt 2> /dev/null 
    exit
}

# Email scraping function
email_scrape() {
    grep -i -o '[A-Z0-9._%+-]\+@[A-Z0-9.-]\+\.[A-Z]\{2,4\}' temp_file.txt | sort -u > email_output.txt
    if [[ -s email_output.txt ]]; then
        echo -e "${BrightWhite}[${BrightYellow}*$BrightWhite] ${BrightYellow}E-postalar başarıyla ayıklandı:${BrightWhite}"
        cat email_output.txt
    else 
        echo -e "${BrightWhite}[${BrightRed}!${BrightWhite}] ${BrightRed}E-posta bulunamadı."
        rm email_output.txt
    fi
}

# Phone scraping function
phone_scrape() {
    grep -o '\([0-9]\{3\}-[0-9]\{3\}-[0-9]\{4\}\)\|\(([0-9]\{3\})[0-9]\{3\}-[0-9]\{4\}\)\|\([0-9]\{10\}\)\|\([0-9]\{3\}\s[0-9]\{3\}\s[0-9]\{4\}\)' temp_file.txt | sort -u > phone_output.txt
    if [[ -s phone_output.txt ]]; then
        echo -e "${BrightWhite}[${BrightYellow}*$BrightWhite] ${BrightYellow}Telefon numaraları başarıyla çıkarıldı:${BrightWhite}"
        cat phone_output.txt
    else 
        echo -e "${BrightWhite}[${BrightRed}!${BrightWhite}] ${BrightRed}Telefon numarası bulunamadı."
        rm phone_output.txt
    fi
}

# Social media links and other links scraping function
social_media_scrape() {
    grep -Eo 'https?://([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}/[^" ]+' temp_file.txt | sort -u > social_media_output.txt
    if [[ -s social_media_output.txt ]]; then
        echo -e "${BrightWhite}[${BrightYellow}*$BrightWhite] ${BrightYellow}Sosyal medya bağlantıları ve diğer bağlantılar başarıyla çıkarıldı:${BrightWhite}"
        cat social_media_output.txt
    else 
        echo -e "${BrightWhite}[${BrightRed}!${BrightWhite}] ${BrightRed}Sosyal medya bağlantısı veya başka bir bağlantı bulunamadı."
        rm social_media_output.txt
    fi
}

# Save output to a directory
save_data() {
    sleep 0.4
    read -p $'\e[1;97m[\e[1;92m*\e[1;97m]\e[1;92m Enter folder name : \e[1;97m' folder_name
    if [[ -d "$folder_name" ]]; then
        echo -e "${BrightWhite}[${BrightRed}!${BrightWhite}] ${BrightRed}Klasör zaten var."
        save_data
    fi
    mkdir $folder_name
    mv email_output.txt $folder_name 2> /dev/null
    mv phone_output.txt $folder_name 2> /dev/null
    mv social_media_output.txt $folder_name 2> /dev/null
    sleep 0.3
    echo -e "${BrightWhite}[${BrightGreen}*$BrightWhite] ${BrightYellow}Çıktı başarıyla buraya kaydedildi.${folder_name}${BrightWhite}"
    sleep 0.4
    echo -e "${BrightWhite}[${BrightRed}!${BrightWhite}] ${BrightRed}Çıkılıyor....\n"
    exit
}

# Internet connection check
check_connection() {
    sleep 0.5
    echo -e "${BrightWhite}[${BrightRed}!${BrightWhite}] ${BrightRed}İnternet bağlantısı kontrol ediliyor..."
    wget -q --spider http://google.com
    if [[ $? -eq 0 ]]; then
        echo -e "${BrightWhite}[${BrightYellow}*${BrightWhite}] ${BrightYellow}İnternete bağlısınız."
    else
        sleep 0.5
        echo -e "${BrightWhite}[${BrightRed}!${BrightWhite}] ${BrightRed}İnternet bağlantısı algılanmadı. Sonra tekrar dene.."
        exit 
    fi
}

# Main execution
install_dependencies
display_banner
check_connection
main_function

