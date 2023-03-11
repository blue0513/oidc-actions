# Makefile

.PHONY: plan apply destroy fmt

plan:
	terraform plan

apply:
	terraform apply --auto-approve

destroy:
	terraform destroy --auto-approve

fmt:
	terraform fmt -recursive
