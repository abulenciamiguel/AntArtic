// enable dsl2
nextflow.enable.dsl=2


// import subworkflows
include {AntArtic} from './workflows/AntArtic.nf'





workflow {

	Channel
		.fromPath(params.sample_sheet)
		.set{ch_fasta}
	Channel
		.fromPath(params.sample_sheet)
		.splitCsv(header:true)
		.map{row-> tuple(row.central_ID, file(row.fasta))}
		.set{ch_fasta}

	main:
		AntArtic(ch_fasta)

}