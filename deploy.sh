#!/bin/bash

echo "Deploying Charon Blog to Kubernetes..."

# 네임스페이스 먼저 생성
echo "Creating namespace..."
kubectl apply -f namespace.yaml

# 잠시 대기
sleep 2

# 나머지 리소스 배포
echo "Deploying application resources..."
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml
kubectl apply -f hpa.yaml

echo "Deployment completed!"
echo ""
echo "Check status:"
echo "kubectl get pods -n charon-blog"
echo "kubectl get svc -n charon-blog"
echo "kubectl get ingress -n charon-blog"