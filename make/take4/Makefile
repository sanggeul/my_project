.SUFFIXES : .c .o

OBJS = main.o read.o write.o
SRCS = main.c read.c write.c

CC = gcc
CFLAGS = -g -c
INC = -I include/

TARGET = test.exe

$(TARGET) : $(OBJS)
	$(CC) -o $(CLFAGS) $(TARGET) $(OBJS)

.c.o :
	$(CC) $(INC) $(CFLAGS) $<

clean : 
	rm -rf $(OBJS) $(TARGET)

main.o : io.h main.c
read.o : io.h read.c
write.o : io.h write.c

