.PHONY: apply destroy ssh clean salt

apply: destroy
	TF_LOG=DEBUG terraform apply

destroy:
	terraform destroy

salt:
	ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ssh/id_portus root@$$(terraform output ip_worker) salt '*' state.highstate

ssh:
	ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ssh/id_portus root@$$(terraform output ip_worker)

clean:
	rm *.tfstate*
