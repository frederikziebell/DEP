% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plot_functions_frequencies.R
\name{plot_cond}
\alias{plot_cond}
\title{Plot frequency of significant conditions per protein
and the overlap in proteins between conditions}
\usage{
plot_cond(dep, plot = TRUE)
}
\arguments{
\item{dep}{SummarizedExperiment,
Data object for which differentially enriched proteins are annotated
(output from \code{\link{test_diff}()} and \code{\link{add_rejections}()}).}

\item{plot}{Logical(1),
If \code{TRUE} (default) the barplot is produced.
Otherwise (if \code{FALSE}), the data which the
barplot is based on are returned.}
}
\value{
A histogram (generated by \code{\link[ggplot2]{ggplot}})
}
\description{
\code{plot_cond} generates a histogram of
the number of proteins per condition and stacks for overlapping conditions.
}
\examples{
# Load example
data <- UbiLength
data <- data[data$Reverse != "+" & data$Potential.contaminant != "+",]
data_unique <- make_unique(data, "Gene.names", "Protein.IDs", delim = ";")

# Make SummarizedExperiment
columns <- grep("LFQ.", colnames(data_unique))
exp_design <- UbiLength_ExpDesign
se <- make_se(data_unique, columns, exp_design)

# Filter, normalize and impute missing values
filt <- filter_missval(se, thr = 0)
norm <- normalize_vsn(filt)
imputed <- impute(norm, fun = "MinProb", q = 0.01)

# Test for differentially expressed proteins
diff <- test_diff(imputed, "control", "Ctrl")
dep <- add_rejections(diff, alpha = 0.05, lfc = 1)

# Plot histogram with overlaps
plot_cond(dep)
}
