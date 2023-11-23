APPLICATION = sensors

BOARD ?= iotlab-m3

USEMODULE += shell
USEMODULE += shell_commands
USEMODULE += ztimer_msec

USEMODULE += lps331ap


RIOTBASE ?= $(CURDIR)/../RIOT

include $(RIOTBASE)/Makefile.include

