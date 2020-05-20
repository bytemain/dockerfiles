# 一键 V2ray websocket + TLS

参考：

- <https://github.com/pengchujin/v2rayDocker>
- <https://github.com/nagaame/v2rayDocker>

## 使用

将 `.env.example` 重命名为 `.env`，修改里面的内容。

`YUMING` 里面写你解析到服务器的域名。

`UUID` 可选，不填的话每次重启容器都会重置链接，填了之后每次就一样了。  
可以在网上找一个 UUID 生成器，复制一个填进去就行。

`PORT_80` 容器的 80 端口映射到主机的端口号

`PORT_443` 容器的 443 端口映射到主机的端口号

## 控制

启动：

```sh
docker-compose up -d

# 启动后查看订阅链接
docker-compose logs v2ray_ws
```

停止：

```sh
docker-compose down
```
