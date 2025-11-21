# Epidemic-models-simulation-inference
Lecture materials for epidemic models and inference. 

## Datasets

Some example datasets, under the `datasets` folder. 

The first three datasets are real data. Last two are simulated based on features of real-world datasets (that are private and cannot share). 

### JHU Covid-19 time series data

US case counts and death counts data downloaded from [this public repository](https://github.com/CSSEGISandData/COVID-19/tree/master/csse_covid_19_data/csse_covid_19_time_series). 
Please read their documentation for description. 

### Ebola outbreak data from Guinea

Population-level weekly incidence counts (probable & confirmed cases) from different prefectures in Guinea for the 2013-2015 Ebola outbreak. 

Datasets from [this paper](https://doi.org/10.1214/25-AOAS2048); 
processed data in other formats also available from this [Github repo](https://github.com/rmorsomme/PDSIR). 

### Ebola outbreak data from Demographic Republic of the Congo

Patient-level Ebola outbreak data, accessed from [this paper](https://doi.org/10.1038/s41598-022-09564-4). This data frame is from wave 3 of the Ebola outbreak. 
More data and information can be found from their [Github repo](https://github.com/wasiur/DSAofEbola/tree/v.2.0.0). 

Each row represents data from each patient. The columns are: 

- `onset`: disease onset time (1 time unit is _probably_ a day); can be used as the infection time under some assumptions.
- `hosp`: removal time (hospitalization, isolation, or death); after this point the individual is considered no longer infectious.
- `event1`: if `onset` time was censored/unobserved (0 = censored, 1 otherwise).
- `event2`: if `hosp` time was censored/unobserved (0 = censored, 1 otherwise).

### Simulated data for a population with group-level effects (two groups)

A simulated dataset from a stochastic SIR-D model on a population with two demographic groups (e.g., younger / older populations) with 
different infection / recovery rates, and cross infections between two groups. You can assume that after infection, an individual either dies or recovers, with a certain recovery/death rate within each group. 

The dataset has daily counts on infections and deaths, with columns: 

 - `I_obs_g0`: observed number of infectious indivduals for group 0
 - `I_obs_g1`: observed number of infectious indivduals for group 1
 - `ObsIncidence_g0`: new observed infection counts from group 0
 - `ObsIncidence_g1`: new observed infection counts from group 1
 - `D_cum_g0`: cumulative deaths in group 0
 - `D_cum_g1`: cumulative deaths in group 1
 - `DeathsDaily_g0`: new deaths in group 0 (true counts, observed + unobserved)
 - `DeathsDaily_g1`: new deaths in group 1
 - `DeathsDailyObs_g0`: new deaths among observed infected individuals in group 0
 - `DeathsDailyObs_g1`: new deaths among observed infected individuals in group 1

As you can probably guess, the observed counts are not necessarily the same as true counts, due to possible under-reporting. 

### Simulated data for flu transmission and contact tracing

A simulated dataset from [this paper](https://www.tandfonline.com/doi/abs/10.1080/01621459.2020.1790376), describing a joint individual-level stochastic SIR process coupled with a link-Markovian 
dynamic network where individuals connect or disconnect their contacts based on disease statuses. The population size is `N=100`. 

It's an RDS file for a list with the following entries: 

- `G0`: the initial network, represented by a symmetric adjacency matrix, in a sparse matrix format
- `I0`: label of the person who is the initial infective at time 0
- `report.times`: the discrete time points where we know the individual disease statuses; we assume we have weekly reports, so it's 0, 7, 14, ...
- `events`: dataframe of events, with the following columns:
    * `time`: time; here each unit is one day
    * `event`: type of event;  1=infection, 2=recovery, 3-5=link connection between two individuals, 6-8=link disconnection between two individuals
    * `per1`, `per2`: labels of the two individuals involved in the event; for example, `per2` infects `per1`, or `per1` and `per2` connects with each other in the contact network.
- `report`: a matrix representing disease statuses of individuals at each reporting time. 0 = healthy and not yet infected; 1 = currently infected; -1 = already recovered.
- `truth`: true parameters used for generating the dataset. The entries are: $\beta$ infection rate; $\gamma$ recovery rate;
   contact link connection rates between healthy-healthy, healthy-infectious, infectious-infectious pairs;
   and disconnection rates between healthy-healthy, healthy-infectious, infectious-infectious pairs. Here we assume both S and R individuals are considered "healthy" for contact network purposes.

## Some code / scripts

Under the `code` folder. The code and scripts are toy examples and for demo only; there could be (well, most likely) bugs. 
