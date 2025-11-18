# System info start ////////////////////////////////////////////
user=$(whoami)
host=$(uname -n)
uptime_sec=$(awk '{print int($1)}' /proc/uptime)
hours=$(( uptime_sec / 3600 )) 
minutes=$(( (uptime_sec % 3600) / 60 ))
seconds=$(( uptime_sec % 60 ))
uptime="${hours}h${minutes}m${seconds}s"
arch=$(uname -m)
if [ -f /etc/os-release ]; then
    source /etc/os-release
    os="$NAME $VERSION"
else
    os=$(uname -s)
fi
de=${XDG_CURRENT_DESKTOP:-$DESKTOP_SESSION:-Unknown}
shell=$(basename "$SHELL")
read mem_used mem_total <<< $(free -b | awk '/^Mem:/ {print $3, $2}')
mem_used_hr=$(free -h | awk '/^Mem:/ {print $3}')
mem_total_hr=$(free -h | awk '/^Mem:/ {print $2}')
mem="${mem_used_hr}/${mem_total_hr}"
disk_info=$(df -h / | awk 'NR==2 {print $3, $2, $5}')
disk_used=$(echo $disk_info | awk '{print $1}')
disk_total=$(echo $disk_info | awk '{print $2}')
disk="${disk_used}/${disk_total}"
packages=$(pacman -Qe 2>/dev/null | wc -l || echo "N/A")
if command -v upower >/dev/null; then
    battery=$(upower -i $(upower -e | grep BAT) 2>/dev/null | awk '/percentage/ {print $2}' || echo "N/A")
else
    battery="N/A"
fi
# System info end ////////////////////////////////////////////
# Raifu start ////////////////////////////////////////////
colors=(51 50 45 81 87 93 99 105 111 117 147 153 159 165 171 177 183 129 123 117 111 105 99 93 91)
lines=("⣇⣿⠘⣿⣿⣿⡿⡿⣟⣟⢟⢟⢝⠵⡝⣿⡿⢂⣼⣿⣷⣌⠩⡫⡻⣝⠹⢿⣿⣷ ❯ $user@$host"
"⡆⣿⣆⠱⣝⡵⣝⢅⠙⣿⢕⢕⢕⢕⢝⣥⢒⠅⣿⣿⣿⡿⣳⣌⠪⡪⣡⢑⢝⣇ ❯ OS: $os$de"
"⡆⣿⣿⣦⠹⣳⣳⣕⢅⠈⢗⢕⢕⢕⢕⢕⢈⢆⠟⠋⠉⠁⠉⠉⠁⠈⠼⢐⢕⢽ ❯ Uptime: $uptime"
"⡗⢰⣶⣶⣦⣝⢝⢕⢕⠅⡆⢕⢕⢕⢕⢕⣴⠏⣠⡶⠛⡉⡉⡛⢶⣦⡀⠐⣕⢕ ❯ Shell: $shell"
"⡝⡄⢻⢟⣿⣿⣷⣕⣕⣅⣿⣔⣕⣵⣵⣿⣿⢠⣿⢠⣮⡈⣌⠨⠅⠹⣷⡀⢱⢕ ❯ Memory: $mem"
"⡝⡵⠟⠈⢀⣀⣀⡀⠉⢿⣿⣿⣿⣿⣿⣿⣿⣼⣿⢈⡋⠴⢿⡟⣡⡇⣿⡇⡀⢕ ❯ Disk: $disk"
"⡝⠁⣠⣾⠟⡉⡉⡉⠻⣦⣻⣿⣿⣿⣿⣿⣿⣿⣿⣧⠸⣿⣦⣥⣿⡇⡿⣰⢗⢄ ❯ Packages: $packages"
"⠁⢰⣿⡏⣴⣌⠈⣌⠡⠈⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣬⣉⣉⣁⣄⢖⢕⢕⢕ ❯ Battery: $battery"
"⡀⢻⣿⡇⢙⠁⠴⢿⡟⣡⡆⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⣵⣵⣿"
"⡻⣄⣻⣿⣌⠘⢿⣷⣥⣿⠇⣿⣿⣿⣿⣿⣿⠛⠻⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿"
"⣷⢄⠻⣿⣟⠿⠦⠍⠉⣡⣾⣿⣿⣿⣿⣿⣿⢸⣿⣦⠙⣿⣿⣿⣿⣿⣿⣿⣿⠟"
"⡕⡑⣑⣈⣻⢗⢟⢞⢝⣻⣿⣿⣿⣿⣿⣿⣿⠸⣿⠿⠃⣿⣿⣿⣿⣿⣿⡿⠁⣠"
"⡝⡵⡈⢟⢕⢕⢕⢕⣵⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣶⣿⣿⣿⣿⣿⠿⠋⣀⣈⠙"
"⡝⡵⡕⡀⠑⠳⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠛⢉⡠⡲⡫⡪⡪⡣")
num_colors=${#colors[@]}
num_lines=${#lines[@]}
for ((i=0; i<num_lines; i++)); do
  color=${colors[$((i * num_colors / num_lines))]}
  echo -e "\033[38;5;${color}m${lines[i]}\033[0m"
done
# Raifu end ////////////////////////////////////////////