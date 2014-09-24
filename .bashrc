

SEP="\e[0;32m#\e[m"
AT="\e[0;32m@\e[m"
export PS1="$SEP \u$AT\h $SEP \t $SEP \j $SEP \w $SEP\n\$"


alias ll='ls -l -G'
alias la='ls -la -G'

alias st='open -a Sublime\ text\ 2'

function myman
{
	man -t $1 | open -f -a /Applications/Preview.app
}

function gitinfo
{
	FILES=`git ls-tree --name-only HEAD .`
	MAXLEN_FILE=0
	for f in $FILES; do
		if [ ${#f} -gt $MAXLEN_FILE ]; then
			MAXLEN_FILE=${#f}
		fi
	done

	# f : file name - padded with printf
	# str : timestamp
	# str2 : all the fuck
	for f in $FILES; do
		str=$(git log -1 --decorate --pretty=format:"%C(green)%cr%Creset" $f)
		str2=$(git log -1 --decorate --pretty=format:"%C(cyan)%h%Creset %C(yellow)(%cn)%Creset" $f)
		commitMsg=$(git log -1 --decorate --pretty=format:"%s" $f)
		printf "%-${MAXLEN_FILE}s -- %s \t %-42s %s\n" "$f" "$str" "$str2" "$commitMsg"
	done

}



archey -c


