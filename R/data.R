#' ASL Data Illustration
#'
#' A dataset containing age, sex, length samples.
#'
#' @format A data frame with  11 variables:
#' \describe{
#'   \item{Year}{year of sample}
#'   \item{Pop}{population sampled}
#'   \item{Grp_Area}{area grouping for the population}
#'   \item{Date}{sample date}
#'   \item{}{}
#'   ...
#' }
#' @source Dummy Data
"SPATData_Samples"




#' Environmental Covariates Data Illustration
#'
#' A dataset containing observed recruits/spawner and various environmental covariates used in the 2019 Forecast for 
#' Fraser River Sockeye Salmon (REF).IMPORTANT NOTE: Time series are not lined up based on plausible mechanism (e.g. sea surface temp may affect overall productivity during early ocean entry, but RpEff values are by brood year. Stock-specific offsets are required to align values properly. INCLUDE LIST!
#'
#' @format A data frame with  30 variables:
#' \describe{
#'   \item{year}{year of observation for environmental covariates, brood year for productivity series}
#'   \item{aflow}{April flow}
#'   \item{mflow}{May flow}
#'   \item{jflow}{June flow}
#'   \item{peak}{Peak discharge Details TBI}
#'   \item{apesst}{April Sea Surface Temp at Entrance Island Details TBI}
#'   \item{maesst}{May Sea Surface Temp at Entrance Island Details TBI}
#'   \item{jnesst}{June Sea Surface Temp at Entrance Island Details TBI}
#'   \item{apsst}{April Sea Surface Temp at Pine Island Details TBI}
#'   \item{mapsst}{May Sea Surface Temp at Pine Island Details TBI}
#'   \item{jnpsst}{June Sea Surface Temp at Pine Island Details TBI}
#'   \item{jlpsst}{July Sea Surface Temp at Pine Island Details TBI}
#'   \item{pdo}{Pacific Decadal Oscillation Details TBI}
#'   \item{stn2js}{Station 2  Details TBI}
#'   \item{stn2ja}{Station 2  Details TBI}
#'   \item{Birk}{Observed productivity of Birkenhead sockeye (Recruits/Effective Female)}
#'   \item{Bowr}{Observed productivity of Bowron sockeye (Recruits/Effective Female)}
#'   \item{Chil}{Observed productivity of Chilki sockeye (Recruits/Effective Female)}
#'   \item{Cult}{Observed productivity of Cultus sockeye (Recruits/Effective Female)}
#'   \item{EStu}{Observed productivity of Early Stuart sockeye (Recruits/Effective Female)}
#'   \item{Fenn}{Observed productivity of Fennel sockeye (Recruits/Effective Female)}
#'   \item{Gate}{Observed productivity of Gates sockeye (Recruits/Effective Female)}
#'   \item{Harr}{Observed productivity of Harrison sockeye (Recruits/Effective Female)}
#'   \item{LShu}{Observed productivity of Late Shuswap sockeye (Recruits/Effective Female)}
#'   \item{LStu}{Observed productivity of Late Stuart sockeye (Recruits/Effective Female)}
#'   \item{Nadi}{Observed productivity of Nadina sockeye (Recruits/Effective Female)}
#'   \item{Port}{Observed productivity of Portage sockeye (Recruits/Effective Female)}
#'   \item{Ques}{Observed productivity of Quesnel sockeye (Recruits/Effective Female)}
#'   \item{Raft}{Observed productivity of Raft sockeye (Recruits/Effective Female)}
#'   \item{Scot}{Observed productivity of Scotch sockeye (Recruits/Effective Female)}
#'   \item{Sey}{Observed productivity of Seymour sockeye (Recruits/Effective Female)}
#'   \item{Stell}{Observed productivity of Stellako sockeye (Recruits/Effective Female)}
#'   \item{Upit}{Observed productivity of Upper Pitt sockeye (Recruits/Effective Female)}
#'   \item{Weav}{Observed productivity of Weaver sockeye (Recruits/Effective Female)}
#'   \item{}{}
#'   ...
#' }
#' @source Include REF
"SPATData_EnvCov"





