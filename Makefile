PACKER?=packer

SRC?=builds

PFLAGS?=

all: init

build-%: $(SRC)/%.pkr.hcl init
	$(PACKER) build \
		-var-file=vsphere.pkrvars.hcl \
		-only=vsphere-*.$(patsubst build-%,%,$@) \
		$(PFLAGS) $(SRC)

validate: init
	$(PACKER) validate \
		-var-file=vsphere.pkrvars.hcl \
		$(PFLAGS) $(SRC)

format: init
	$(PACKER) fmt $(PFLAGS) $(SRC)

init:
	$(PACKER) init $(PFLAGS) $(SRC)

.PHONY: init format all
