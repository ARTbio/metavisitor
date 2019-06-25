## Input data for Use Case 3-3

As for the previous Use Cases, the first step is to collect all input data in an history that we will name `Input data for Use Case 3-3`. 

- Create a new history
- Rename this history `Input data for Use Case 3-3`
- Using the tool `Extract reads in FASTA/Q format from NCBI SRA`, we are going to upload 63 paired end datasets.

##### For Ebola virus samples:

- Select the `upload File` tool and click on the "Choose FTP file" button. Select "use_case_3-3_SRR_ebola.txt" from the list and click the "Start" button.
- Use the `Download and Extract Reads in FASTA/Q format from NCBI SRA` tool. Set "List of SRA accession" in "select input type" and enter "use_case_3-3_SRR_ebola.txt" as input. Execute the tool.
- Select `Concatenate multiple datasets tail-to-head`. Change "What type of data do you wish to concatenate?" to "Paired collection", set the collection as input and "Concatenation by pairs" in "What type of concatenation do you wish to perform?".

When you have finishid with the 8 datasets, make sure to change their datatype from `fastq`to `fastqsanger`, and create a dataset collection (as explained in the previous chapter) of these 8 datasets that you will name `Ebola virus`.

##### For Lassa virus samples:

- Upload, Download and Concatenate the Lassa virus datasets the same way as above, but this time use "use_case_3-3_SRR_ebola.txt" as accission list.

When you have finished with the 55 datasets, make sure to change their datatype from `fastq`to `fastqsanger`, and create a dataset collection (as explained in the previous chapter) of these 8 datasets that you will name `Lassa virus`.

- Copy the `vir2 nucleotide BLAST database` from the `References` history to the current history `Input data for Use Case 3-3`.

## History for Use Case 3-3 / Ebola virus
1. Stay in the history `Input data for Use Case 3-3`
- pick the workflow `Metavisitor: Workflow for Use Case 3-3` in the workflows menu. It is possible that the workflow manager complains about settings for the Trinity tool that is used in this workflow. This is a minor issue if happens: just edit the workflow, click on the tool `Trinity` and specify the number of processors accordingly to your computing infrastructure. Save the workflow and select the `run` option.
- Before Step 1, you have to specify some parameters at run time. For Ebola virus, the field `target_virus` has to be filled with `Ebola` and the field `reference_virus` has to be filled with `NC_002549.1` (as a guide for reconstruction of the Ebola virus genome).
- For Step 1, select `Ebola virus`.
- For Step 2, select the `nucleotide vir2 blast database` (this should also be already selected)
- As usual, check the box `Send results to a new history`, edit the name of the new history to `Use Case 3-3 Ebola virus`, and `Execute` the workflow ! Note, that for complex workflows with dataset collections in input, the actual warning that the workflow is started make take time to show up; you can even have a "504 Gateway Time-out" warning. This is not a serious issue: just go in your `User` -> `Saved history` menu, you will see your `Use Case 3-3 Ebola virus` history running and you will be able to access it.

The workflow for Use Case 3-3 may take a long time. Be patient.

## History for Use Case 3-3 / Lassa virus, segment L
1. Stay in the history `Input data for Use Case 3-3`
- pick the workflow `Metavisitor: Workflow for Use Case 3-3` in the workflows menu. It is possible that the workflow manager complains about settings for the Trinity tool that is used in this workflow. This is a minor issue if happens: just edit the workflow, click on the tool `Trinity` and specify the number of processors accordingly to your computing infrastructure. Save the workflow and select the `run` option.
- Before Step 1, you have to specify some parameters at run time. For Lassa virus, the field `target_virus` has to be filled with `Lassa` and the field `reference_virus` has to be filled with `NC_004297.1` (as a guide for reconstruction of the segment L of the Lassa virus genome).
- For Step 1, select `Lassa virus`.
- For Step 2, select the `nucleotide vir2 blast database` (this should also be already selected)
- As usual, check the box `Send results to a new history`, edit the name of the new history to `Use Case 3-3 Lassa virus segment L`, and `Execute` the workflow ! Note, that for complex workflows with dataset collections in input, the actual warning that the workflow is started make take time to show up; you can even have a "504 Gateway Time-out" warning. This is not a serious issue: just go in your `User` -> `Saved history` menu, you will see your `Use Case 3-3 Lassa virus segment L` history running and you will be able to access it.

The workflow for Use Case 3-3 may take a long time. Be patient.

## History for Use Case 3-3 / Lassa virus, segment S
1. Stay in the history `Input data for Use Case 3-3`
- pick the workflow `Metavisitor: Workflow for Use Case 3-3` in the workflows menu. It is possible that the workflow manager complains about settings for the Trinity tool that is used in this workflow. This is a minor issue if happens: just edit the workflow, click on the tool `Trinity` and specify the number of processors accordingly to your computing infrastructure. Save the workflow and select the `run` option.
- Before Step 1, you have to specify some parameters at run time. For Lassa virus, the field `target_virus` has to be filled with `Lassa` and the field `reference_virus` has to be filled with `NC_004296.1` (as a guide for reconstruction of the segment S of the Lassa virus genome).
- For Step 1, select `Lassa virus` (this should be already selected).
- For Step 2, select the `nucleotide vir2 blast database` (this should also be already selected)
- As usual, check the box `Send results to a new history`, edit the name of the new history to `Use Case 3-3 Lassa virus segment S`, and `Execute` the workflow ! Note, that for complex workflows with dataset collections in input, the actual warning that the workflow is started make take time to show up; you can even have a "504 Gateway Time-out" warning. This is not a serious issue: just go in your `User` -> `Saved history` menu, you will see your `Use Case 3-3 Lassa virus segment S` history running and you will be able to access it.

The workflow for Use Case 3-3 may take a long time. Be patient.
