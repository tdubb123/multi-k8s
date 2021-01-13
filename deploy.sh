docker build -t tdubb123/multi-client:latest -t tdubb123/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t tdubb123/multi-server:latest -t tdubb123/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t tdubb123/multi-worker:latest -t tdubb123/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push tdubb123/multi-client:latest
docker push tdubb123/multi-server:latest
docker push tdubb123/multi-worker:latest

docker push tdubb123/multi-client:$SHA
docker push tdubb123/multi-server:$SHA
docker push tdubb123/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=tdubb123/multi-server:$SHA
kubectl set image deployments/client-deployment client=tdubb123/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=tdubb123/multi-worker:$SHA
