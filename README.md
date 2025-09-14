# Charon Blog Kubernetes Manifests

Spring Boot 블로그 애플리케이션을 EKS에 배포하기 위한 Kubernetes 매니페스트 저장소입니다.

## 📋 리소스 구성

- **Namespace**: `charon-blog` - 애플리케이션 전용 네임스페이스
- **Deployment**: 3 replicas, health checks, resource limits 설정
- **Service**: ClusterIP 타입으로 내부 통신
- **Ingress**: AWS ALB를 통한 외부 접근
- **HPA**: CPU/Memory 기반 자동 스케일링 (2-10 replicas)

## 🚀 배포 방법

### kubectl 직접 배포
```bash
kubectl apply -f .
```

### Kustomize 사용
```bash
kubectl apply -k .
```

### ArgoCD 사용
1. ArgoCD UI 접속
2. 새 애플리케이션 생성
3. Repository: `https://github.com/aszcharon/manifest`
4. Path: `.` (루트)
5. Destination: EKS 클러스터

## 🔧 설정 정보

### ECR 이미지
- **Repository**: `320644768930.dkr.ecr.ap-northeast-2.amazonaws.com/charon-test`
- **Tag**: `latest` (GitHub Actions에서 자동 업데이트)

### 리소스 제한
- **CPU**: 250m (request) / 500m (limit)
- **Memory**: 512Mi (request) / 1Gi (limit)

### 자동 스케일링
- **최소**: 2 replicas
- **최대**: 10 replicas
- **CPU 임계값**: 70%
- **Memory 임계값**: 80%

## 📊 모니터링

### 배포 상태 확인
```bash
# Pod 상태
kubectl get pods -n charon-blog

# 서비스 상태
kubectl get svc -n charon-blog

# Ingress 주소 확인
kubectl get ingress -n charon-blog

# HPA 상태
kubectl get hpa -n charon-blog
```

### 로그 확인
```bash
# 애플리케이션 로그
kubectl logs -f deployment/charon-blog -n charon-blog

# 특정 Pod 로그
kubectl logs -f <pod-name> -n charon-blog
```

## 🔗 관련 저장소

- **애플리케이션 코드**: [aszcharon/blog](https://github.com/aszcharon/blog)
- **Terraform 인프라**: EKS 클러스터 및 관련 리소스

## 📝 업데이트

새로운 이미지가 ECR에 푸시되면:
1. `deployment.yaml`의 이미지 태그 업데이트
2. ArgoCD가 자동으로 변경사항 감지 및 배포
3. 또는 수동으로 `kubectl rollout restart deployment/charon-blog -n charon-blog`