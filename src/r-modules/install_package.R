# installation script for R packages; pass CRAN URL, install dir, package name,
# and config opts as arguments.
args<-commandArgs(TRUE)
repos<-getOption("repos"); repos["CRAN"]=args[1]; options(repos=repos)
configOpts<-setNames(c(args[4]),c(args[3]))
install.packages(args[3], lib=args[2], configure.args=configOpts)
