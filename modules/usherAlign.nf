process usherAlign {
	cpus 1

	container 'pathogengenomics/usher:latest'

	tag "Aligning sample $central_id"


	publishDir (
	path: "${params.out_dir}/usherAlignment",
	mode: "copy",
	overwrite: "true"
	)

	input:
	path fasta

	output:
	path "usherAligned.vcf", emit: usherAligned
	path "usherAligned.fasta"

	script:
	"""
	mafft --thread 20 --auto --keeplength --addfragments \
	$fasta \
	$params.usherDB > usherAligned.fasta


	faToVcf -includeNoAltN -maskSites=$params.usherProblemSites \
	usherAligned.fasta \
	usherAligned.vcf

	"""
}

