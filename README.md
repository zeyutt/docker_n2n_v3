# docker_n2n_v3
全部基于docker使用n2n-v3搭建虚拟局域网，提供的服务端，客户端的docker image，使用actions自动编译推送，具体发布版请在Package中寻找ghcr.io镜像地址。注意：(use docker to deploy n2n supernode on your own cloud server and get a private virtual intranet for your machines) 
## proxy 加速
在`/etc/docker/daemon.json`的[registry-mirrors]字段添加 "https://ghcr.nju.edu.cn" , 记得需要`sudo systemctl daemon-reload && sudo systemctl restart docker` 来重启docker
## supernode 启动
``` bash
# 记得保证你的N2N_PORT已经添加到防火墙准入规则
N2N_PORT=31119 
docker run -d \
  --name SuperNode \
  -p $N2N_PORT:$N2N_PORT/udp \
  -p $N2N_PORT:$N2N_PORT/tcp \
  -e type=supernode \
  -e listenport=$N2N_PORT \
  --restart=unless-stopped \
  zeyutt/docker_n2n_v3:latest
```
## edge 启动
``` bash
# 务必自定义修改以下变量
ServerIP=? # 填入supernode宿主机的IP地址
EDGE_IP=10.100.0.11
COMMUNITY=my_comm
COMMUNITY_KEY=Not_n2n_Default

docker run -d \
  --privileged \
  --net=host \
  --name edge0 \
  -e type=edge \
  -e interfaceaddress=$EDGE_IP \
  -e communityname=$COMMUNITY \
  -e Encryptionkey=$COMMUNITY_KEY \
  -e supernodenet=$ServerIP:$N2N_PORT\
  zeyutt/docker_n2n_v3:latest
```

## 🔒 ​网络安全提醒与免责声明​
### ⚠️ ​安全警示​
​风险自担​：本软件按“原样”提供，开发者及贡献者不承担因使用、误用或配置不当导致的任何直接/间接损失（包括数据泄露、服务中断等）。
​漏洞风险​：开源软件可能存在未知安全缺陷，用户应自行评估风险，必要时进行安全审计或渗透测试。
​网络暴露​：部署服务可能暴露于公网攻击，请确保：
- 启用防火墙规则
- 定期更新至最新版本
- 避免使用弱密码或默认凭证
### 📜 ​免责条款​
​责任限制​：开发者不对功能的完整性、适用性或安全性作任何明示/暗示的担保。
​合法使用​：用户需确保遵守所在国家/地区的法律法规，​禁止用于非法活动​（如网络攻击、数据窃取等）。
​第三方依赖​：本软件可能依赖其他开源组件，其安全性请参考各自官方声明。
### 🛡️ ​用户义务​
​主动防护​：定期监控日志、备份数据、隔离生产环境。
​社区支持​：问题反馈请通过Issues提交，​不提供实时应急响应。
