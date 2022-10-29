#include "header_files/framebuffer.h"
#include "header_files/serialport.h"

int writing_starting_pos = 800;

void fb_write(char *text)
{
	int len = sizeof(text)/sizeof(char);
	for(int i = 0; i < len; i++) 
	{
  		fb_write_cell(i*2+writing_starting_pos, 	*(text+i), FB_BLACK, FB_WHITE);
	}
writing_starting_pos += len;
fb_move_cursor((int)(writing_starting_pos / 2 ) + 2); 
writing_starting_pos += len;
}

void serial_write(unsigned short com, char *buf) 
{	
	int len = sizeof(buf)/sizeof(char);
	serial_configure(com, divisor);
	int indexToBuffer = 0;
	while(indexToBuffer < len) 
	{
		outb(com, buf[indexToBuffer]);
		indexToBuffer++;
	}
	//outb(0x3F8,'t'); //write to the out1.com file
}

void choosePrintMedia(int toFile, char *text)
{
	if (toFile)
	{
		serial_write(0x3F8, text);
	} else 
	{
		fb_write(text);
	}
}

int main(){
char testText[] = "test";

fb_write(testText);
serial_write(0x3F8, testText);
//choosePrintMedia(1, testText);
	
}

