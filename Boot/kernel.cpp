const int ROWS = 25;
const int COLUMNS = 80;
char* const VIDEO_MEMORY = (char*)0xB8000;

void clearScreen() {
for(int i = 0; i < ROWS; ++i) {
        for(int j = 0; j < COLUMNS; ++j) {
            VIDEO_MEMORY[2 * i * COLUMNS + 2 * j] = 0;
            VIDEO_MEMORY[2 * i * COLUMNS + 2 * 1] = 0;
        }
	}
}

void print(char& color) {
	for(int i = 0; i < ROWS; ++i) {
        for(int j = 0; j < COLUMNS; ++j) {
            VIDEO_MEMORY[2 * i * COLUMNS + 2 * j + 1] = color;
            color += (2 << 4);
        }
	}
}

void main() {
   char  color = 143;
   clearScreen();

    while(1) {
        print(color);
    }
}
