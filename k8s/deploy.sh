docker build -t msevugan/multi-client:latest -t msevugan/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t msevugan/multi-server -t msevugan/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t msevugan/multi-worker -t msevugan/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push msevugan/multi-client:latest
docker push msevugan/multi-client:$SHA
docker push msevugan/multi-server:latest
docker push msevugan/multi-server:$SHA
docker push msevugan/multi-worker:latest
docker push msevugan/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=msevugan/multi-server:$SHA
kubectl set image deployments/client-deployment client=msevugan/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=msevugan/multi-worker:$SHA
