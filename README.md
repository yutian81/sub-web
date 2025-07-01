# sub-web

修改自[肥羊的前端](https://github.com/youshandefeiyang/sub-web-modify)，主要不同点：

- 去除了的弹窗和提示信息
- 修改了前端网页的logo
- 修改了前端网页的背景图片
- 修改了夜间模式的显示效果
- 加入了我自己的后端和转换配置文件

后端采用[asdlokj1qpi233大佬](https://github.com/asdlokj1qpi233/subconverter)的版本，部署在爪云容器

## 部署方法

### 后端部署

**compose 直接部署**

```yaml
services:
  subconverter:
    image: asdlokj1qpi23/subconverter:latest
    container_name: subconverter
    ports:
      - "25500:25500"
    restart: always
```

### 前端部署

**【推荐】部署到 Vercel**

fork 本仓库，登录 vercel 链接仓库直接部署即可

**Docker一键部署**

我没有制作镜像，可以使用肥羊的镜像

```
docker run -d --restart unless-stopped --privileged=true -p 8090:80 --name sub-web-modify youshandefeiyang/sub-web-modify
```

## 前端访问示例

```
http://192.168.10.1:8090/?backend=https://url.v1.mk
```

## 效果预览：
![avatar](https://raw.githubusercontent.com/youshandefeiyang/webcdn/main/sub-web-modify.GIF)
