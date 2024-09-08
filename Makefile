.PHONY: all copy run watch

all: run watch

run: copy
	@echo "Running"
	@/mnt/c/Program\ Files/AutoHotkey/v2/AutoHotkey.exe c:/dev/ahk_scripts/main.ahk&

copy:
	@echo "Copying"
	@cp -r main.ahk lib/ /mnt/c/dev/ahk_scripts/

watch:
	@echo "Watching"
	ls **/*.ahk | entr make run
