# 容器化相关工程文件生成脚本 @v1.0
# @auth Neil zengwanzhong@movee.cn
#
# 更新镜像版本 make build tag=1.1

image:=registry.cn-beijing.aliyuncs.com/sdpsaas/sdp-base-nginx
os:=debian

.PHONY: build
build:
	echo $(tag) > .build_version
	docker build -f Dockerfile  -t $(image):$(os)-$(tag) .
	docker push $(image):$(os)-$(tag)
	docker rmi $(image):$(os)-$(tag)

.PHONY: dev-build	
dev-build:
	docker build -t nginx-standalone .

.PHONY: images
images:
	docker images | grep -E "($(image)|IMAGE ID)"

help:
	@echo make build tag=1.1	打包镜像并发布到镜像仓库。 tag 是待创建的版本号
	@echo make dev-build        本地开发构建，不自动发布到镜像仓库
	@echo make images           查看当前命名空间镜像列表
