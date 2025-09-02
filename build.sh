#!/bin/bash

echo "Building TASM + DOSBox Docker container..."
echo "=========================================="

# Build the container
docker-compose build

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Container built successfully!"
    echo ""
    echo "To start the container:"
    echo "  docker-compose up -d"
    echo ""
    echo "To access DOSBox:"
    echo "  docker exec -it tasm-dosbox dosbox"
    echo ""
    echo "To connect via VNC:"
    echo "  Connect to localhost:5900 with any VNC client"
    echo ""
    echo "Your assembly files go in the 'work/' directory"
else
    echo ""
    echo "❌ Build failed. Check the output above for errors."
fi
