\name{getSymbols.cfe}
\alias{getSymbols.cfe}
\title{Load Data from the CBOE Futures Exchange website...}
\usage{getSymbols.cfe(Symbols, Month, Year, from="2004-06-01", to=Sys.Date(),
    nonzero.close=TRUE, rescale=TRUE, env, return.class="xts",
    index.class="Date", ...)}
\description{Load Data from the CBOE Futures Exchange website}
\details{Download \code{Symbols} to specified \code{env} from \sQuote{cfe.cboe.com}. This method is 
not to be called directly; instead, a call to \code{getSymbols(symbols, src='cfe')} will in
turn call this method. This is a wrapper to get end-of-day historical data for the futures 
that are, or have been, listed on the CBOE Futures Exchange.

\code{Symbols} can be a vector of symbols formatted like VX_U11, or GV_M10.  Alternatively, the
symbol roots can be used (e.g. 'VX', 'GV') and values can be provided for Month and Year.
If roots are provided, but \code{Year} and \code{Month} is \code{NULL}, 
the current year as reported by \code{Sys.Date()} will be used, and either the current month
or, for "VT" (which is the only quarterly contract), the month of the end of the last quarter.
See examples. 

The raw data will contain zero values for the first few rows. Also, the last row will have
zeros in every column except the \sQuote{Settle} column. By default, these rows, along with
any other rows that have a zero Close price will be removed.  If you would like to keep these rows
(e.g. if you need the final settlement value) use \code{nonzero.close=FALSE}. 

On March 26, 2007, The prices of VX and DV futures contracts were rescaled (divided by 10)
\dQuote{to bring the traded futures contract prices in line with the underlying index values...}
If \code{rescale=TRUE} (Default) prices for these instruments from prior to March 26, 2007 will
be divided by 10 ("rescaled").  See References.}
\value{will load data into the specified environment -- one object for each file downloaded.}
\author{Garrett See, based on Jeff Ryan's quantmod framework}
\references{\url{http://cfe.cboe.com/Data/HistoricalData.aspx#VT}

\url{http://cfe.cboe.com/framed/PDFframed.aspx?content=/publish/CFEinfocirc/CFEIC07-003\%20.pdf&sectionName=SEC_ABOUT_CFE&title=CBOE\%20-\%20CFEIC07-003\%20Rescaling\%20of\%20VIX\%20and\%20VXD\%20Futures\%20Contracts}}
\seealso{\code{\link{remove_zero_rows}} for removing rows where a column has zero values.  

\code{getSymbols}, \code{setSymbolLookup}}
\section{TODO}{Add suffix.format arg for making symbols
Add support for reading suffix_ids with 1 digit years, and/or 3 letter month codes.}
\note{Currently listed contracts:
VIX Futures (VX), Mini-VIX Futures (VM),
CBOE S&P 500 3-Month Variance Futures (VT),
CBOE Gold ETF Volatility Index Futures (GV)

Delisted contracts: "DV","BX","VN","VR","VA"}
\arguments{\item{Symbols}{vector of names of instruments formated like e.g. "VX_U09", "GV_Z10", etc. OR 
if \code{Month} and \code{Year} are provided a vector of names of root symbols, eg. "VX","GV",etc.}
\item{Month}{optional vector of months. Can be numerical or the names of the months in English. If any 
element of \code{Symbols} contains an underscore, this will be ignored.}
\item{Year}{optional vector of years. Can either be 2 or 4 digits each. If any element of \code{Symbols} 
contains an underscore, this will be ignored.}
\item{from}{retrieve data no earlier than this data (2004-06-01)}
\item{to}{retrieve data through this data (Sys.Date())}
\item{nonzero.close}{if \code{TRUE} rows where \sQuote{Close} is zero will be removed.}
\item{rescale}{Should data from before March 26, 2007 be adjusted? See Details and References. Only applicable if \code{Symbols} is "VX" or "DV".}
\item{env}{where to create objects (.GlobalEnv)}
\item{return.class}{class of returned object}
\item{index.class}{class of returned object index (xts only)}
\item{\dots}{additional arguments}}
\examples{\dontrun{
getSymbols(c("VX_U11", "VX_V11"),src='cfe')
#all contracts expiring in 2010 and 2011.
getSymbols("VX",Month=1:12,Year=2010:2011,src='cfe') 
#getSymbols("VX",Month=1:12,Year=10:11,src='cfe') #same
#The contracts expiring this month:
getSymbols(c("VM","GV"),src='cfe')

setSymbolLookup(VX='cfe') #so we don't have to specify src anymore
getSymbols("VX",Month=1:3,Year=2005)
}}