docker build -t yashassamaga/multi-client:latest -t yashassamaga/multi-client:$SHA ./client
docker build -t yashassamaga/multi-server:latest -t yashassamaga/multi-server:$SHA ./server
docker build -t yashassamaga/multi-worker:latest -t yashassamaga/multi-worker:$SHA ./worker

docker push  yashassamaga/multi-client:latest
docker push  yashassamaga/multi-server:latest
docker push  yashassamaga/multi-worker:latest

docker push  yashassamaga/multi-client:$SHA
docker push  yashassamaga/multi-server:$SHA
docker push  yashassamaga/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=yashassamaga/multi-client:$SHA
kubectl set image deployments/server-deployment server=yashassamaga/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=yashassamaga/multi-worker:$SHA

