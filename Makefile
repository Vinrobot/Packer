PACKER?=packer

SRC?=builds

PFLAGS?=

all: init

full-%: validate-% build-%

build-%: $(SRC)/%.pkrvars.hcl $(SRC)/%.pkr.hcl init
	$(PACKER) build \
		-var-file=$(SRC)/$(patsubst build-%,%,$@).pkrvars.hcl \
		-var-file=vsphere.pkrvars.hcl \
		-only=vsphere-*.$(patsubst build-%,%,$@) \
		$(PFLAGS) $(SRC)

validate-%: $(SRC)/%.pkrvars.hcl $(SRC)/%.pkr.hcl init
	$(PACKER) validate \
		-var-file=$(SRC)/$(patsubst validate-%,%,$@).pkrvars.hcl \
		-var-file=vsphere.pkrvars.hcl \
		-only=vsphere-*.$(patsubst validate-%,%,$@) \
		$(PFLAGS) $(SRC)

format: init
	$(PACKER) fmt $(PFLAGS) $(SRC)

init:
	$(PACKER) init $(PFLAGS) $(SRC)

.PHONY: init format all
