### Bloomberg Big Data and NoSQL Platform
#### 1. Build Hadoop distro of version 2.7.3
#### 2. Build docker image 

### Build the image using a scrip

```
./build-image.sh
```

### Build the image manually

```
docker build -t hadoop-base:latest -f Dockerfile .
```
Push the image to your repository unless using a local cluster.

#### 3. Minikube setup

If you are using minikube, create the paths:
`/tmp/nn` and `/tmp/keytab` on your host machine.

#### 4. Deploy the environment using a script

```


#### 4. Start PVCs

```
helm -n hdfs install pv ./pv/
```
#### 5. Start Pods

a. KDC Node
```
helm -n hdfs install kdc ./kdc/
```
b. NN Node
```
helm -n hdfs install namenode ./namenode/
```

c. DN Node
```
helm -n hdfs install datanode ./datanode/
```

d. DataPopulator Node
```
helm -n hdfs install datapopulator ./datapopulator
```

#### 6. Run kinit in any node
```
kubectl exec -it <POD_NAME> -- /bin/bash
su hdfs
kinit -kt /var/keytabs/hdfs.keytab hdfs/nn.hdfs.svc.cluster.local
hdfs dfs -ls /
```

#### 7. Clean the environment

```
./teardown.sh
```
