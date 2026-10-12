#!/bin/bash

# 1. ವೇರಿಯೇಬಲ್ಸ್ ಡಿಕ್ಲೇರ್ ಮಾಡುವುದು
NAME="Kiran Kustigar"
ROLE="AWS DevOps Engineer"
TARGET_FILE="/c/Users/Ravindra/Downloads/Practice/troubleshooting-lab/server.log"

echo "==========================================="
echo "Welcome $NAME to Level 1: Bash Scripting Lab"
echo "Target Role: $ROLE"
echo "==========================================="

echo "Checking if the Server Log file exists..."
sleep 1 # 1 ಸೆಕೆಂಡ್ ತಡೆ ಹಿಡಿಯಲು

# 2. IF-ELSE ಕಂಡಿಷನ್ (-f ಎಂದರೆ ಫೈಲ್ ಇದೆಯೇ ಎಂದು ಚೆಕ್ ಮಾಡುವುದು)
if [ -f "$TARGET_FILE" ]; then
    echo "SUCCESS: Server log file is detected!"
    echo "-------------------------------------------"
    echo "Displaying the last 3 entries of the log:"
    tail -n 3 "$TARGET_FILE"
else
    echo "WARNING: Log file is missing! Please run the troubleshooting-lab first."
fi

echo "==========================================="
