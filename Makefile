ifndef DOCKER_IMAGE_REPO
  DOCKER_IMAGE_REPO=andrebassi/linkedconfig
endif

ifndef DOCKER_IMAGE_TAG
  DOCKER_IMAGE_TAG=latest
endif

clean: clean-linkedconfig
build: build-linkedconfig
deploy: deploy-linkedconfig
remove: remove-linkedconfig

clean-linkedconfig: 
	-rm -f linkedconfig
	-docker rmi ${DOCKER_IMAGE_REPO}:${DOCKER_IMAGE_TAG}

deploy-linkedconfig:
	-kubectl apply -f setup/linkedconfig-serviceaccount.yaml
	-kubectl apply -f setup/linkedconfig-clusterrole.yaml
	-kubectl apply -f setup/linkedconfig-clusterrolebinding.yaml
	-kubectl apply -f setup/crd-customConfigMap.yaml
	-kubectl apply -f setup/crd-customSecret.yaml
	-kubectl apply -f setup/linkedconfig-deployment.yaml

remove-linkedconfig:
	-kubectl delete -f setup/linkedconfig-deployment.yaml
	-kubectl delete -f setup/crd-customConfigMap.yaml
	-kubectl delete -f setup/crd-customSecret.yaml
	-kubectl delete -f setup/linkedconfig-clusterrolebinding.yaml
	-kubectl delete -f setup/linkedconfig-clusterrole.yaml
	-kubectl delete -f setup/linkedconfig-serviceaccount.yaml

build-linkedconfig:
	-docker build . -t ${DOCKER_IMAGE_REPO}:${DOCKER_IMAGE_TAG}
	-docker push ${DOCKER_IMAGE_REPO}:${DOCKER_IMAGE_TAG}