#!/bin/bash

early_morning_greetings=(
    "hey, you're up early 👀"
    "dawn? seriously?"
    "caffeine level: critical"
    "no sleep, just bugs"
    "o tej porze tylko ptaki i devowie"
    "morning.exe uruchamianie..."
    "world's still asleep, you're grinding"
    "5am, respect the cringe"
    "who codes this early?"
    "night shift not over yet?"
)

weekend_early_morning_greetings=(
    "weekend and you're already up? 💀"
    "o tej porze? w weekend? skill issue"
    "sun rose, you too, why?"
    "to nie jest normalne zachowanie"
    "hey night shift, time to sleep"
    "weekend and you're grinding at dawn 💀"
)

morning_greetings=(
    "rise and grind ☀️"
    "coffee won't make itself ☕"
    "new day, new bugs"
    "commit something today"
    "good morning, wage slave"
    "git checkout -b new-day"
    "another day, another segfault"
    "standup soon, good luck"
    "SO already open?"
    "zero bugs today... haha jk"
    "print('good morning')"
    "uptime: 0h, still manageable"
    "good morning world undefined"
    "no cap, survivable"
    "grinding since morning? slay"
    "poranny szpont, klasyk"
)

weekend_morning_greetings=(
    "weekend, you can live 😴"
    "zero standups, full vibe"
    "jeszcze 5 minut... klasyk"
    "side project won't write itself"
    "lazy sunday ale z kompilatorem"
    "wolne = szponcisz co chcesz"
    "socialife.exe not found"
    "sleeping or pretending?"
    "weekendowy szpont, respekt"
)

midday_greetings=(
    "had lunch? no? skill issue"
    "noon, time for a crisis"
    "git blame, ale na siebie"
    "build: failed (jak zwykle)"
    "to nie bug, to feature"
    "refactor or new feature? both bad"
    "half the day, half the sanity"
    "eat something for the love of god"
    "12:00 — time for another coffee"
    "productivity: 404"
    "szponcisz od rana i dalej nic? mood"
    "midday grind crisis"
)

weekend_midday_greetings=(
    "noon in pajamas, classic"
    "brunch czy od razu obiad?"
    "half the weekend gone 😔"
    "eat something, human"
    "git pull origin weekend"
    "grinding at noon on weekend? no cap respect"
)

afternoon_greetings=(
    "deadline? jaki deadline?"
    "almost quitting time"
    "SO tab numer 47 i counting"
    "merge conflict? kondolencje"
    "afternoon crisis, normal"
    "nothing works and nobody knows why"
    "vim open, no exits"
    "it won't deploy itself"
    "stack trace 200 linii, normalka"
    "nadal szponcisz? gigachad"
    "afternoon grind, that's a disease"
    "szpont nie czeka na fajrant"
)

weekend_afternoon_greetings=(
    "weekend in progress 😎"
    "touched grass today?"
    "skill issue czy skill issue?"
    "refactoring on Saturday? slay"
    "go outside... or don't"
    "weekend = weekday without meetings"
    "szponcisz w weekend? no cap"
)

early_evening_greetings=(
    "fajrant dla normalnych ludzi"
    "day survived, commit pushed"
    "did you push? you may live"
    "touchgrass.exe — ostatnia szansa"
    "system works? don't touch it"
    "going out today? no? respect"
    "kolacja > kolejny szpont, serio"
    "evening grind starting?"
)

evening_greetings=(
    "wieczorny lo-fi i zimna kawa, meta"
    "netflix czy kolejny PR?"
    "wieczorny debug session klasyk"
    "today was git? 🌆"
    "one more feature and I'm sleeping, lies"
    "czas na chill"
    "dark mode on, night mode too"
    "wieczorny szpont to najlepszy szpont"
    "grinding by candlelight? romantic"
)

late_evening_greetings=(
    "still alive?"
    "jeszcze jeden odcinek 🤡"
    "hour of bad decisions"
    "tomorrow-you will handle it"
    "last commit of the day? lies"
    "nobody normal at this hour... so git"
    "main branch at midnight, bold"
    "ten bug poczeka do rana"
    "SO is awake too, you're together"
    "nocny szpont, klasyczna forma"
    "szponcisz o tej porze? 💀"
)

night_greetings=(
    "go to sleep"
    "sudo shutdown -h now"
    "sleep(8 * 3600)"
    "null pointer in head, goodnight"
    "zamknij laptopa. nie pytam."
    "tomorrow you'll be a corpse 💀"
    "garbage collector waiting for your brain"
    "only bugs are born at this hour"
    "git commit -m 'goodnight'"
    "4 rano? sigma ale go to sleep"
    "system needs reboot"
    "zostaw ten szpont na jutro"
    "brain.exe stopped responding"
)

_last_greeting=""

get_greeting() {
    local hour weekday is_weekend greetings msg
    hour=$(date +"%H")
    weekday=$(date +%u)
    (( weekday >= 6 )) && is_weekend=1 || is_weekend=0

    if (( hour >= 5 && hour < 8 )); then
        (( is_weekend )) \
            && greetings=("${weekend_early_morning_greetings[@]}") \
            || greetings=("${early_morning_greetings[@]}")
    elif (( hour >= 8 && hour < 12 )); then
        (( is_weekend )) \
            && greetings=("${weekend_morning_greetings[@]}") \
            || greetings=("${morning_greetings[@]}")
    elif (( hour >= 12 && hour < 14 )); then
        (( is_weekend )) \
            && greetings=("${weekend_midday_greetings[@]}") \
            || greetings=("${midday_greetings[@]}")
    elif (( hour >= 14 && hour < 18 )); then
        (( is_weekend )) \
            && greetings=("${weekend_afternoon_greetings[@]}") \
            || greetings=("${afternoon_greetings[@]}")
    elif (( hour >= 18 && hour < 20 )); then
        greetings=("${early_evening_greetings[@]}")
    elif (( hour >= 20 && hour < 22 )); then
        greetings=("${evening_greetings[@]}")
    elif (( hour >= 22 )); then
        greetings=("${late_evening_greetings[@]}")
    else
        greetings=("${night_greetings[@]}")
    fi

    local attempts=0
    while (( attempts < 10 )); do
        msg="${greetings[$RANDOM % ${#greetings[@]}]}"
        [[ "$msg" != "$_last_greeting" ]] && break
        (( attempts++ ))
    done

    _last_greeting="$msg"
    echo "$msg"
}

get_alerts() {
    local -a alerts

    local load load_int
    load=$(cut -d " " -f1 /proc/loadavg)
    load_int=${load%.*}
    (( load_int >= 6 )) && alerts+=("CPU is cooking 🔥 load: $load")
    (( load_int >= 3 && load_int < 6 )) && alerts+=("something's grinding... load: $load")

    local mem_used
    mem_used=$(free | awk '/Mem:/ {print int($3/$2 * 100)}')
    (( mem_used >= 90 )) && alerts+=("RAM na oparach (${mem_used}%) 💀")
    (( mem_used >= 75 && mem_used < 90 )) && alerts+=("RAM is struggling (${mem_used}%)")

    if [[ -f /sys/class/power_supply/BAT0/capacity ]]; then
        local battery
        battery=$(cat /sys/class/power_supply/BAT0/capacity)
        (( battery <= 15 )) && alerts+=("zaraz zdechniesz 🔋 ${battery}%")
        (( battery > 15 && battery <= 30 )) && alerts+=("low battery (${battery}%)")
    fi

    (( ${#alerts[@]} > 0 )) && printf '%s\n' "${alerts[@]}"
}

render() {
    local -a alerts
    mapfile -t alerts < <(get_alerts)

    if (( ${#alerts[@]} > 0 )); then
        echo "${alerts[$RANDOM % ${#alerts[@]}]}"
    else
        get_greeting
    fi
}

sleep_to_next_minute() {
    local secs=$(( 10#$(date +%S) ))
    sleep $(( 60 - secs ))
}

render
