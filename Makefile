all: copy 

copy:
	@echo "Copying lib"
	@cp -r main.ahk lib/ /mnt/c/dev/ahk_scripts/
	@/mnt/c/ProgramData/chocolatey/bin/AutoHotkey.exe c:\\dev\\ahk_scripts\\main.ahk
	@echo "Done"
