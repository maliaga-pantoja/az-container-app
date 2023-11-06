tf:
	docker run -v "${PWD}/iac:/app" \
	-e ARM_CLIENT_ID=${ARM_CLIENT_ID} \
	-e ARM_CLIENT_SECRET=${ARM_CLIENT_SECRET} \
	-e ARM_TENANT_ID=${ARM_TENANT_ID} \
	-e ARM_SUBSCRIPTION_ID=${ARM_SUBSCRIPTION_ID} \
	-w /app \
	hashicorp/terraform:1.6 ${COMMAND}
init:
	$(MAKE) tf COMMAND=init
plan:
	$(MAKE) tf COMMAND=plan