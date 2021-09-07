docker build -t yashassamaga/multiclient:latest -t yashassamaga/multiclient:$SHA ./client
docker build -t yashassamaga/multiserver:latest -t yashassamaga/multiserver:$SHA ./server
docker build -t yashassamaga/multiworker:latest -t yashassamaga/multiworker:$SHA ./worker

docker push  yashassamaga/multiclient:latest
docker push  yashassamaga/multiserver:latest
docker push  yashassamaga/multiworker:latest

docker push  yashassamaga/multiclient:$SHA
docker push  yashassamaga/multiserver:$SHA
docker push  yashassamaga/multiworker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=yashassamaga/multiclient:$SHA
kubectl set image deployments/server-deployment server=yashassamaga/multiserver:$SHA
kubectl set image deployments/worker-deployment worker=yashassamaga/multiworker:$SHA

