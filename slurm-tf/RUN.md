# Usage

To build the slurm cluster, modify the blueprint to your specs. Then use `ghpc` to execute the Terraform file build.

```shell
./ghpc create hpc-test.yaml -l ERROR --vars project_id=nmfs-nwfsc-hpc-toolkit-1
./ghpc deploy [deployment name]
```

`hpc-test.yaml`: The blueprint file used by `ghpc`.

`[deployment name]`: Replace the deployment name with name of you have set in the blueprint.
