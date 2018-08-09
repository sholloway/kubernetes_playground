# Kubernetes Playground
- - -
This code base is a set of scripts and applications that I use 
for working with Kubernetes.

## Getting Setup Locally
1. Install Docker for Mac by following the [offical instructions](https://www.docker.com/get-started).
   Note: It is possible to install Docker via Homebrew.

2. Install VirtualBox.
```shell
brew cask install virtualbox

# Verify with:
brew cask list

# You should see virtualbox listed.
```

3. Install kubectl
```shell
brew install kubernetes-cli
```

4. Instal MiniKube.
```shell
brew cask install minikube
```

5. Load the CLI helpers.
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
# Verify the VM is running
minikube status

# Verify the cluster is running in the VM
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

To shut the local cluster down.
```shell
minikube stop
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

### Deploying a Docker App to the Local Kubernetes cluster.
1. Build the app's Docker image. This example uses the simple_node_app.
```shell
# Load the project's terminal env if you haven't already.
. setup_env.sh

build_node_app
```

2. Deploy the app's Docker image to the cluster.
   Out of the box Kubernetes is configured to pull container images from a repo. 
   For local development this is less than ideal. To avoid this, use the Docker deamon in 
   the MiniKube VM to host a local Docker repository.
    A. Change your terminal to use the VM's Docker rather than your host.
    ```shell
    eval $(minikube docker-env)
    ```

    B. Setup a local Docker repository using a container. This approach is agnostic to MiniKube.
       To use a local Docker, you must [tag](https://docs.docker.com/engine/reference/commandline/tag/#tag-an-image-referenced-by-name-and-tag) the image you want to push with the registry hostname and port.
       To configure MiniKube to leverage the local repo you must ... as per [this article](https://blog.hasura.io/sharing-a-local-registry-for-minikube-37c7240d0615).
    ```shell 
    Run the registry [container](https://hub.docker.com/_/registry/).
    docker run --detach \
        --publish 5000:5000 \
        --restart always \
        --name registry \
        registry:latest
    ```

    C. Tag your app's image for the local repo. This example uses the simple_node_app.
    ```shell
    docker tag simple_node_app localhost:5000/simple_node_app
    ```

    D. Push the image to the local Docker repo.
    ```shell
    docker push localhost:5000/simple_node_app
    ```

    E. Optionally, you can verify that the app is now in the local repo.
    ```curl
    curl http://localhost:5000/v2/_catalog
    ```

    F. Setup Kubernetes to use the local repo by configuring a pod. https://gist.github.com/kevin-smets/b91a34cea662d0c523968472a81788f7  
    Create configure a pod to run your app from the repo using the provided config file.
    ```shell
    kubectl create -f pods/simple_node_app.yml 
    ``` 
    
    G. You should now see your pod and app running.
    ```shell
    kubectl get all
    ```

    H. The pod is configured to expose the app outside of the cluster. Find the url.
    ```shell
    minikube service simple-node-app --url
    ```


   


## Resources
* [Install Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
* [Install Minikube](https://github.com/kubernetes/minikube/releases)