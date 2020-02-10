docker build -t raj0909patel/multi-client:latest -t raj0909patel/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t raj0909patel/multi-server:latest -t raj0909patel/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t raj0909patel/multi-worker:latest -t raj0909patel/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push raj0909patel/multi-client:latest
docker push raj0909patel/multi-server:latest
docker push raj0909patel/multi-worker:latest

docker push raj0909patel/multi-client:$SHA
docker push raj0909patel/multi-server:$SHA
docker push raj0909patel/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=raj0909patel/multi-client:$SHA
kubectl set image deployments/server-deployment server=raj0909patel/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=raj0909patel/multi-worker:$SHA