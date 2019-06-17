Now that you are familiar with manipulations in Galaxy with the Use Cases 1-1 to 1-4 described in detail in the previous chapters, we will describe the other Use Case analyses more concisely. If you experience lack of skills in basic Galaxy operations (tool usage, copy of datasets, etc), do not hesitate to go back and examine the [previous chapters](use_cases_input_data) step by step.


## Input data for Use Case 3-1

As for the previous Use Cases 1 and 2, the first step is to collect all the input data in a history that we will name `Input data for Use Case 3-1`.

1. Create a new history
- Rename this history `Input data for Use Case 3-1`
- We are going to upload 40 datasets form the EBI ENA SRP068722 :
    - Go to the upload files menu and select `Choose FTP file`. Select file `3-1_Use-Case_SRR.txt` from the list then click the "Start" button.
    - Use the tool `Cut columns from table`. In the "Cut columns field" write `c1` and make sure you select "3-1_Use-Case_SRR.txt" file in the "From" field before executing. Rename the output "Use-Case_3-1_accessions.txt".
    - Use the tool `Extract reads in FASTQ/A format from NCBI SRA`, select `List of SRA accession, one per line`from `select input type` and "Use-Case_3-1_accessions.txt" in sra accession list. Click the `Execute` button.
    - When the tool is finished running you should have 2 new dataset collections in your history, one of them is empty. Delete the empty collection and verify that you have 40 pairs in the second collection.
    - If you are missing some sequences you just have to re-do the steps above with only the missing identifiers. Once done, merge the collections using the tool `Merge Collections`.
    - Rename the collection to `SRP068722`.
2. Copy the `vir2 nucleotide BLAST database` from the `References` history to the current history `Input data for Use Case 3-1`.
3. Now we still have to associate sequencing dataset coming from the same patient. We are going to use the tool `Tag elements from file` to add the patient information as metadata.
    - Click on the `Tag elements from file` tool and select the collection "SRP068722" in "Input Collection" and "3-1_Use-Case_SRR.txt" in "Tag collection elements according to this file". Execute the tool. Rename the new dataset collection `SRP068722_with_patient_information`.
    - Select the `Apply Rule to Collection` and set "SRP068722_with_patient_information" as "Input Collection". Click on the "Edit" button at the right of the form.
        - Click the "Column" button and select `Add Column from Metadata` from the list.
        - In the "From" list select "Tags". Then click the "Apply" button.
        - Click the "Rules" button and select `Add / Modify Colmn Definitions` from the list.
        - Click the "Add Definition" button and select the `List identifier(s)` from the list.
        - In the "Select a column" list select "B" then click on `... Assign Another Column` and select "A". Click the "Apply" button.
        - Click the "Save" and execute the tool.
        - Select the `Concatenate multiple datasets tail-to head` tool. In "What type of data do you wish to concatenate?" select "Nested collection". In "Input nested collection" select "SRP068722_with_patient_information (re-organized)". Execute the tool.
        - Rename the resulting collection patient collection.
4. We are done.

## History for Use Case 3-1
1. Stay in the history `Input data for Use Case 3-1`
- pick the workflow `Metavisitor: Workflow for Use Case 3-1` in the workflows menu, and select the `run` option.
- For Step 1 (Fever Patient Sequences collection), select `patient collection` (this should be already selected).
- For Step 2, select the `nucleotide vir1 blast database` (this should also be already selected)
- As usual, check the box `Send results to a new history`, edit the name of the new history to `History for Use Case 3-1`, and `Execute` the workflow ! Note, that for complex workflows with dataset collections in input, the actual warning that the workflow is started may take time to show up.
