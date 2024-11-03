function nonzero_return() {
	RETVAL=$?
	[ $RETVAL -ne 0 ] && echo -e "\e[2m\$?: $RETVAL\e[0m "
}

function status_line() {
	nr=`nonzero_return`
	sl="$nr"
	if [ ! "$sl" == "" ]; then
		printf "\n$sl"
	fi
}

export PS1="\`status_line\`\n\w \$ "

