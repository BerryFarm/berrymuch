

index: ../packages/
	cp index index.prev 
	ipfs add -q ../packages/*zip >> index.prev
	sort -u index.prev > index
	rm index.prev
