# Arm Cortex-M0 Base Project

Example Workspace für die Vorlesung Systemnahe Programmierung I an der
DHWB Ravensburg.

## Arm Documentation
 - [Cortex M0 Startseite](https://developer.arm.com/Processors/Cortex-M0)
   - [Armv6-M Architecture Reference Manual](https://developer.arm.com/documentation/ddi0419/latest/)
   - [Arm Cortex-M0 Processor Datasheet](https://developer.arm.com/documentation/102834/0100/?lang=en)
   - [Cortex-M0 Devices Generic User Guide](https://developer.arm.com/documentation/dui0497/a/?lang=en)
   - [Cortex-M0 Technical Reference Manual r0p0](https://developer.arm.com/documentation/ddi0432/c/?lang=en)
 - [Arm Application Binary Interface](https://github.com/ARM-software/abi-aa)
 - [GNU Assembler Documentation](https://sourceware.org/binutils/docs-2.40/as/index.html)
 - [GNU Linker Documentation](https://sourceware.org/binutils/docs-2.40/ld/index.html)

## Simuliertes Board Info
 - [Nordic nRF boards (microbit)](https://www.qemu.org/docs/master/system/arm/nrf.html)
 - [Nordic nRF51822](https://www.nordicsemi.com/products/nrf51822)
 - [nRF51822 Product Specification v3.4](https://infocenter.nordicsemi.com/pdf/nRF51822_PS_v3.4.pdf)

## Prerequisites
 - Arm Cross Compiler Paket: _gcc-arm-none-eabi_
 - QEMU Arm Paket: _qemu-system-arm_
 - GDB (Multi-Arch) Paket: _gdb-multiarch_
 - CMake

Hinweis:
Bei SUSE scheint der standard GDB ein GDB-Multiarch zu sein.

### Windows
Installation von CMake über Download des Installers (https://cmake.org/download/)
oder Paketmanager `winget install CMake.CMake`.

Installation der ARM GCC Toolchain [Website](https://gnutoolchains.com/arm-eabi/)
Nach z.B. C:\Toolchains\
**WICHTIG:** zu PATH hinzufügen (lassen)

### Linux
Über Paketmanager Installieren:

**Ubuntu/ Debian**: ```sudo apt install gcc-arm-none-eabi cmake```

**Arch**:
```
yay -S gcc-arm-none-eabi-bin 
sudo pacman -S cmake
```

### macOS
```brew install gcc-arm-embedded```

## Building
Auschecken des Quellcodes:
`git clone https://github.com/infohoschie/arm-cortex-m0-cmake.git`

Erstellen des Build Mittels CMake Presets:
```cmake --preset arm-cortex-m0-unix```
oder
```cmake --preset arm-cortex-m0-mingw```

Bauen Mittels CMake Presets:
```cmake --build --preset arm-cortex-m0```
oder
```cmake --build --preset arm-cortex-m0-mingw```

## Generiertes Output analysieren (optional)
 - ELF-Sections anzeige:
   `arm-none-eabi-objdump -x build-cortex-m0/testApp.elf`
 - ELF-File disassemblieren (mit Quellcode-Verknüpfung):
   `arm-none-eabi-objdump -d build-cortex-m0/testApp.elf`
   `arm-none-eabi-objdump -d -S build-cortex-m0/testApp.elf`

## QEMU Emulator starten und mit GDB verbinden
QEMU und GDB müssen in unterschiedlichen Konsolen (Shells) gestartet werden.
 - QEMU Emlation Starten:
   `qemu-system-arm -M microbit -device loader,file=build-cortex-m0/testApp.elf -nographic -S -s`
 - GDB zu WEMU verbinden:
   `gdb-multiarch build-cortex-m0/testApp.elf -ex "target extended-remote localhost:1234" -ex "load"`

## IDEs
### Jetbrains CLion
Das Projekt kann direkt in der IDE geöffnet (ausgechecked) werden.
Die CMake Presets werden direkt als build-target angeboten

Der Integrierte Debugger kann direkt genutzt werden.
Unter der Run-Configuration kann der QEMU Aufruf als "Native Application" hinzugefügt werden
Unter debug Configuration kann eine "Remote Debug" konfiguration angelegt werden, bei der unter "target remote args" die verbindungsdetails angeben und als symbol filedie testApp.elf referenziert werden kann.

### Visual Studio Code

Folgende Extensions werden benötigt:
- jkearins.action-buttons-ext
- webfreak.debug
- maxmitti.cmake-tools-fork
- twxs.cmake
- dan-c-underwood.arm

Diese sind ebenfalls als empfohlene Extensions im Workspace definiert.

Nach Installation erkennt VScode die CMake Presets und bietet diese gleich an.
Ebenfalls wird in der Statusleiste ein Button **Start Qemu** hinzugefügt,
über diesen die QEmu-Session (also unser Target) gestartet werden kann.
