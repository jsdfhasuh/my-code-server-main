# Dockerfile 使用说明

这个 Dockerfile 用于创建一个基于 Ubuntu 的 Docker 镜像，并在其中安装 Visual Studio Code。这个镜像理论上是vscode的最新版本，可以安装COPILOT chat 薅github羊毛，docker_hub 镜像在https://hub.docker.com/r/jsdfhasuh/my_code_server

## 使用步骤

1. **构建 Docker 镜像**：在 Dockerfile 所在的目录下运行以下命令：

```bash
docker build -t ubuntu-vscode .
```

这将创建一个名为 `ubuntu-vscode` 的 Docker 镜像。

2. **运行 Docker 容器**：使用以下命令运行 Docker 容器：

```bash
docker run -it ubuntu-vscode
```

这将启动一个新的 Docker 容器，并在其中打开一个交互式终端。

本项目下面的requirement是pip requirement


环境变量：
PORT 端口
WORKSPACE 工作路径

挂载路径：
/home/vscodeuser  vscode的存储插件的路径
/workspace   开发代码区域


3. nginx SSL 配置（别问我为什么是这样的）
# my code server
server {
          listen 8553 ssl;
          server_name *;
          
          charset utf-8;
               
          ssl_certificate *.pem;
          ssl_certificate_key *.key;
          access_log /log/vscode.log django_foramt;

	location / {

		proxy_pass http://192.168.1.40:80/; 
		auth_basic "Restricted Access";
        auth_basic_user_file /passwd/.htpasswd;

		proxy_set_header X-Real-IP $remote_addr;

		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

		proxy_set_header Host $http_host;

		proxy_set_header X-NginX-Proxy true;

		proxy_http_version 1.1;

		proxy_set_header Upgrade $http_upgrade;

		proxy_set_header Connection "upgrade";

		proxy_redirect off;

	}
}