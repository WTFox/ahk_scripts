all: copy 

copy:
	@echo "Copying snippets"
	@cp snippets.ahk /mnt/c/dev/ahk_scripts/snippets.ahk
	/mnt/c/ProgramData/chocolatey/bin/AutoHotkey.exe c:dev/ahk_scripts/snippets.ahk
	@echo "Copying magnet"
	@cp magnet.ahk /mnt/c/dev/ahk_scripts/magnet.ahk
	/mnt/c/ProgramData/chocolatey/bin/AutoHotkey.exe c:dev/ahk_scripts/magnet.ahk
	@echo "Done"
