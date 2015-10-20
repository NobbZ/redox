AS=nasm
AWK=awk
BASENAME=basename
CUT=cut
FIND=find
LD=ld
LDARGS=-m elf_$(ARCH)
MAKE=make
MKDIR=mkdir
OBJDUMP=objdump
RM=rm
SED=sed
SORT=sort
VB=virtualbox
VB_AUDIO="pulse"
VBM=VBoxManage
VBM_CLEANUP=\
	if [ $$? -ne 0 ]; \
	then \
		if [ -d "$$HOME/VirtualBox VMs/Redox" ]; \
		then \
			echo "Redox directory exists, deleting..."; \
			$(RM) -rf "$$HOME/VirtualBox VMs/Redox"; \
		fi \
	fi
UNAME := $(shell uname)
ifeq ($(UNAME),Darwin)
	LD=$(ARCH)-elf-ld
	OBJDUMP=$(ARCH)-elf-objdump
      RUSTCFLAGS += -C ar=$(ARCH)-elf-ar -C linker=$(ARCH)-elf-linker
	VB="/Applications/VirtualBox.app/Contents/MacOS/VirtualBox"
	VB_AUDIO="coreaudio"
	VBM="/Applications/VirtualBox.app/Contents/MacOS/VBoxManage"
endif
