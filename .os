OS=""
case "$OSTYPE" in
  darwin*)  OS="macos" ;; 
  linux*)   OS="linux" ;;
  bsd*)     OS="bsd" ;;
  *)        OS="unknown" ;;
esac

export OS
