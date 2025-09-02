#!/bin/bash

echo "Downloading TASM 4.1..."
echo "======================="

cd tasm

# Try multiple sources for TASM
echo "Attempting to download TASM from archive.org..."
if wget -q --timeout=30 https://archive.org/download/msdos_TASM_4.1/TASM41.zip; then
    echo "✅ Download successful from archive.org"
    unzip TASM41.zip
    rm TASM41.zip
    echo "✅ TASM files extracted successfully"
    ls -la
elif curl -L --max-time 60 -o TASM41.zip "https://archive.org/download/msdos_TASM_4.1/TASM41.zip"; then
    echo "✅ Download successful with curl"
    unzip TASM41.zip
    rm TASM41.zip
    echo "✅ TASM files extracted successfully"
    ls -la
else
    echo "❌ Automatic download failed."
    echo ""
    echo "Manual installation options:"
    echo "1. Download TASM 4.1 manually from:"
    echo "   - https://archive.org/details/msdos_TASM_4.1"
    echo "   - https://winworldpc.com/product/turbo-assembler"
    echo ""
    echo "2. Extract the files to this directory (tasm/)"
    echo "3. Ensure you have at least:"
    echo "   - TASM.EXE"
    echo "   - TLINK.EXE" 
    echo "   - TASM.INI (optional)"
    echo ""
    echo "4. Then rebuild with: docker-compose build"
fi
