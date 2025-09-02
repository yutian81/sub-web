# sub-web 带twikoo评论功能

修改自[肥羊的前端](https://github.com/youshandefeiyang/sub-web-modify)，主要不同点：

- 去除了的弹窗和提示信息
- 修改了前端网页的logo
- 修改了前端网页的背景图片
- 修改了暗黑模式的显示效果
- 加入了我自己的后端和转换配置文件
- 加入Twikoo评论模块并适配暗黑模式

预览图

![image.png](https://b2qq.24811213.xyz/2025-07/1753666376-image.webp)

![image.png](https://b2qq.24811213.xyz/2025-07/1753666439-image.webp)

后端采用[asdlokj1qpi233大佬](https://github.com/asdlokj1qpi233/subconverter)的版本，部署在爪云容器

## 部署方法

**详见[博客教程](https://blog.811520.xyz/post/2025/07/250728-subweb-twikoo/)**

## 后端部署

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

## 前端部署

### 【推荐】部署到 Vercel

**方法一: 使用环境变量**

- Fork 本仓库，包含test分支
- 登录vercel，链接仓库的test分支
- 设置环境变量
  - VUE_APP_TWIKOO_SRC=https://cdn.jsdelivr.net/npm/twikoo@1.6.44/dist/twikoo.all.min.js
  - VUE_APP_TWIKOO_ENVID=https://twikoo.backend.com

**方法二: 硬编码到代码中**

- 修改 `src/views/Subconverter.vue` 文件约 `1417` 行，将 `envID` 替换为你自己部署的地址

```js
envId: 'https://twikoo.backend.com/',  // 此处替换为你自己额 twikoo 地址
```

- 登录 Vercel 链接 fork 的仓库，以默认参数直接部署，无需设置环境变量

**既未改代码也未设置环境变量，则不启用评论功能**

### Docker一键部署

**启用评论功能**

```yml
services:
  sub-web-modify:
    restart: unless-stopped
    ports:
      - "8090:80"
    container_name: sub-web-modify
    image: ghcr.io/yutian81/sub-convert:latest
    environment:
      - VUE_APP_TWIKOO_SRC=https://cdn.jsdelivr.net/npm/twikoo@1.6.44/dist/twikoo.all.min.js
      - VUE_APP_TWIKOO_ENVID=https://twikoo.backend.com
```

运行docker compose: `docker compose up -d`


**不启用评论功能**

可以直接使用肥羊的镜像

```yaml
name: sub-web-modify
services:
  sub-web-modify:
    restart: unless-stopped
    privileged: false
    ports:
      - 8090:80
    container_name: sub-web-modify
    image: youshandefeiyang/sub-web-modify
```

**也可以使用我的镜像**

```yml
services:
  sub-web-modify:
    restart: unless-stopped
    ports:
      - "8090:80"
    container_name: sub-web-modify
    image: ghcr.io/yutian81/sub-convert:latest
```

## 前端访问示例

```
http://192.168.10.1:8090/?backend=https://url.v1.mk
```
