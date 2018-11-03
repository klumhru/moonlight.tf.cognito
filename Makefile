TERRAFORM = docker run --rm -e AWS_PROFILE=${AWS_PROFILE} \
	-v ${HOME}/.ssh:/root/.ssh -v ${HOME}/.aws:/root/.aws \
	-v /tmp:/tmp -v ${PWD}:/src/terraform \
	--workdir /src/terraform \
	klumhru/terraform

# Local development targets
clean:
	@docker run --rm -e AWS_PROFILE=${AWS_PROFILE} -v ${HOME}/.aws:/root/.aws -v /tmp:/tmp -v ${PWD}:/src/terraform --entrypoint rm --workdir /src/terraform klumhru/terraform -rf .terraform

init:
	${TERRAFORM} init ${TF_CLI_ARGS_init}

plan:
	${TERRAFORM} plan -out /tmp/network.plan ${TF_CLI_ARGS_plan}

test:
	TF_CLI_ARGS_init=-backend-config=config/test-backend-config.tfvars \
	TF_CLI_ARGS_plan=-var-file=config/test-var-file.tfvars \
	TF_CLI_ARGS_destroy=-var-file=config/test-var-file.tfvars \
	make init plan apply destroy

apply:
	${TERRAFORM} apply -auto-approve /tmp/network.plan ${TF_CLI_ARGS_apply}

destroy:
	${TERRAFORM} destroy -auto-approve ${TF_CLI_ARGS_destroy}

output:
	@${TERRAFORM} output ${TF_CLI_ARGS_output}
