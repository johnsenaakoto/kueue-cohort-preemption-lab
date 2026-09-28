.PHONY: setup borrow reclaim status clean

setup:
	kubectl apply -f cohort.yaml
	kubectl apply -f cluster-queue-setup.yaml

borrow:
	kubectl apply -f job-with-sleep-300.yaml

reclaim:
	kubectl apply -f job-with-sleep-inf.yaml

status:
	kubectl get cohorts,clusterqueues
	kubectl get localqueues,jobs,workloads,pods -n default

clean:
	kubectl delete job user-sleep-300 john-sleep-inf -n default --ignore-not-found
	kubectl delete localqueue user-queue john-queue -n default --ignore-not-found
	kubectl delete clusterqueue cluster-queue cluster-queue-john --ignore-not-found
	kubectl delete cohort cohort-one --ignore-not-found
	kubectl delete resourceflavor default-flavor --ignore-not-found
