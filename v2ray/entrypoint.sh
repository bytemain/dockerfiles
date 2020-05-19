#!/bin/bash
domain="$1"
psname="$2"

if  [ ! "$3" ] ;then
    uuid=$(uuidgen)
    echo "uuid 将会系统随机生成"
else
    uuid="$3"
fi
cat > /etc/Caddyfile <<EOF
domain
{
  log ./caddy.log
  proxy /one :2333 {
    websocket
    header_upstream -Origin
  }
}
EOF
sed -i "s/domain/${domain}/" /etc/Caddyfile

# v2ray
cat > /etc/v2ray/config.json <<EOF
{
  "inbounds": [
    {
      "port": 2333,
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "uuid",
            "alterId": 64
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {
        "path": "/one"
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "settings": {}
    }
  ]
}

EOF

sed -i "s/uuid/${uuid}/" /etc/v2ray/config.json

cat > /srv/sebs.json <<'EOF'
{
  "add":"domain",
  "aid":"0",
  "host":"",
  "id":"uuid",
  "net":"ws",
  "path":"/one",
  "port":"443",
  "ps":"sebsclub",
  "tls":"tls",
  "type":"none",
  "v":"2"
}
EOF

if [ "$psname" != "" ] && [ "$psname" != "-c" ]; then
  sed -i "s/sebsclub/${psname}/" /srv/sebs.json
  sed -i "s/domain/${domain}/" /srv/sebs.json
  sed -i "s/uuid/${uuid}/" /srv/sebs.json
else
  $*
fi

cp /etc/Caddyfile .
nohup caddy  --log stdout --agree=true &
echo "配置 JSON 详情"
echo " "
cat /etc/v2ray/config.json
echo " "
node v2ray.js
/usr/bin/v2ray -config /etc/v2ray/config.json
