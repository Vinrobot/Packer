PACKER?=packer

SRC?=builds

all: init

build: init
	$(PACKER) build $(SRC)

validate: init
	$(PACKER) validate $(SRC)

format: init
	$(PACKER) fmt $(SRC)

init:
	$(PACKER) init $(SRC)

.PHONY: init format validate all
