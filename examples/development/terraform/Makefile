.PHONY: apply destroy ssh clean salt

apply: destroy
	@TF_LOG=DEBUG terraform apply

destroy:
	@terraform destroy

salt:
	@chmod 0600 ssh/id_portus
	@ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ssh/id_portus root@$$(terraform output ip_worker) salt '*' state.highstate

ssh:
	@chmod 0600 ssh/id_portus
	@ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ssh/id_portus root@$$(terraform output ip_worker)

clean:
	@rm *.tfstate*
