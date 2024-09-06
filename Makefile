all: copy 

copy:
	@echo "Copying"
	@cp -r main.ahk lib/ /mnt/c/dev/ahk_scripts/
	@echo "Running"
	@/mnt/c/Program\ Files/AutoHotkey/v2/AutoHotkey.exe c:/dev/ahk_scripts/main.ahk&
	@echo "Done"
