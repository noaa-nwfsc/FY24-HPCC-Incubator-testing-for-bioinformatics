## Tourmaline methods
We ran Tourmaline workflow with docker interactively: 
```
sudo docker run -v $HOME:/data -it aomlomics/tourmaline /bin/bash -c "sh run_tourmaline"
```
Where the run_tourmaline script contained the necessary snakemake commands to run the workflow with --jobs 30 (the workflow only uses up to 8 CPUs per rule) and conda as software deployment method. 

Our virtual machine was a n2-standard-16 (16 CPUs, 64 GB RAM) which uses Intel Cascade Lake processors and represents the newest general purpose processors. 

