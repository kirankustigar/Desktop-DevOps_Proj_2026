#its like heading to find which script
#!/bin/bash

#to declare vaiable 
NAME="Kiran Kustigar"
ROLE="AWS DevOps Engineer"

#to print output 
echo "==========================================="
echo "Hello $NAME!"
echo "Running DevOps Script Directly from VS Code!"
echo "Target: $ROLE"
echo "==========================================="

echo "Checking System Memory (RAM) details:"
free -m 2>/dev/null || echo "Running on Windows Environment"

echo "==========================================="
