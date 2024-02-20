LDFLAGS := -s EXPORTED_RUNTIME_METHODS="['callMain']" -s WASM=1
CFLAGS := -O3
LDFLAGS += -O3
TARGET := libhonoka.js
INCLUDE_DIRS += -I./

all: $(TARGET)

OBJDIR := emscripten-out
OBJ := honokamiku_decrypter.o honokamiku_program.o md5.o
OBJ_2 := $(addprefix $(OBJDIR)/,$(OBJ))

$(TARGET): $(OBJ_2)
	@$(if $(Q), $(shell echo echo LD $@),)
	$(Q)$(LD) -o $@ $(OBJ_2) $(LDFLAGS)

$(OBJDIR)/%.o: %.c
	@mkdir -p $(dir $@)
	@$(if $(Q), $(shell echo echo CC $<),)
	$(Q)$(CC) $(CFLAGS) $(DEFINES) $(EOPTS) -c -o $@ $<

$(OBJDIR)/%.o: %.cpp
	@mkdir -p $(dir $@)
	@$(if $(Q), $(shell echo echo CXX $<),)
	$(Q)$(CXX) $(CXXFLAGS) $(DEFINES) $(EOPTS) -c -o $@ $<
