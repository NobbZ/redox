SHELL=windows\sh
LD=windows/$(ARCH)-elf-ld
AS=windows/nasm
AWK=windows/awk
BASENAME=windows/basename
CUT=windows/cut
FIND=windows/find
MAKE=windows/make
MKDIR=windows/mkdir
OBJDUMP=windows/objdump
RM=windows/rm
SED=windows/sed
SORT=windows/sort
VB="C:/Program Files/Oracle/VirtualBox/VirtualBox"
VB_AUDIO="dsound"
VBM="C:/Program Files/Oracle/VirtualBox/VBoxManage"
VBM_CLEANUP=\
  if [ $$? -ne 0 ]; \
  then \
    if [ -d "$$USERPROFILE/VirtualBox VMs/Redox" ]; \
    then \
      echo "Redox directory exists, deleting..."; \
      $(RM) -rf "$$USERPROFILE/VirtualBox VMs/Redox"; \
    fi \
  fi
