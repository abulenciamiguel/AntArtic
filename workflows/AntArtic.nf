// enable dsl2
nextflow.enable.dsl=2


// import subworkflows
include {nextcladeDL} from '../modules/nextcladeDL.nf'
include {nextcladeLineage} from '../modules/nextcladeLineage.nf'
include {usherAlign} from '../modules/usherAlign.nf'
include {usherDL} from '../modules/usherDL.nf'
include {usherLineage} from '../modules/usherLineage.nf'



workflow AntArtic {

	take:
		ch_fasta


	main:
		nextcladeDL()
		nextcladeLineage(ch_fasta, nextcladeDL.out.nextclade_all)

		ch_fasta.collectFile(name: "allseq.fasta", newLine: true, storeDir: params.out_dir)
				.set{ch_combinedFASTA}
				
		usherAlign(ch_combinedFASTA)
		usherDL()
		//usherLineage(ch_fasta, usherDL.out.pb)
        
}