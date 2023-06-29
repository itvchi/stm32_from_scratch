CC:=arm-none-eabi-gcc
MACH:=cortex-m4
TARGET_FLAGS:=\
	--specs=nosys.specs\
	-mcpu=$(MACH)\
	-mthumb\
	-mlittle-endian
	-mfpu=fpv4-sp-d16\
	-mfloat-abi=hard

CFLAGS:=\
	-c -g -Wall -Wextra -Werror\
	$(TARGET_FLAGS)\
	-std=gnu11 -O0

LDFLAGS:=\
	-Tstm32_ls.ld\
	-nostdlib\
	-Wl,-Map=final.map
# '-Map=[name]' is linker specific argument
# '-Wl,' because linking stage is done by *-gcc not *-ld command

OBJS:= main.o stm32_startup.o
TARGET:=final.elf

all: $(TARGET)

$(TARGET): $(OBJS)
	$(CC) $(LDFLAGS) -o $@ $^

%.o: %.c
	$(CC) $(CFLAGS) -o $@ $^

%.o: %.s
	$(CC) $(CFLAGS) -o $@ $^

clean:
	rm -f *.o *.elf

flash:
	openocd -f /usr/local/share/openocd/scripts/interface/stlink-v2-1.cfg \
	-f /usr/local/share/openocd/scripts/target/stm32f4x.cfg \
	-c "program $(TARGET)"

debug:
	arm-none-eabi-gdb -ex "target extended-remote :3333" $(TARGET)

.PHONY: clean flash debug