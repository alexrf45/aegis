extract() {
  if [ -f $1 ]; then
    case $1 in
    *.tar.bz2) tar xjf $1 ;;
    *.tar.gz) tar xzf $1 ;;
    *.bz2) bunzip2 $1 ;;
    *.rar) rar x $1 ;;
    *.gz) gunzip $1 ;;
    *.tar) tar xf $1 ;;
    *.tbz2) tar xjf $1 ;;
    *.tgz) tar xzf $1 ;;
    *.zip) unzip $1 ;;
    *.Z) uncompress $1 ;;
    *) echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

up() {
  LIMIT=$1
  P=$PWD

  echo "Moving $LIMIT directories up from $P"

  for ((i = 1; i <= LIMIT; i++)); do
    P=$P/..
  done
  cd $P
}

virtual_env() {
  mkdir $1 &&
    cd $1 &&
    virtualenv .venv &&
    source .venv/bin/activate
}

webserver() {
  miniserve \
    -t "fr3d" \
    -v \
    -F \
    -H \
    -c monokai \
    -p 9443 \
    --header "Cache-Control:no-cache" \
    --header "Server: Server" \
    --header "X-Frame-Options: DENY" \
    --header "Referrer-Policy: strict-origin-when-cross-origin" \
    --header "Content-Type: text/html; charset=UTF-8" \
    --header "Strict-Transport-Security: max-age=63072000; includeSubDomains; preload" \
    --header "Permissions-Policy: geolocation=(), camera=(), microphone=(), bluetooth=(), usb=(), payment=(), display-capture=()" \
    --auth-file ./auth.txt \
    --tls-cert $HOME/.local/$1-cert.pem \
    --tls-key $HOME/.local/$1-key.pem \
    -u
}

cert-gen() {
  mkcert -key-file $HOME/.local/$1-key.pem -cert-file $HOME/.local/$1-cert.pem localhost
}
