## Running whole genome variant calling on Google Cloud
Following established protocols for this workflow, we ran the workflow end to end using Snakemake v.7.32.4 with the Sedna profile distributed with the GitHub repository. To make this work, we had to copy the data to the local home directory, requiring a large capacity high performance drive to be mounted which increases the overall cost of analysis. We also tested Snakemake v.8.14.0 using the Slurm executor without the Sedna profile, as well as the Google Cloud Storage plugin.
We used the following command:
```
snakemake --profile hpcc-profiles/slurm/sedna --configfile config/config.yaml
```

We also 'unsuccessfully' tested Snakemake v.8 with executor plugins like this: 
```
snakemake --configfile config/config.yaml --storage-gcs-project <PROJECT ID> --default-storage-provider gcs --default-storage-prefix gcs://<BUCKET PATH>/mega-non-model-wgs-snakeflow --executor slurm --default-resources slurm_partition=compute --jobs 1200
```
