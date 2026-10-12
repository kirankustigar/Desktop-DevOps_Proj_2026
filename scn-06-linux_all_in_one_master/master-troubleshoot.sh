#!/bin/bash

# =================================================================
# Script Name: master-troubleshoot.sh
# Purpose    : All-in-One Linux Troubleshooting & Automation Lab
# Author     : Kiran Kustigar (AWS DevOps Engineer)
# =================================================================

echo "=========================================================="
echo "      DXC TECHNOLOGY - AWS DEVOPS MASTER WORKFLOW         "
echo "=========================================================="

# [ಹಂತ 1: ಪ್ರೊಸೆಸ್ ಮ್ಯಾನೇಜ್ಮೆಂಟ್ ಲ್ಯಾಬ್]
echo "1. [PROCESS MANAGEMENT] Checking local running processes..."
ps aux | head -n 3
echo "----------------------------------------------------------"

# [ಹಂತ 2: ನೆಟ್‌ವರ್ಕಿಂಗ್ ಮತ್ತು ಪೋರ್ಟ್ ಚೆಕಿಂಗ್ ಲ್ಯಾಬ್]
echo "2. [NETWORKING] Testing Active Network Ports & Connections..."
netstat -an | head -n 4
echo "----------------------------------------------------------"

# [ಹಂತ 3: ವೆಬ್‌ಸೈಟ್ ಕನೆಕ್ಟಿವಿಟಿ ಚೆಕ್ (Error Handling & OR Operator)]
echo "3. [CONNECTIVITY] Verifying Global Cloud Access (GitHub)..."
curl -I -s git@github.com:kirankustigar/Desktop-DevOps_Proj_2026.git | head -n 2 2>/dev/null || echo "Warning: Windows Environment Connectivity Blocked"
echo "----------------------------------------------------------"

# [ಹಂತ 4: ಸಿಸ್ಟಮ್ ಹೆಲ್ತ್ ಚೆಕ್ (Storage & RAM)]
echo "4. [STORAGE] Checking Local Disk Utilization..."
df -h | head -n 4
echo "=========================================================="
echo "          ALL-IN-ONE LINUX LAB COMPLETED!                 "
echo "=========================================================="
