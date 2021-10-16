PACKER?=packer

SRC?=builds

PFLAGS?=

all: init

build-%: $(SRC)/%.pkr.hcl init
	$(PACKER) build \
		-var-file=vsphere.pkrvars.hcl \
		-only=*.vsphere-*.$(patsubst build-%,%,$@) \
		$(PFLAGS) $(SRC)

build-%-docker: init
	$(PACKER) build \
		-var-file=vsphere.pkrvars.hcl \
		-only=docker.vsphere-*.$(patsubst build-%,%,$@) \
		$(PFLAGS) $(SRC)

build-%-rke2: init
	$(PACKER) build \
		-var-file=vsphere.pkrvars.hcl \
		-only=rke2.vsphere-*.$(patsubst build-%,%,$@) \
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
