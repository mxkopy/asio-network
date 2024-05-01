CC              = g++
CPP             = src/cpp
HPP             = src/hpp
BUILD           = build
CFLAGS          = -Wall -MMD -MP -MF $(BUILD)/.d -g -O2
INCL            = -I$(HPP) -I$(CPP)
LIBS            = -lpng -lleptonica -lboost_serialization
OBJECTS         = $(patsubst $(CPP)/%.cpp, %, $(wildcard $(CPP)/*))

build: build-dir $(patsubst %, $(BUILD)/%.o, $(OBJECTS))
	ar -rcs build/libasio-network.a $(BUILD)/*.o

build-dir:
	mkdir -p $(BUILD)

$(BUILD)/%.o: $(CPP)/%.cpp $(HPP)/%.hpp
	$(CC) $< -c $(CFLAGS:.d=$*.d) $(INCL) $(LIBS) -o $@

clean:
	@ rm build/*

install: build
	sudo cp -f $(BUILD)/libasio-network.a /usr/lib
	sudo cp -rf $(HPP) /usr/include/asio-network

uninstall:
	@ sudo rm /usr/lib/libasio-network.a
	@ sudo rm -rf /usr/include/asio-network
