# Kubernetes Playground
- - -
This code base is a set of scripts and applications that I use 
for working with Kubernetes.

## Getting Setup Locally
1. Install VirtualBox.
```shell
brew cask install virtualbox

# Verify with:
brew cask list

# You should see virtualbox listed.
```

2. Install kubectl
```shell
brew install kubernetes-cli
```

3. Instal MiniKube.
```shell
brew cask install minikube
```

4. Load the CLI helpers.
```shell
. setup_env.sh
```

## Working with local Kubernetes via MiniKube
MiniKube is an app for running a single node Kubernetes cluster locally in a virtual machine.
kubectl is an app for working with the Kubernetes cluster. It issues REST requests to the 
REST API server hosted on the cluster's Master Node.

### Bootstraping the Cluster
1. Start Kubernetes
Note: The first time you do this it downloads the MinKube ISO VM image. (~160 MB)
This can take 5 minutes...
```shell
minikube start
```

2. Verify Kubernetes is up.
```shell
kubectl cluster-info
```

3. Open the web dashboard
```shell
minikube dashboard
```

4. SSH into the VirtualBox VM that is running the Kubernetes cluster.
```shell
minikube ssh
```

### Explore the cluster with kubectl.
List all resources
```shell
kubectl api-resources
```

The get command can fetch basic info resources.
```shell
kubectl get nodes
```

Use the decribe command to learn more about specific resources.
```shell
kubectl describe nodes
```

Find more info about a specific resource.
In this case a node named minikube.
```shell
kubectl describe nodes minikube
```

Explain provides further details about a resource.
```shell
kubectl explain nodes
```

## Resources
* [Install Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
* [Install Minikube](https://github.com/kubernetes/minikube/releases)