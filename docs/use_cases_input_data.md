We are now entering into real analyses using Metavisitor.
These analyses as well as their biological context are presented as **Use Cases** in the [metavisitor article](http://dx.doi.org/10.1101/048983). We invite readers of this manual to refer to this article if they need to better understand the biological context of the described procedures.

In this section, we are going to create step by step a Galaxy history that contains the input data required to run the workflows for Use Cases 1-1, 1-2, 1-3 and 1-4

# History with input data for Use Cases 1-1, 1-2, 1-3 and 1-4

1. Create a new history and rename it "Input data for Use Cases 1-1, 1-2, 1-3 and 1-4"
2. Get SRP013822 datasets list
    - Use the the tool `Upload File` and click on the `Choose FTP file` button
    - Select the `Galaxy_use_cases1-x_SRR_list.txt` and start the upload
3. Import SRP013822 datasets
    - Use the tool `Extract reads in FASTQ/A format from NCBI SRA` and select in the `select input type` list `List of SRA accession, one per line`
    - Select in the `sra accession list` the `Galaxy_use_cases_1-x_SRR_list.txt` and run the tool
4. Rename a dataset collection **SRP013822**
    - Click on the `Single-end data (fastqdump)` collection
    - Clock on the title (Single-end data (fastqdump)) and rename it SRP013822

5. Copy the vir2 blast database that we have prepared earlier in the [Reference](metavisitor_configure_references.md#3-prepare-blast-databases) history.
    - To do so, click on the little wheel icon in the history top menu (in the history right bar).

    ![copydataset](images/copydataset.png)

    - Select "Copy Datasets"
    - In the open page, select "References" in the Source History menu, check the "nucleotide vir2 blast database" dataset; select "Input data for Use Case 1_1, ..."; and click the "Copy History Items".
    - if you refresh the history, you will see the "nucleotide vir2 blast database" dataset showing up.

That is all for the moment. We will latter add datasets in the history `Input data for Use Cases 1-1, 1-2, 1-3 and 1-4`. However, these datasets do no exist yet: this will be produced by the Use Cases 1-1, 1-2, 1-3 workflows !
