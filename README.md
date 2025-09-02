# TASM + DOSBox Docker Container with VNC

This Docker container provides a complete visual environment for assembly language development using TASM (Turbo Assembler) and DOSBox, accessible via VNC for a full graphical DOS experience.

## Features

- **DOSBox with TASM 4.1** pre-installed and ready to use
- **VNC server** for full graphical access (1920x1080 resolution)
- **X11 environment** with Xvfb, Fluxbox window manager, and xterm terminal
- **Persistent volume mounting** - your files are saved on your local machine
- **Combined workspace** - TASM tools and your assembly files in the same DOS directory
- **Password-protected VNC access** for security
- **Supervisor process management** for reliable service startup

## VNC Connection

### Connection Details
- **Host**: `localhost:5900`
- **Password**: `dosbox123`
- **Resolution**: 1920x1080 (Full HD)

### How to Connect

**macOS (built-in VNC client):**
```bash
open vnc://localhost:5900
```
When prompted, enter password: `dosbox123`

**Screen Sharing app:**
- Open Spotlight (Cmd+Space)
- Search for "Screen Sharing"
- Connect to: `localhost:5900`
- Password: `dosbox123`

**VNC Viewer or other clients:**
- Server: `localhost:5900`
- Password: `dosbox123`

## Directory Mounting Explained

### Three-Layer Directory Structure

```
Your Mac               Docker Container           DOSBox
---------              ----------------           -------
./pens/        →      /dos/workspace      →     C:\ drive
├── hello.asm           ├── hello.asm              ├── HELLO.ASM
├── primer.asm          ├── primer.asm             ├── PRIMER.ASM
└── Enlace.asm          ├── Enlace.asm             ├── ENLACE.ASM
                        ├── TASM.EXE (copied)      ├── TASM.EXE
                        ├── TLINK.EXE (copied)     ├── TLINK.EXE
                        └── TD.EXE (copied)        └── TD.EXE
```

### Layer 1: Docker Volume Mapping
**File**: `docker-compose.yml`
```yaml
volumes:
  - ./pens:/dos/workspace  # Maps local pens/ to container /dos/workspace
```

### Layer 2: DOSBox Drive Mounting
**File**: `config/dosbox.conf`
```ini
[autoexec]
mount c /dos/workspace    # Maps container /dos/workspace to DOSBox C: drive
c:
```

### Layer 3: TASM Tools Setup
**File**: `Dockerfile` creates `/setup-workspace.sh`
```bash
# Copies TASM tools into the workspace at startup
cp /dos/tasm/TASM.EXE /dos/workspace/
cp /dos/tasm/TLINK.EXE /dos/workspace/
cp /dos/tasm/TD.EXE /dos/workspace/
```

**Result**: Everything (your .asm files + TASM tools) appears in DOSBox C: drive!

## Quick Start

### Step 1: Get TASM Files

First, you need to obtain TASM files. You have two options:

**Option A: Automatic Download (try this first)**
```bash
# Try to download TASM automatically
./scripts/download-tasm.sh
```

**Option B: Manual Download**
1. Download TASM 4.1 from:
   - https://archive.org/details/msdos_TASM_4.1
   - Or search for "Turbo Assembler 4.1" on archive sites
2. Extract `TASM.EXE`, `TLINK.EXE` and related files to the `tasm/` directory

### Step 2: Build and Run

```bash
# Build the container
docker-compose build

# Start the container
docker-compose up -d

# Access DOSBox via VNC (optional)
# Connect to localhost:5900 with any VNC client

# Or access directly via terminal
docker exec -it tasm-dosbox dosbox
```

### Using TASM

1. Place your assembly files in the `pens/` directory
2. Connect via VNC to access the graphical DOSBox environment
3. In DOSBox, everything is available in the C: drive (both your files and TASM tools)

Example workflow:
```dos
# In DOSBox C: drive:
DIR                    # List all files (your .asm files + TASM tools)
TASM HELLO.ASM         # Assemble the code
TLINK HELLO.OBJ        # Link the object file
HELLO.EXE              # Run the program
```

## Project Directory Structure

```
.
├── Dockerfile              # Container definition with VNC setup
├── docker-compose.yml      # Container orchestration with port mapping
├── config/
│   ├── dosbox.conf        # DOSBox configuration with drive mounting
│   └── supervisord.conf   # Process management (Xvfb, VNC, DOSBox, etc.)
├── scripts/
│   ├── start-dosbox.sh    # DOSBox startup script
│   └── download-tasm.sh   # TASM download helper
├── pens/                  # Your assembly files (mounted as DOSBox C:)
│   ├── hello.asm
│   ├── primer.asm
│   └── Enlace.asm
├── tasm/                  # TASM tools (copied to workspace)
│   ├── TASM.EXE
│   ├── TLINK.EXE
│   └── TD.EXE
└── asm-files/            # Additional assembly files directory
```

## VNC Access

The container exposes DOSBox via VNC on port 5900. You can connect using any VNC client:

- **macOS**: Use Screen Sharing or download a VNC client
- **Windows**: Use built-in Remote Desktop or TightVNC
- **Linux**: Use Remmina, TigerVNC, or similar

Connect to: `localhost:5900` with password: `dosbox123`

## Sample Assembly Program

A sample `hello.asm` file is included in the `work/` directory. To test it:

```bash
# Start the container
docker-compose up -d

# Access DOSBox
docker exec -it tasm-dosbox dosbox

# In DOSBox:
C:\> tasm hello.asm
C:\> tlink hello.obj
C:\> hello.exe
```

## Commands Reference

### Docker Commands
```bash
# Build container
docker-compose build

# Start container
docker-compose up -d

# Stop container
docker-compose down

# View logs
docker-compose logs

# Access container shell
docker exec -it tasm-dosbox bash

# Access DOSBox directly
docker exec -it tasm-dosbox dosbox
```

### TASM Commands (inside DOSBox)
```dos
# Basic workflow
DIR                    # List files in current directory
TASM filename.asm      # Assemble source file
TLINK filename.obj     # Link object file
filename.exe           # Run the program

# Advanced options
TASM /zi filename.asm  # Assemble with debug info
TLINK /v filename.obj  # Link with verbose output
TD filename.exe        # Debug with Turbo Debugger
```

### DOS File Management Commands
```dos
# File operations
DIR                    # List files and directories
DIR *.asm             # List only .asm files
DEL filename.exe      # Delete a file
DEL *.obj             # Delete all object files
DEL *.exe             # Delete all executables
TYPE filename.asm     # Display file contents
COPY file1.asm file2.asm  # Copy files
REN old.asm new.asm   # Rename files

# Directory operations (if using subdirectories)
MD dirname            # Create directory
CD dirname            # Change directory
CD \                  # Go to root
RD dirname            # Remove directory
```

## Notes

- The container uses TASM 4.1 which is freely available
- All files in the `work/` directory persist between container restarts
- DOSBox is configured with appropriate memory settings for assembly development
- The environment includes EMS and XMS memory support

## Troubleshooting

### VNC Connection Issues
- Make sure port 5900 is not blocked by firewall
- Try connecting to `127.0.0.1:5900` instead of `localhost:5900`

### TASM Not Found
- Ensure the container built successfully
- Check that TASM files are properly extracted in `/dos/tasm`

### File Permissions
- Make sure the `work/` directory has proper write permissions
- On Linux/macOS, you might need to adjust ownership: `sudo chown -R $(id -u):$(id -g) work/`

## Technical Details

### VNC Setup Components

The VNC functionality is provided by several components working together:

1. **Xvfb** - Virtual X11 display server (runs display :99 at 1920x1080x24)
2. **Fluxbox** - Lightweight window manager for the X11 environment
3. **x11vnc** - VNC server that exposes the X11 display
4. **xterm** - Terminal emulator for additional access
5. **DOSBox** - DOS emulator running in the X11 environment

### Service Management

All services are managed by **supervisord** with the following startup order:
1. Xvfb starts first (virtual display)
2. Fluxbox window manager starts
3. VNC server starts and binds to port 5900
4. xterm terminal starts
5. Workspace setup runs (copies TASM tools)
6. DOSBox starts and connects to the virtual display

### Port Configuration

- **VNC Port**: 5900 (mapped from container to host)
- **VNC Password**: `dosbox123` (configured in supervisord.conf)
- **Display**: `:99` (virtual X11 display)

### File Persistence

Changes made in DOSBox are automatically saved to your local `pens/` directory through Docker volume mounting. This includes:
- Compiled .exe files
- Generated .obj files
- Any new .asm files you create
- Modified existing files

### Customizing Drive Mounting

To modify how drives are mounted in DOSBox, edit the `[autoexec]` section in `config/dosbox.conf`:

```ini
[autoexec]
mount c /dos/workspace    # Current: Everything in C: drive
# mount d /dos/tasm       # Alternative: TASM tools on D: drive
# mount e /dos/asm-files  # Alternative: Additional files on E: drive
```

## Advanced Usage

### Custom DOSBox Configuration
Edit `config/dosbox.conf` to customize DOSBox settings, then rebuild the container.

### Adding Other DOS Tools
You can extend the Dockerfile to include other DOS development tools like DEBUG, MASM, or Borland C++.

### Changing VNC Password
Edit the VNC password in `config/supervisord.conf`:
```ini
[program:vnc]
command=/usr/bin/x11vnc -display :99 -passwd YOUR_PASSWORD -listen 0.0.0.0 ...
```

### Headless Mode
To run without VNC, you can modify the startup script to run DOSBox in batch mode with specific commands.
