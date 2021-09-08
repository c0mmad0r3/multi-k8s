docker build -t pipsae24/multi-client:latest -t pipsae24/multi-client:$SHA ./client -f ./client/Dockerfile ./client
docker build -t pipsae24/multi-server:latest -t pipsae24/multi-server:$SHA ./server -f ./server/Dockerfile ./server
docker build -t pipsae24/multi-worker:latest -t pipsae24/multi-worker:$SHA ./worker -f ./worker/Dockerfile ./worker
docker push pipsae24/multi-client:latest
docker push pipsae24/multi-client:$SHA
docker push pipsae24/multi-server:latest
docker push pipsae24/multi-server:$SHA 
docker push pipsae24/multi-worker:latest
docker push pipsae24/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=pipsae24/multi-server:$SHA
kubectl set image deployments/client-deployment client=pipsae24/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=pipsae24/multi-worker:$SHA