CC = gcc
CFLAGS = -W -Wall
TARGET = diary.exe
OBJECT = memo.o calendar.o main.o

all : $(TARGET)

$(TARGET) : $(OBJECT)
	$(CC) $(CLFAGS) -o $@ $^

clean : 
	rm *.o diary_exe

