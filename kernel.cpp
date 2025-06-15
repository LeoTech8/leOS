void printf(char *str) {
    unsigned short *VideoMemory = (unsigned short*)0xb8000UL;
    for (int i = 0; str[i] != '\0'; ++i)
        VideoMemory[i] = (VideoMemory[i] & 0xFF00) | str[i];
}

void main() {   
    printf("leOS - Version 0.3 - Get the code at https://github.com/LeoTech8/leoOS/");
}
