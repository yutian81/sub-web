#!/bin/sh

INDEX_FILE='/usr/share/nginx/html/index.html'
CONFIG_JSON='{}'

# 检查运行时环境变量是否存在
if [ -n "$VUE_APP_TWIKOO_SRC" ] && [ -n "$VUE_APP_TWIKOO_ENVID" ]; then
  echo "Twikoo 环境变量已设置，启用评论功能。"
  CONFIG_JSON="{\"VUE_APP_TWIKOO_SRC\":\"$VUE_APP_TWIKOO_SRC\",\"VUE_APP_TWIKOO_ENVID\":\"$VUE_APP_TWIKOO_ENVID\"}"
else
  echo "Twikoo 环境变量未设置，禁用评论功能。"
fi

# 替换index.html中的占位符 __VUE_APP_CONFIG__
sed -i "s|__VUE_APP_CONFIG__|${CONFIG_JSON}|g" $INDEX_FILE
echo "配置注入完成。启动 Nginx..."

# 执行 Nginx 的主命令
exec nginx -g 'daemon off;'
