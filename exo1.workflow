#!/usr/bin/env nextflow

params.str = 'Hello world!'

process splitLetters {
	input:
	val str
	output:

	file 'chunk_*'
"""
printf '${str}' | split -b 6 - chunk_
"""

}

process convertToUpper {
	input:
	file x
	output:
	stdout

"""
cat $x | tr '[a-z]' '[A-Z]'

"""
}

workflow{
	str = params.str
	letters = splitLetters(str)
	l = letters.flatten()
	result=convertToUpper(l)
		result.view { it.trim() }
}
