# NOAA HPCC Incubator project: cloud testing for bioinformatics

## Collaborators

* Krista Nichols
* Giles Goetz
* Kyle O'Connell
* Ramiya Sivakumar
* Eric Anderson
* Luke Thompson

## OVERVIEW
This project was funded in FY23 by the [NOAA High Performance Computing and Communications (HPCC)  Program](https://www.noaa.gov/information-technology/hpcc) to test the feasibility, cost, and efficiency of conducting bioinformatics in the cloud. 

## Introduction & objectives
With the [NOAA ‘Omics Strategic Plan](https://sciencecouncil.noaa.gov/wp-content/uploads/2022/08/Omics-Strategic-Plan_Final-Signed.pdf), the generation and analysis of large molecular (DNA, RNA) and chemical (metabolites, proteins) data is recognized as a NOAA mission priority. These types of data are rapidly advancing the field of fisheries and biological oceanography and are a crucial component of systems-level understanding of marine habitats, species diversity, and population dynamics. ‘Omics data sets consist of large raw and processed data files that require substantial storage space and computational processing power. Importantly, the requirements for ‘Omics workflows are distinct from those of mathematical simulations such as weather modeling. ‘Omics computational resources ideally have a flexible architecture that can accommodate both highly-parallel, low-memory processes as well as low-node count, high memory processes. Local on-premise servers built for bioinformatics demands have been important upgrades in NOAA computational capacity, but as ‘Omics projects expand in scope, individual servers may not meet the expanding scientific needs. Cloud computing could overcome resource challenges and represents a potential long-term solution to meet some of the scientific needs defined in the ‘Omics Strategic Plan. 
This project will tested the feasibility of running ‘Omics analyses in a cloud environment, and compared the cost and effort with those of on-premise HPC. ‘Omics bioinformatic workflows were conducted in parallel (i.e, in the cloud and on-premise), representing major areas of NOAA ‘Omics research: (1) DNA metabarcoding, (2) shotgun metagenome-assembled genome (MAG) binning, (3) transcriptome assembly and annotation, and (4) whole genome assembly, alignment, and variant calling. 

Detailed documentation of required storage space, processing power, and time spent on installation and troubleshooting will provide a roadmap for evaluating cloud vs. on-premise computing, which in the long-term plan will identify the most effective means for storage and analysis of ‘Omics datasets. The final report from this project may be found here, and repositories used for analyses are linked below.

## Project Repositories

| Repository     | Cloud testing code   |  Description          | Data input(s) | Contact author(s)  | 
|---------|---------|---------|---------|---------|
| [mega-non-model-wgs-snakeflow](https://github.com/eriqande/mega-non-model-wgs-snakeflow) | | With low coverage whole genome sequence data from multiple individuals, performs genome alignment through variant calling. | WGS data, in this example from ~30 rockfish samples | @eriqande |
| | | | | |
| | | | | |
| | | | | |


# Disclaimer

This repository is a scientific product and is not official communication of the National Oceanic and Atmospheric Administration, or the United States Department of Commerce. All NOAA GitHub project content is provided on an "as is" basis and the user assumes responsibility for its use. Any claims against the Department of Commerce or Department of Commerce bureaus stemming from the use of this GitHub project will be governed by all applicable Federal law. Any reference to specific commercial products, processes, or services by service mark, trademark, manufacturer, or otherwise, does not constitute or imply their endorsement, recommendation or favoring by the Department of Commerce. The Department of Commerce seal and logo, or the seal and logo of a DOC bureau, shall not be used in any manner to imply endorsement of any commercial product or activity by DOC or the United States Government.

## License
This content was created by U.S. Government employees as part of their official duties. This content is not subject to copyright in the United States (17 U.S.C. §105) and is in the public domain within the United States of America. Additionally, copyright is waived worldwide through the MIT License.

<img src="https://raw.githubusercontent.com/nmfs-fish-tools/nmfspalette/main/man/figures/noaa-fisheries-rgb-2line-horizontal-small.png" width="200" style="height: 75px !important;"   alt="NOAA Fisheries Logo">


 [U.S. Department of Commerce](https://www.commerce.gov/) | [National Oceanographic and Atmospheric Administration](https://www.noaa.gov) | [NOAA Fisheries](https://www.fisheries.noaa.gov/)


