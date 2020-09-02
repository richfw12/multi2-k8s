docker build -t richfw12/multi-client:latest -t richfw12/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t richfw12/multi-server:latest -t richfw12/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t richfw12/multi-worker:latest -t richfw12/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push richfw12/multi-client:latest
docker push richfw12/multi-server:latest
docker push richfw12/multi-worker:latest

docker push richfw12/multi-client:$SHA
docker push richfw12/multi-server:$SHA
docker push richfw12/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=richfw12/multi-server:$SHA
kubectl set image deployments/client-deployment server=richfw12/multi-client:$SHA
kubectl set image deployments/worker-deployment server=richfw12/multi-worker:$SHA
