CC = gcc
CFLAGS = -W -WALL
TARGET = diary.exe

$(TARGET) : memo.o calendar.o main.o
	$(CC) $(CLFAGS) -o $(TARGET) memo.o calendar.o main.o

memo.o : memo.c
	$(CC) $(CLFAGS) -c -o memo.o memo.c

calendar.o : calendar.c
	$(CC) $(CLFAGS) -c -o calendar.o calendar.c

main.o : main.c
	$(CC) $(CLFAGS) -c -o main.o main.c

clean : 
	rm *.o diary_exe

