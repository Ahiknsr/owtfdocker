for file in $(ls owtf/dictionaries/fuzzdb/fuzzdb-1.09/Discovery/PredictableRes/ | grep raft); do
			ln -s owtf/dictionaries/fuzzdb/fuzzdb-1.09/Discovery/PredictableRes/$file owtf/dictionaries/restricted/raft/$file
			done
