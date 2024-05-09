#!/bin/bash

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

virtual_env() {
	mkdir $1 &&
		cd $1 &&
		virtualenv .venv &&
		source .venv/bin/activate
}

ffuf_subdomain() {

	ffuf -c -t 5 -rate 20 -p 0.2 \
		-H "User-Agent: $AGENT" -o $NAME_domains.json -of json \
		-H "Host: FUZZ.$DOMAIN" \
		-mc 200,403,401,503,500,302 -w $1 -u http://$DOMAIN/ $2
}

ffuf_directory() {

	ffuf -c -t 10 -rate 20 -p 0.2 -H "User-Agent: $AGENT" \
		-ac -mc 200,302,422,403,401,301 \
		-w $2 \
		-u http://$1/FUZZ $3


}

# $1 - SITE
# $2 - wordlist
# $3 - additional arguement

ffuf_recursive() {
	mkdir -p recursive
	dom=$(echo $1 | unfurl format %s%d)
	ffuf -c -rate 20 -p 0.3 -t 5 -v -u $1/FUZZ -w $2 \
		-H "User-Agent: Firefox" \
		-H "X-Bug-Bounty: rez0"
	-recursion -recursion-depth 5 \
		-mc all -ac \
		-o recursive/recursive_$dom.csv -of csv $3
}

ffuf_all() {
	mkdir -p all
	xargs -P5 -I {} sh -c 'dom=$(echo {} | unfurl format %s%d);ffuf -c -u {}/FUZZ -w quick.txt -rate 15 -p 0.2 -t 10 -mc all -ac -o all/all_$dom.csv -of csv -maxtime 600 -v' <$1
}

ffuf_basicauth() {
	dom=$(echo $1 | unfurl format %s%d)
	ffuf -c -v -u $1 -w basic_auth.txt \
		-H "Authorization: Basic FUZZ" \
		-ac -mc all \
		-o basicauth_$dom.csv -of csv $2
}

ffuf_view() {
	find -name "*.csv" -exec cat {} \; |
		sed 's/,/ /g' |
		sort -k 5,5 -u -n |
		vim -
}

ffuf_cols() {
	find -name "*.csv" | xargs cat |
		cut -d, -f2,4- | awk -F, '$3==200' |
		awk -F, 'BEGIN { OFS=FS }; { $1=substr($1, 1, 110); print }' |
		sort -t, -k 4,4 -n -u | column -s, -t | vim -
}
