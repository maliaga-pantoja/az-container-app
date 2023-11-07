tf:
	docker run -v "${PWD}/iac:/app" \
	-e ARM_CLIENT_ID=${ARM_CLIENT_ID} \
	-e ARM_CLIENT_SECRET=${ARM_CLIENT_SECRET} \
	-e ARM_TENANT_ID=${ARM_TENANT_ID} \
	-e ARM_SUBSCRIPTION_ID=${ARM_SUBSCRIPTION_ID} \
	-e TF_VAR_PROJECT_NAME=${PROJECT_NAME}  \
	-e TF_VAR_REGION=${REGION} \
	-e TF_VAR_IMAGE_NAME=${IMAGE_NAME} \
	-e TF_VAR_IMAGE_TAG=${IMAGE_TAG}  \
	-w /app \
	hashicorp/terraform:1.6 ${COMMAND}
init:
	./devops/scripts/infra.sh 
plan:
	./devops/scripts/infra.sh script_terraform_plan
apply:
	./devops/scripts/infra.sh script_terraform_apply
destroy:
	./devops/scripts/infra.sh script_terraform_destroy
output:
	./devops/scripts/infra.sh script_terraform_output