# source me with 
#     . a.sh


# Lazy edit, make, run
alias f="vim main.s && make && make run"

# lazy git
g () {
  if [[ -z $@ ]] 
  then
    msg="."
  else
    msg="$@"
  fi
  git add . && \
    git commit -m"$msg" && \
    git push
}
