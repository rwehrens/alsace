\name{correctRT}
\alias{correctRT}
\title{Retention time correction for ALS chromatographic profiles}
\description{
  Correction of retention time differences of ALS concentration profiles
  using parametric time warping.
}
\usage{correctRT(CList, reference,
                 what = c("corrected.values", "models"),
                 init.coef = c(0, 1, 0), ...)}
\arguments{
  \item{CList}{List of matrices containing concentration profiles.}
  \item{reference}{Index of the sample that is to be considered the
    reference sample.}
  \item{what}{What to return: either the time-corrected profiles (useful
    for visual inspection) or the warping models (for further
    programmatic use).}
  \item{init.coef}{Starting values for the optimisation.}
  \item{\dots}{Optional arguments for the \code{ptw} function. The only
    argument that cannot be changed is \code{warp.type}: this is always
    equal to \code{"global"}.}
}
\value{A list of warped concentration profiles, mirroring the
  \code{CList} list element from the ALS object.}
\author{Ron Wehrens}
\seealso{\code{\link{ptw}}, \code{\link{correctPeaks}}}
\examples{
data(teaMerged)
CList.corrected <- correctRT(teaMerged$CList, reference = 2)

original.profiles <- sapply(teaMerged$CList, identity, simplify = "array")
corrected.profiles <- sapply(CList.corrected, identity, simplify = "array")

def.par <- par(no.readonly = TRUE)
par(mfrow = c(2,4))
for (i in 1:4)
    matplot(dimnames(original.profiles)[[1]],
            original.profiles[,i,], type = "l", lty = 1,
            xlab = "Time (min.)", ylab = "Response",
            main = paste("Component", i))
for (i in 1:4)
    matplot(dimnames(original.profiles)[[1]],
            corrected.profiles[,i,], type = "l", lty = 1,
            xlab = "Time (min.)", ylab = "Response",
            main = paste("Component", i, "- warped"))
par(def.par) ## reset defaults
}
\keyword{manip}
