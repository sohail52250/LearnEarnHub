#!/data/data/com.termux/files/usr/bin/bash

grep -viE "My Career Profile|My Rewards|My Study Plan|Learning Progress Summary|Business Dashboard|Opportunities|Cache invalidation|Learn Skills|Leer vaardigheden|تعلم المهارات" numbered-course-titles.txt > clean-course-titles.txt

echo "Clean course list created"
wc -l clean-course-titles.txt
