
 Host the image and the key over http server  for the initContainer :
python3 -m http.server 8080

kubectl get svc -n open5gs


kubectl get pods -n open5gs


kubectl delete -f service.yaml -n open5gs
kubectl delete -f deployment.yaml -n open5gs
kubectl delete -f configmap.yaml -n open5gs
kubectl apply -f configmap.yaml -n open5gs
kubectl apply -f deployment.yaml -n open5gs
kubectl apply -f service.yaml -n open5gs


kubectl apply -f deployment.yaml -n open5gs
kubectl apply -f service.yaml -n open5gs
kubectl apply -f secret.yaml -n open5gs

kubectl delete -f secret.yaml -n open5gs
kubectl delete -f deployment.yaml -n open5gs
kubectl delete -f service.yaml -n open5gs



kubectl exec -n open5gs  open5gs-nrf-5ccd7dcb94-xq5g4 -c nrf -- ip a

kubectl logs -c decrypt-init deploy/open5gs-nrf -n open5gs

kubectl describe pod mongo-0  -n open5gs
kubectl logs mongo-0           -n open5gs -c webui

kubectl exec -n open5gs  -c decrypt-init -- ip a
kubectl exec -it  webui-5ccbb8f49d-hcrhf -n open5gs --/bin/bash


kubectl delete pod -n open5gs open5gs-nrf-5d9ff878fd-nr4tn 


kubectl delete pod -n open5gs -l app=open5gs-nrf



kubectl exec -it $(kubectl get po -l app=open5gs-nrf -n open5gs -o jsonpath='{.items[0].metadata.name}') -n open5gs -- \
  cat /open5gs/install/etc/open5gs/nrf.yaml
