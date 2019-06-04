curl -L -O https://github.com/gohugoio/hugo/releases/download/v0.55.6/hugo_0.55.6_Linux-64bit.tar.gz
tar -xzf hugo_0.55.6_Linux-64bit.tar.gz

mkdir -p ./tmp
echo "baseURL = \"https://triangulo.dev/\"" >> ./tmp/config.toml

./hugo --config config.toml,./tmp/config.toml
