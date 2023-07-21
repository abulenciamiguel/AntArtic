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
	tuple val(central_id), path(fasta)

	output:
	path "usherAligned.*.vcf", emit: usherAligned


	script:
	"""
	mafft --thread 20 --auto --keeplength --addfragments \
	$fasta \
	$params.usherDB > usherAligned.${central_id}.fasta


	faToVcf -includeNoAltN -maskSites=$params.usherProblemSites \
	usherAligned.${central_id}.fasta \
	usherAligned.${central_id}.vcf

	"""
}

