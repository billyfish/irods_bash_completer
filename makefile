-include user.prefs

CC := gcc

ifeq ($(IRODS_HOME),)
IRODS_HOME := /
endif

IRODS_LIB_DIR := $(IRODS_HOME)usr/lib
IRODS_INCLUDE_DIR := $(IRODS_HOME)usr/include/irods

IRODS_LIBS := irods_plugin_dependencies irods_client irods_common 

OUTPUT_DIR	 := build


SRC_FILES := main.c byte_buffer.c

OBJ_FILES := $(SRC_FILES:%.c=$(OUTPUT_DIR)/%.o)

VPATH := src

CFLAGS += -I$(IRODS_INCLUDE_DIR) -Iinclude -Wextra -Wall

LDFLAGS += $(addprefix -l, $(IRODS_LIBS)) \
	-L $(IRODS_LIB_DIR) 

.PHONY: all comp init clean

all: init comp $(OBJ_FILES)


comp: init $(OBJ_FILES)
	$(CC) -o $(OUTPUT_DIR)/irods_bash_completer $(OBJ_FILES) $(STATIC_LIBS) $(LDFLAGS)

init:
	mkdir -p $(OUTPUT_DIR)


$(OUTPUT_DIR)/%.o: %.c 
	$(CC) -c $(CFLAGS) $(CPPFLAGS) $< -o $@

clean:
	rm -fr $(OUTPUT_DIR)/*

