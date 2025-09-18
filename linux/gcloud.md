# GCloud

GCloud CLI
```
gcloud auth list
gcloud config list
gcloud config list --all
gcloud config list project
gcloud components list

# REPL for GCP
gcloud beta interactive

# Zone
gcloud config get-value compute/zone
gcloud config set compute/zone us-central1-a

# Region
gcloud config get-value compute/region
gcloud config set compute/region us-central1

gcloud compute project-info describe --project [PROJECT-ID]

export PROJECT_ID=[PROJECT-ID]
export ZONE=[ZONE-ID]
```

Kube
```
gcloud container clusters create [CLUSTER-NAME]

# Save creds to ~/.kube/config
gcloud container clusters get-credentials [CLUSTER-NAME]

# Create deployment - "Workloads"
kubectl create deployment hello-server --image=gcr.io/google-samples/hello-app:1.0
# Expose externally - "Services and ingress"
kubectl expose deployment hello-server --type=LoadBalancer --port 8080

# Show details and IP addresses
kubectl get service

# Delete the cluster
gcloud container clusters delete [CLUSTER-NAME]
```

VM
```
# Create options
gcloud compute instances create --help
# Create VM example
gcloud compute instances create [MACHINE-NAME] --machine-type n1-standard-2 --zone $ZONE

gcloud compute instances describe [MACHINE-NAME]

# SSH into VM (Creates/Adds SSH cert)
gcloud compute ssh [MACHINE-NAME] --zone $ZONE

# Allow external traffic
gcloud compute firewall-rules create www-firewall-network-lb  --target-tags network-lb-tag --allow tcp:80
# list IP addresses
gcloud compute instances list

# Create a static external IP address for your load balancer
gcloud compute addresses create network-lb-ip-1 --region us-central1

# Add a target pool
gcloud compute http-health-checks create basic-check
gcloud compute target-pools create www-pool --region us-central1 --http-health-check basic-check

# Add instances to the pool
gcloud compute target-pools add-instances www-pool --instances www1,www2,www3

# Add a forwarding rule
gcloud compute forwarding-rules create www-rule \
    --ports 80 \
    --address network-lb-ip-1 \
    --target-pool www-pool

# Show the forwarding rules
gcloud compute forwarding-rules describe www-rule

# Test out the connections
while true; do curl -m1 [IP_ADDRESS]; done

# HTTP load balancing
## 12 steps to setup - pretty complicated
```
