TERRAFORM = docker run --rm \
	-v /tmp:/tmp -v ${PWD}:/src/terraform \
	-e AWS_ACCESS_KEY_ID=${AWS_ACCESS_KEY_ID} \
	-e AWS_SECRET_ACCESS_KEY=${AWS_SECRET_ACCESS_KEY} \
	-e AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION} \
	--workdir /src/terraform \
	klumhru/terraform

init:
	${TERRAFORM} init ${TF_CLI_ARGS_init}

plan:
	${TERRAFORM} plan -out /tmp/terraform.plan ${TF_CLI_ARGS_plan}

test:
	TF_CLI_ARGS_init=-backend-config=config/test-backend-config.tfvars \
	TF_CLI_ARGS_plan=-var-file=config/test-var-file.tfvars \
	TF_CLI_ARGS_destroy=-var-file=config/test-var-file.tfvars \
	make init plan apply destroy

apply:
	${TERRAFORM} apply -auto-approve /tmp/terraform.plan ${TF_CLI_ARGS_apply}

destroy:
	${TERRAFORM} destroy -auto-approve ${TF_CLI_ARGS_destroy}
