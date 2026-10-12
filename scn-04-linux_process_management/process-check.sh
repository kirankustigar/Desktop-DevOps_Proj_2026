#!/bin/bash

echo "==========================================="
echo "AWS DevOps Process & Performance Lab - Kiran"
echo "==========================================="

echo "1. Checking Top 3 CPU Consuming Processes:"
# ps aux ಕಮಾಂಡ್ ಬಳಸಿ ಅತಿ ಹೆಚ್ಚು CPU ಬಳಸುವ ಟಾಪ್ 3 ಪ್ರೊಸೆಸ್ ಲಿಸ್ಟ್ ಮಾಡುವುದು
ps aux | head -n 4

echo "-------------------------------------------"
echo "2. Testing a Fake Background Process..."
# ಬ್ಯಾಕ್ಗ್ರೌಂಡ್‌ನಲ್ಲಿ 100 ಸೆಕೆಂಡ್ ನಿದ್ರಿಸುವ ನಕಲಿ ಪ್ರೊಸೆಸ್ ರನ್ ಮಾಡುವುದು (& ಎಂದರೆ background)
sleep 100 & 

# ಆ ನಕಲಿ ಪ್ರೊಸೆಸ್‌ನ Process ID (PID) ಅನ್ನು ಪತ್ತೆ ಹಚ್ಚುವುದು
PID=$!
echo "Fake process started with PID: $PID"

echo "-------------------------------------------"
echo "3. Killing the hanging process forcefully..."
# kill -9 ಬಳಸಿ ಆ ನಕಲಿ ಪ್ರೊಸೆಸ್ ಅನ್ನು ತಕ್ಷಣವೇ ಕೊಲ್ಲುವುದು
kill -9 $PID

if [ $? -eq 0 ]; then
    echo "SUCCESS: Process $PID has been terminated successfully!"
else
    echo "FAILED: Could not kill the process."
fi
echo "==========================================="
