PACKER?=packer

SRC?=builds

all: init

full-%: validate-% build-%

build-%: $(SRC)/%.pkrvars.hcl $(SRC)/%.pkr.hcl init
	$(PACKER) build \
		-var-file=$(SRC)/$(patsubst build-%,%,$@).pkrvars.hcl \
		-var-file=vsphere.pkrvars.hcl \
		-only=vsphere-iso.$(patsubst build-%,%,$@) \
		$(SRC)

validate-%: $(SRC)/%.pkrvars.hcl $(SRC)/%.pkr.hcl init
	$(PACKER) validate \
		-var-file=$(SRC)/$(patsubst validate-%,%,$@).pkrvars.hcl \
		-var-file=vsphere.pkrvars.hcl \
		-only=vsphere-iso.$(patsubst validate-%,%,$@) \
		$(SRC)

format: init
	$(PACKER) fmt $(SRC)

init:
	$(PACKER) init $(SRC)

.PHONY: init format all
