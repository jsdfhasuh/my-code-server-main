# Dockerfile 使用说明

这个 Dockerfile 用于创建一个基于 Ubuntu 的 Docker 镜像，并在其中安装 Visual Studio Code。

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