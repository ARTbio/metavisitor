![metavisitor_logo](images/metavisitor_logo.png)


[Metavisitor](http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0168397) is
a user-friendly and adaptable software to provide biologists, clinical researchers and
possibly diagnostic clinicians with the ability to robustly detect and reconstruct viral
genomes from complex deep sequence datasets. A set of modular bioinformatic tools and
workflows was implemented as the Metavisitor package in the Galaxy framework. Using the
graphical Galaxy workflow editor, users with minimal computational skills can use existing
Metavisitor workflows or adapt them to suit specific needs by adding or modifying analysis
modules.

# Quick Start

Users who want to use Metavisitor on the [Galaxy Mississippi Server](https://mississippi.snv.jussieu.fr),
or got already the Metavisitor suite of tools installed in their own Galaxy server, can
jump to the next chapter [Prepare input data histories](use_cases_input_data).


## Availability of Metavisitor tools and workflows

Metavisitor has been developed at the [ARTbio platform](http://artbio.fr). Its tools are
primarily available in [GitHub] (https://github.com/ARTbio/tools-artbio). Its workflows are
primarily available in this
[metavisitor repository](https://github.com/ARTbio/metavisitor/tree/master/extra-files/metavisitor)
as well as in the [GalaxyKickStart repository](https://github.com/ARTbio/GalaxyKickStart/tree/master/extra-files/metavisitor)

#### Metavisitor tools developed by ARTbio in the [ARTbio GitHub](https://github.com/ARTbio/tools-artbio)

- [`blast_to_scaffold`](https://github.com/ARTbio/tools-artbio/tree/master/tools/blast_to_scaffold)
- [`blastx_to_scaffold`](https://github.com/ARTbio/tools-artbio/tree/master/tools/blastx_to_scaffold)
- [`cherry_pick_fasta`](https://github.com/ARTbio/tools-artbio/tree/master/tools/cherry_pick_fasta)
- [`concatenate_multiple_datasets`](https://github.com/ARTbio/tools-artbio/tree/master/tools/concatenate_multiple_datasets)
- [`fetch_fasta_from_ncbi`](https://github.com/ARTbio/tools-artbio/tree/master/tools/fetch_fasta_from_ncbi)
- [`msp_blastparser_and_hits`](https://github.com/ARTbio/tools-artbio/tree/master/tools/msp_blastparser_and_hits)
- [`msp_cap3`](https://github.com/ARTbio/tools-artbio/tree/master/tools/msp_cap3)
- [`msp_fasta_tabular_converter`](https://github.com/ARTbio/tools-artbio/tree/master/tools/msp_fasta_tabular_converter)
- [`msp_sr_bowtie`](https://github.com/ARTbio/tools-artbio/tree/master/tools/msp_sr_bowtie)
- [`msp_oases`](https://github.com/ARTbio/tools-artbio/tree/master/tools/msp_oases)
- [`small_rna_maps`](https://github.com/ARTbio/tools-artbio/tree/master/tools/small_rna_maps).
- [`yac_clipper`](https://github.com/ARTbio/tools-artbio/tree/master/tools/yac_clipper)

Other tools from other developers are used in the suite_metavisitor_2. These tools are
available from the [main Galaxy toolshed](https://toolshed.g2.bx.psu.edu/):

     name="bowtie2" owner="devteam"
     name="data_manager_bowtie2_index_builder" owner="devteam"
     name="data_manager_fetch_genome_dbkeys_all_fasta" owner="devteam"
     name="fasta_compute_length" owner="devteam"
     name="fasta_filter_by_length" owner="devteam"
     name="fastx_trimmer" owner="devteam"
     name="ncbi_blast_plus" owner="devteam"
     name="data_manager_bowtie_index_builder" owner="iuc"
     name="khmer_normalize_by_median" owner="iuc"
     name="sra_tools" owner="iuc"
     name="trinity" owner="iuc"
     name="vsearch" owner="iuc"
     name="regex_find_replace" owner="galaxyp"
     name="spades" owner="nml"

#### Availability of Metavisitor tools and workflows for **Galaxy instance administrators**

All metavisitor tools are available in the
[suite_metavisitor_2](https://toolshed.g2.bx.psu.edu/repository/browse_repositories?sort=name&operation=view_or_manage_repository&f-free-text-search=metavisitor&id=ca18473f5a7e691a#TODO: Change this link when the suite is published)
Galaxy Admin can just install this suite of tools by using the `Install new tools` menu in
their Admin panel, searching for "metavisitor", and installing the `suite_metavisitor_2`
tool suite.

Admins can also install the tools from the `metavisitor_workflows` repository, which will
provide in addition the metavisitors workflows.

#### Availability of Metavisitors workflows for any Galaxy instance user.
We have deposited the Metavisitors workflows in the
[myexperiment server](http://www.myexperiment.org/workflows #TODO: this will need to be updated too),
where they are searchable with "metavisitor" keyword and can be downloaded and reuploaded
to the Galaxy instance.

## Starting a Metavisitor Galaxy server from scratch

In the [last section](https://artbio.github.io/metavisitor/install_metavisitor/) of this
documentation, we provide instructions to set up Galaxy server instances *from scratch*
with *pre-installed* Metavisitor tools and workflows:

- Based on Ansible: see [Metavisitor with GalaxyKickstart (Ansible)](metavisitor_ansible.md)
- Based on Docker: see [Metavitor with Docker](metavisitor_docker.md)